import 'dart:math';
import 'dart:ui';

import 'package:aquariumflutter/core/tools/math_tools.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

    test("point is in rect", () {
        final rect = Rect.fromLTRB(-0.3, 0.3, 0.3, -0.3);
        expect(isInRect(0.1, 0.2, rect), equals(true));
    });

    test("point out of rect", () {
        final rect = Rect.fromLTRB(-0.3, 0.3, 0.3, -0.3);
        expect(isInRect(0.5, 0.2, rect), equals(false));
    });

    test("rect is in rect", () {
        final rect1 = Rect.fromLTRB(-0.3, 0.3, 0.3, -0.3);
        final rect2 = Rect.fromLTRB(-0.1, 0.1, 0.1, -0.1);
        expect(areRectsIntersect(rect1, rect2), equals(true));
    });

    test("rect vertex is in rect", () {
        final rect1 = Rect.fromLTRB(-0.3, 0.3, 0.3, -0.3);
        final rect2 = Rect.fromLTRB(-0.4, 0.4, -0.2, 0.2);
        expect(areRectsIntersect(rect1, rect2), equals(true));
    });

    test("two rect vertices are in rect", () {
        final rect1 = Rect.fromLTRB(-0.3, 0.3, 0.3, -0.3);
        final rect2 = Rect.fromLTRB(-0.4, 0.1, -0.2, -0.1);
        expect(areRectsIntersect(rect1, rect2), equals(true));
    });

    test("rect is out of rect", () {
        final rect1 = Rect.fromLTRB(-0.3, 0.3, 0.3, -0.3);
        final rect2 = Rect.fromLTRB(-0.6, 0.1, -0.4, -0.1);
        expect(areRectsIntersect(rect1, rect2), equals(false));
    });

  test("getIntersectionWithUnitSquare multy test", () {
      final input = [
          _TestData(sx: 0.1, sy: -0.3, dx: 0.8,   dy: 0.0,   rx: 1.0,  ry: -0.3),
          _TestData(sx: 0.0, sy: 0.0,  dx: 0.5,   dy: 0.25,  rx: 1.0,  ry: 0.5),
          _TestData(sx: 0.0, sy: 0.0,  dx: 0.5,   dy: 0.5,   rx: 1.0,  ry: 1.0),
          _TestData(sx: 0.0, sy: 0.0,  dx: 0.25,  dy: 0.5,   rx: 0.5,  ry: 1.0),
          _TestData(sx: 0.7, sy: 0.0,  dx: 0.0,   dy: 1.0,   rx: 0.7,  ry: 1.0),
          _TestData(sx: 0.0, sy: 0.0,  dx: -0.25, dy: 0.5,   rx: -0.5, ry: 1.0),
          _TestData(sx: 0.0, sy: 0.0,  dx: -0.5,  dy: 0.5,   rx: -1.0, ry: 1.0),
          _TestData(sx: 0.0, sy: 0.0,  dx: -0.5,  dy: 0.25,  rx: -1.0, ry: 0.5),
          _TestData(sx: 0.6, sy: -0.2, dx: -0.8,  dy: 0.0,   rx: -1.0, ry: -0.2),
          _TestData(sx: 0.0, sy: 0.0,  dx: -0.5,  dy: -0.25, rx: -1.0, ry: -0.5),
          _TestData(sx: 0.0, sy: 0.0,  dx: -0.73, dy: -0.73, rx: -1.0, ry: -1.0),
          _TestData(sx: 0.0, sy: 0.0,  dx: -0.25, dy: -0.5,  rx: -0.5, ry: -1.0),
          _TestData(sx: 0.3, sy: 0.0,  dx: 0.0,   dy: -1.0,  rx: 0.3,  ry: -1.0),
          _TestData(sx: 0.0, sy: 0.0,  dx: 0.2,   dy: -0.4,  rx: 0.5,  ry: -1.0),
          _TestData(sx: 0.0, sy: 0.0,  dx: 0.39,  dy: -0.39, rx: 1.0,  ry: -1.0),
          _TestData(sx: 0.0, sy: 0.0,  dx: 0.5,   dy: -0.25, rx: 1.0,  ry: -0.5)
      ];

      input.forEach((element) {
          final actualPoint = getIntersectionWithUnitSquare(
              sx: element.sx,
              sy: element.sy,
              dx: element.dx,
              dy: element.dy);

          final expectedPoint = Point(element.rx, element.ry);

          expect(
              actualPoint,
              equals(expectedPoint),
              reason: "ray with origin (${element.sx}, ${element.sy}) " +
                  "and direction (${element.dx}, ${element.dy}) " +
                  "does not intersect unit square in (${element.rx}, ${element.ry})");
      });
    });

}

class _TestData {

    final double sx;
    final double sy;
    final double dx;
    final double dy;
    final double rx;
    final double ry;

    _TestData({
        this.sx, this.sy,
        this.dx, this.dy,
        this.rx, this.ry});

}