import 'dart:math';

import 'package:aquariumflutter/core/animation/movement_animation.dart';
import 'package:aquariumflutter/core/environment.dart';
import 'package:aquariumflutter/core/tools/math_tools.dart';
import 'package:aquariumflutter/core/tools/random_extentions.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

import 'package:aquariumflutter/core/tools/time_extentions.dart';

import 'animation_descriptor.dart';

class FishMovementAnimation implements MovementAnimation {

    @override
    Point<double> get position =>
        _animation?.value ?? Point(double.nan, double.nan);

    double _dx;
    double _dy;

    @override
    double get dx => _dx;

    @override
    double get dy => _dy;

    AnimationController _animationController;
    Animation _animation;

    final int _fishSize;
    final Environment _environment;
    final _random = Random();

    AnimationDescriptor _currentAnimationDescriptor;

    Function _onChangeListener;


    FishMovementAnimation({
        int fishSize,
        Environment environment,
        TickerProvider tickerProvider
    }):
        _fishSize = fishSize,
        _environment = environment
    {
        final animationState = _getNextAnimationDescriptor();

        _animationController = AnimationController(
            duration: animationState.duration.seconds,
            vsync: tickerProvider);

        _animationController.forward();

        final tween = Tween<Point<double>>(
            begin: animationState.startPoint,
            end: animationState.endPoint);

        _animation = tween.animate(_animationController)
            ..addStatusListener((status) {
                if (status == AnimationStatus.completed) {
                    final nextAnimationState = _getNextAnimationDescriptor();
                    tween.begin = nextAnimationState.startPoint;
                    tween.end = nextAnimationState.endPoint;
                    _animationController.reset();
                    _animationController.duration =
                        nextAnimationState.duration.seconds;
                    _animationController.forward();
                }
            });
    }


    @override
    dispose() {
        _animationController.dispose();
        _removeOnChangeListener();
    }

    AnimationDescriptor _getNextAnimationDescriptor() {
        do {
            _dx = _random.getNextNormalizedDouble();
            _dy = _random.getNextNormalizedDouble();
        } while (_dx == 0.0 && _dy == 0.0);

        // Умножение на 0.8 нужно чтобы избежать появление рыбки у края:
        final resultStartPoint = _currentAnimationDescriptor != null
            ? _currentAnimationDescriptor.endPoint
            : Point<double>(
            _random.getNextNormalizedDouble() * 0.8,
            _random.getNextNormalizedDouble() * 0.8);

        final resultEndPoint = getIntersectionWithUnitSquare(
            sx: resultStartPoint.x,
            sy: resultStartPoint.y,
            dx: _dx,
            dy: _dy);

        final d = _distance(resultStartPoint, resultEndPoint);
        final duration = (d * 10.0 / 2.0 * _fishSize).toInt();

        _currentAnimationDescriptor = AnimationDescriptor(
            startPoint: resultStartPoint,
            endPoint: resultEndPoint,
            duration: duration);

        return _currentAnimationDescriptor;
    }

    double _distance(Point<double> startPoint, Point<double> endPoint) {
        double dx = startPoint.x - endPoint.x;
        double dy = startPoint.y - endPoint.y;

        if (_environment.width < _environment.height) {
            dy = _environment.height * dy / _environment.width;
        } else {
            dx = _environment.width * dx / _environment.height;
        }

        return sqrt(dx * dx + dy * dy);
    }

    @override
    Function get onChangeListener => _onChangeListener;

    @override
    void set onChangeListener(Function value) {
        _removeOnChangeListener();

        if (value != null) {
            _onChangeListener = value;
            _animation?.addListener(value);
        }
    }

    _removeOnChangeListener() {
        final onChangeListener = _onChangeListener;
        _onChangeListener = null;

        if (onChangeListener != null) {
            _animation.removeListener(onChangeListener);
        }
    }

    @override
    makeStep() {
        // Not implemented.
    }

}