import 'package:aquariumflutter/core/animation/movement_animation.dart';
import 'package:aquariumflutter/core/animation/movement_animation_factory.dart';
import 'package:aquariumflutter/core/environment.dart';
import 'package:flutter/material.dart';

import 'fish_movement_animation.dart';

class FishMovementAnimationFactory implements MovementAnimationFactory {

    TickerProvider _tickerProvider;
    Environment _environment;

    FishMovementAnimationFactory(this._tickerProvider, this._environment);

    MovementAnimation create(int fishSize) =>
        FishMovementAnimation(
            fishSize: fishSize,
            environment: _environment,
            tickerProvider: _tickerProvider);

}