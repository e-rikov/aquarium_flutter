import 'dart:math';

import 'package:aquariumflutter/core/animation/movement_animation.dart';
import 'package:aquariumflutter/core/animation/movement_animation_factory.dart';
import 'package:aquariumflutter/core/fish/fish_factory.dart';
import 'package:aquariumflutter/data_impl/fish_list/fish_factory_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../tools/tools.dart';
import 'mock_movement_animation.dart';

void main() {

    MovementAnimation _animation;
    MovementAnimationFactory _animationFactory;
    FishFactory _fishFactory;

    setUp(() {
        _animation = MockMovementAnimation();
        _animationFactory = MockMovementAnimationFactory();

        _fishFactory = FishFactoryImpl(
            _animationFactory,
            createEnvironment()
        );
    });

    test("fish creation", () {
        when(_animation.dx).thenReturn(0.5);
        when(_animation.dy).thenReturn(0.7);
        when(_animation.position).thenReturn(Point(-0.3, 0.9));
        when(_animationFactory.create(any)).thenReturn(_animation);

        final fish = _fishFactory.create();

        expect(fish.size, anyOf(equals(1), equals(2), equals(3)));
        expect(fish.dx, equals(0.5));
        expect(fish.dy, equals(0.7));
        expect(fish.position, equals(Point(-0.3, 0.9)));

        expect(fish.image, anyOf(
            equals("images/shark_1.png"),
            equals("images/shark_2.png"),
            equals("images/shark_3.png"),
            equals("images/fish_1.png"),
            equals("images/fish_2.png"),
            equals("images/fish_3.png")
        ));
    });

}