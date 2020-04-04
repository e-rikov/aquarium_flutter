import 'dart:math';

import 'package:aquariumflutter/core/app_settings.dart';
import 'package:aquariumflutter/view/fish/fish_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../tools/tools.dart';

void main() {

    testWidgets('fish moves from riht to left', (WidgetTester tester) async {
        final fish = createMockFish(dx: 0.5);
        final matrix = Matrix4.identity()..rotateY(pi);

        await tester.pumpWidget(FishView(fish));

        final widget = find.byWidgetPredicate((Widget widget) =>
            widget is Transform && widget.transform == matrix);

        expect(widget, findsOneWidget);
    });

    testWidgets('fish moves from left to riht', (WidgetTester tester) async {
        final fish = createMockFish(dx: -0.5);
        final matrix = Matrix4.identity()..rotateY(0.0);

        await tester.pumpWidget(FishView(fish));

        final widget = find.byWidgetPredicate((Widget widget) =>
            widget is Transform && widget.transform == matrix);

        expect(widget, findsOneWidget);
    });

    testWidgets(
        'view alligns with fish coordinates', (WidgetTester tester) async {
        final fish = createMockFish(position: Point(0.75, -0.21));
        final alignment = Alignment(0.75, -0.21);

        await tester.pumpWidget(FishView(fish));

        final widget = find.byWidgetPredicate((Widget widget) =>
            widget is Align && widget.alignment == alignment);

        expect(widget, findsOneWidget);
    });

    testWidgets(
        'view size is proportional fish size', (WidgetTester tester) async {
        final fish = createMockFish(size: 3);

        await tester.pumpWidget(FishView(fish));

        final widget = find.byWidgetPredicate((Widget widget) =>
            widget is Image &&
                widget.width == 3 * FISH_WIDTH &&
                widget.height == 3 * FISH_HEIGHT);

        expect(widget, findsOneWidget);
    });

    testWidgets('view loads image from asset with fish.image name', (
        WidgetTester tester) async {
        final fish = createMockFish(image: "images/fish_2.png");
        final image = AssetImage("images/fish_2.png");

        await tester.pumpWidget(FishView(fish));

        final widget = find.byWidgetPredicate((Widget widget) =>
            widget is Image && widget.image == image);

        expect(widget, findsOneWidget);
    });

}