import 'dart:math';

import 'package:aquariumflutter/core/animation/movement_animation_factory.dart';
import 'package:aquariumflutter/core/environment.dart';
import 'package:aquariumflutter/core/fish/fish.dart';
import 'package:aquariumflutter/core/fish/fish_factory.dart';

import '../../domain/fish/fish_interactor.dart';

class FishFactoryImpl implements FishFactory {

    final _random = Random();

    MovementAnimationFactory _movementAnimationFactory;
    Environment _environment;


    FishFactoryImpl(this._movementAnimationFactory, this._environment);


    @override
    Fish create() {
        final fishSize = _random.nextInt(3) + 1;
        final isAngry = _random.nextBool();
        final movementAnimation = _movementAnimationFactory.create(fishSize);

        return FishInteractor(
            size: fishSize,
            isAngry: isAngry,
            image: _initImage(isAngry),
            movementAnimation: movementAnimation,
            environment: _environment);
    }

    String _initImage(bool isAngry) {
        final type = _random.nextInt(3);

        if (isAngry) {
            switch (type) {
                case 0: return "images/shark_1.png";
                case 1: return "images/shark_2.png";
                default: return "images/shark_3.png";
            }
        } else {
            switch (type) {
                case 0: return "images/fish_1.png";
                case 1: return "images/fish_2.png";
                default: return "images/fish_3.png";
            }
        }
    }

}