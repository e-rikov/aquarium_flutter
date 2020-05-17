import 'dart:math';

import 'package:aquariumflutter/core/animation/movement_animation.dart';
import 'package:aquariumflutter/core/tools/math_tools.dart';
import 'package:aquariumflutter/core/tools/random_extentions.dart';

import 'animation_descriptor.dart';

class FishMovementAnimation implements MovementAnimation {

    Point<double> _position = Point(double.nan, double.nan);

    @override
    Point<double> get position => _position;

    double _dx;
    double _dy;

    @override
    double get dx => _dx;

    @override
    double get dy => _dy;

    final int _fishSize;
    final _random = Random();

    AnimationDescriptor _currentAnimationDescriptor;

    Function _onChangeListener;


    FishMovementAnimation(this._fishSize) {
        final animationState = _getNextAnimationDescriptor();
        _position = animationState.startPoint;
        _currentAnimationDescriptor = animationState;
    }


    @override
    dispose() {
        _removeOnChangeListener();
    }

    AnimationDescriptor _getNextAnimationDescriptor() {
        do {
            _dx = _random.getNextNormalizedDouble;
            _dy = _random.getNextNormalizedDouble;
        } while (_dx == 0.0 && _dy == 0.0);

        // Normalize direction:
        final l = sqrt(_dx*_dx + _dy*_dy) * 1000.0;
        final speedFactor = (3 - _fishSize + 1).toDouble();
        _dx *= speedFactor / l;
        _dy *= speedFactor / l;

        // Умножение на 0.8 нужно чтобы избежать появление рыбки у края:
        final resultStartPoint = _currentAnimationDescriptor != null
            ? _currentAnimationDescriptor.endPoint
            : Point<double>(
            _random.getNextNormalizedDouble * 0.8,
            _random.getNextNormalizedDouble * 0.8);

        final resultEndPoint = getIntersectionWithUnitSquare(
            sx: resultStartPoint.x,
            sy: resultStartPoint.y,
            dx: _dx,
            dy: _dy);

        return AnimationDescriptor(
            startPoint: resultStartPoint,
            endPoint: resultEndPoint,
            duration: -1);
    }

    @override
    Function get onChangeListener => _onChangeListener;

    @override
    void set onChangeListener(Function value) {
        _removeOnChangeListener();

        if (value != null) {
            _onChangeListener = value;
        }
    }

    _removeOnChangeListener() {
        _onChangeListener = null;
    }

    @override
    makeStep() {
        double x = _position.x + _dx;
        double y = _position.y + _dy;

        while ((x < -1.0) || (1.0 < x) || (y < -1.0) || (1.0 < y)) {
            _currentAnimationDescriptor = _getNextAnimationDescriptor();
            x = _currentAnimationDescriptor.startPoint.x;
            y = _currentAnimationDescriptor.startPoint.y;
        }

        _position = Point(x, y);
    }

}