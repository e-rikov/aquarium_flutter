import 'package:aquariumflutter/core/animation/movement_animation.dart';
import 'package:aquariumflutter/core/animation/movement_animation_factory.dart';

import 'fish_movement_animation.dart';

class FishMovementAnimationFactory implements MovementAnimationFactory {

    MovementAnimation create(int fishSize) => FishMovementAnimation(fishSize);

}