import 'dart:math';

import 'package:aquariumflutter/core/animation/movement_animation.dart';
import 'package:aquariumflutter/core/fish/fish.dart';
import 'package:aquariumflutter/domain/fish/fish_interactor.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../fish_factory_impl/mock_movement_animation.dart';
import '../tools/tools.dart';

void main() {
    Fish _createFish(
        int fishSize,
        bool isAngry,
        MovementAnimation movementAnimation
    ) =>
        FishInteractor(
            size: fishSize,
            isAngry: isAngry,
            image: "",
            movementAnimation: movementAnimation,
            environment: createEnvironment());

    test("not angry fish does not eat fish", () {
        final movementAnimation1 = MockMovementAnimation();
        final movementAnimation2 = MockMovementAnimation();
        final fish1 = _createFish(3, false, movementAnimation1);
        final fish2 = _createFish(3, false, movementAnimation2);

        when(movementAnimation1.position).thenReturn(Point(0.7, 0.7));
        when(movementAnimation2.position).thenReturn(Point(0.7, 0.7));

        expect(fish1.canEat(fish2), equals(false));
    });

    test("two fishes are far from each other", () {
        final movementAnimation1 = MockMovementAnimation();
        final movementAnimation2 = MockMovementAnimation();
        final fish1 = _createFish(3, true, movementAnimation1);
        final fish2 = _createFish(3, false, movementAnimation2);

        when(movementAnimation1.position).thenReturn(Point(0.7, 0.7));
        when(movementAnimation2.position).thenReturn(Point(-0.7, -0.7));

        expect(fish1.canEat(fish2), equals(false));
    });

    test("angry fish eats not angry fish equal size", () {
        final movementAnimation1 = MockMovementAnimation();
        final movementAnimation2 = MockMovementAnimation();
        final fish1 = _createFish(3, true, movementAnimation1);
        final fish2 = _createFish(3, false, movementAnimation2);

        when(movementAnimation1.position).thenReturn(Point(0.7, 0.7));
        when(movementAnimation2.position).thenReturn(Point(0.7, 0.7));

        expect(fish1.canEat(fish2), equals(true));
    });

    test("angry fish does not eat angry fish equal size", () {
        final movementAnimation1 = MockMovementAnimation();
        final movementAnimation2 = MockMovementAnimation();
        final fish1 = _createFish(3, true, movementAnimation1);
        final fish2 = _createFish(3, false, movementAnimation2);

        when(movementAnimation1.position).thenReturn(Point(0.7, 0.7));
        when(movementAnimation2.position).thenReturn(Point(0.7, 0.7));

        expect(fish1.canEat(fish2), equals(true));
    });

    test("bigger angry fish eats smoller angry fish", () {
        final movementAnimation1 = MockMovementAnimation();
        final movementAnimation2 = MockMovementAnimation();
        final fish1 = _createFish(3, true, movementAnimation1);
        final fish2 = _createFish(2, true, movementAnimation2);

        when(movementAnimation1.position).thenReturn(Point(0.7, 0.7));
        when(movementAnimation2.position).thenReturn(Point(0.7, 0.7));

        expect(fish1.canEat(fish2), equals(true));
    });

    test("bigger angry fish eats smoller not angry fish", () {
        final movementAnimation1 = MockMovementAnimation();
        final movementAnimation2 = MockMovementAnimation();
        final fish1 = _createFish(3, true, movementAnimation1);
        final fish2 = _createFish(2, false, movementAnimation2);

        when(movementAnimation1.position).thenReturn(Point(0.7, 0.7));
        when(movementAnimation2.position).thenReturn(Point(0.7, 0.7));

        expect(fish1.canEat(fish2), equals(true));
    });

    test("smoller angry fish eats size+1 not angry fish", () {
        final movementAnimation1 = MockMovementAnimation();
        final movementAnimation2 = MockMovementAnimation();
        final fish1 = _createFish(1, true, movementAnimation1);
        final fish2 = _createFish(2, false, movementAnimation2);

        when(movementAnimation1.position).thenReturn(Point(0.7, 0.7));
        when(movementAnimation2.position).thenReturn(Point(0.7, 0.7));

        expect(fish1.canEat(fish2), equals(true));
    });

    test("smoller angry fish does not eat size+2 not angry fish", () {
        final movementAnimation1 = MockMovementAnimation();
        final movementAnimation2 = MockMovementAnimation();
        final fish1 = _createFish(1, true, movementAnimation1);
        final fish2 = _createFish(3, false, movementAnimation2);

        when(movementAnimation1.position).thenReturn(Point(0.7, 0.7));
        when(movementAnimation2.position).thenReturn(Point(0.7, 0.7));

        expect(fish1.canEat(fish2), equals(false));
    });

    test("smoller angry fish does not eat bigger angry fish", () {
        final movementAnimation1 = MockMovementAnimation();
        final movementAnimation2 = MockMovementAnimation();
        final fish1 = _createFish(1, true, movementAnimation1);
        final fish2 = _createFish(2, true, movementAnimation2);

        when(movementAnimation1.position).thenReturn(Point(0.7, 0.7));
        when(movementAnimation2.position).thenReturn(Point(0.7, 0.7));

        expect(fish1.canEat(fish2), equals(false));
    });

    test("fish gets position and direction vector from movement view.fish_list.animation", () {
        final movementAnimation = MockMovementAnimation();
        final fish = _createFish(2, true, movementAnimation);

        when(movementAnimation.position).thenReturn(Point(-0.7, 0.3));
        when(movementAnimation.dx).thenReturn(0.9);
        when(movementAnimation.dy).thenReturn(-0.5);

        expect(fish.position, equals(Point(-0.7, 0.3)));
        expect(fish.dx, equals(0.9));
        expect(fish.dy, equals(-0.5));
    });

    test("movement view.fish_list.animation dispose() is called on fish dispose()", () {
        final movementAnimation = MockMovementAnimation();
        final fish = _createFish(2, true, movementAnimation);

        fish.dispose();

        verify(movementAnimation.dispose());
    });
}