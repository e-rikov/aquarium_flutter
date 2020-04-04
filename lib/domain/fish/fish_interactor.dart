import 'dart:math';
import 'dart:ui';

import 'package:aquariumflutter/core/animation/movement_animation.dart';
import 'package:aquariumflutter/core/app_settings.dart';
import 'package:aquariumflutter/core/environment.dart';
import 'package:aquariumflutter/core/fish/fish.dart';
import 'package:aquariumflutter/core/tools/math_tools.dart';

class FishInteractor implements Fish {

    MovementAnimation _movementAnimation;
    Environment _environment;

    @override
    double get dx => _movementAnimation?.dx ?? 0.0;

    @override
    double get dy => _movementAnimation?.dy ?? 0.0;

    @override
    final String image;

    @override
    final bool isAngry;

    @override
    Point<double> get position =>
        _movementAnimation?.position ?? Point(double.nan, double.nan);

    @override
    final int size;


    FishInteractor({
        this.size,
        this.isAngry,
        this.image,
        MovementAnimation movementAnimation,
        Environment environment
    }):
        _movementAnimation = movementAnimation,
        _environment = environment;


    @override
    makeStep() {
        // Not implemented.
    }

    @override
    bool canEat(Fish fish) {
        final currentPosition = position;
        final fishPosition = fish.position;

        if (isAngry &&
            currentPosition.x != double.nan &&
            currentPosition.y != double.nan &&
            fishPosition.x != double.nan && fishPosition.y != double.nan
        ) {
            final eatIfAngry = fish.isAngry && fish.size < size;
            final eatIfNotAngry = !fish.isAngry && fish.size <= size + 1;

            if ((eatIfAngry || eatIfNotAngry) &&
                _isIntersect(currentPosition, fishPosition, fish.size)
            ) {
                return true;
            }
        }

        return false;
    }

    bool _isIntersect(Point<double> currentPosition,
        Point<double> fishPosition,
        int fishSize
    ) {
        final width1 = fishSize * FISH_WIDTH / _environment.width;
        final height1 = fishSize * FISH_HEIGHT / _environment.height;
        final width2 = size * FISH_WIDTH / _environment.width;
        final height2 = size * FISH_HEIGHT / _environment.height;

        final rect1 = Rect.fromLTRB(
            fishPosition.x - width1,
            fishPosition.y + height1,
            fishPosition.x + width1,
            fishPosition.y - height1);

        final rect2 = Rect.fromLTRB(
            currentPosition.x - width2,
            currentPosition.y + height2,
            currentPosition.x + width2,
            currentPosition.y - height2);

        return areRectsIntersect(rect1, rect2);
    }

    @override
    dispose() {
        _movementAnimation?.dispose();
        _movementAnimation = null;
    }

    @override
    Function get onChangeListener => _movementAnimation?.onChangeListener;

    @override
    void set onChangeListener(Function value) {
        _movementAnimation?.onChangeListener = value;
    }

}