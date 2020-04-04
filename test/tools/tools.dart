import 'dart:math';

import 'package:aquariumflutter/core/environment.dart';
import 'package:aquariumflutter/core/fish/fish.dart';
import 'package:mockito/mockito.dart';

import '../fish_view/mock_fish.dart';

Environment createEnvironment() => Environment(width: 1080.0, height: 1920.0);

Fish createMockFish({
    int size = 2,
    bool isAngry = false,
    double dx = 0.1,
    double dy = 0.1,
    Point<double> position = const Point(-0.3, 0.1),
    String image = "images/shark_3.png"
}) {
    final fish = MockFish();
    when(fish.dx).thenReturn(dx);
    when(fish.dy).thenReturn(dy);
    when(fish.isAngry).thenReturn(isAngry);
    when(fish.position).thenReturn(position);
    when(fish.image).thenReturn(image);
    when(fish.size).thenReturn(size);
    when(fish.canEat(any)).thenReturn(false);

    return fish;
}

List<Fish> createMockFishList(int count) {
    final fishList = List<Fish>();

    for (int i = 0; i < 10; i++) {
        fishList.add(createMockFish());
    }

    return fishList;
}