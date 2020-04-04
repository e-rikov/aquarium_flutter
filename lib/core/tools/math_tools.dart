import 'dart:math';
import 'dart:ui';

bool areRectsIntersect(Rect rect1, Rect rect2) =>
    isInRect(rect1.left, rect1.top, rect2) ||
        isInRect(rect1.left, rect1.bottom, rect2) ||
        isInRect(rect1.right, rect1.top, rect2) ||
        isInRect(rect1.right, rect1.bottom, rect2) ||
        isInRect(rect2.left, rect2.top, rect1) ||
        isInRect(rect2.left, rect2.bottom, rect1) ||
        isInRect(rect2.right, rect2.top, rect1) ||
        isInRect(rect2.right, rect2.bottom, rect1);

bool isInRect(double x, double y, Rect rect) =>
    x >= rect.left && x < rect.right && y >= rect.bottom && y < rect.top;

Point<double> getIntersectionWithUnitSquare({
    final double sx,
    final double sy,
    final double dx,
    final double dy
}) {
    double finX;
    double finY;

    if (dx == 0.0) {
        finX = sx;
        finY = dy < 0.0 ? -1.0 : 1.0;
    } else if (dy == 0.0) {
        finX = dx < 0.0 ? -1.0 : 1.0;
        finY = sy;
    } else {
        if (dx < 0.0) {
            finX = -1.0;
            finY = sy - (1.0 + sx) * dy / dx;
        } else {
            finX = 1.0;
            finY = sy + (1.0 - sx) * dy / dx;
        }

        if (1.0 < finY.abs()) {
            if (dy < 0.0) {
                finY = -1.0;
                finX = sx + (-1.0 - sy) * dx / dy;
            } else {
                finY = 1.0;
                finX = sx + (1.0 - sy) * dx / dy;
            }
        }
    }

    return Point<double>(finX, finY);
}