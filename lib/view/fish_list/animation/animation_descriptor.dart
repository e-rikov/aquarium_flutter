import 'dart:math';

class AnimationDescriptor {

    final Point<double> startPoint;
    final Point<double> endPoint;
    final int duration;
    final double dx;
    final double dy;

    AnimationDescriptor({
        this.startPoint,
        this.endPoint,
        this.dx,
        this.dy,
        this.duration
    });

}