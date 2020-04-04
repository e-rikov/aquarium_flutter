import 'dart:math';

import 'package:aquariumflutter/core/app_settings.dart';
import 'package:aquariumflutter/core/fish/fish.dart';
import 'package:flutter/material.dart';

class FishView extends StatelessWidget {

    final Fish _fish;

    FishView(this._fish);

    @override
    Widget build(BuildContext context) {
        final angle = _fish.dx < 0.0 ? 0.0 : pi;
        final position = _fish.position;
        final alignment = Alignment(position.x, position.y);

        return Align(
            alignment: alignment,
            child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..rotateY(angle),
                child: Image(
                    width: _fish.size * FISH_WIDTH,
                    height: _fish.size * FISH_HEIGHT,
                    image: AssetImage(_fish.image)
                ),
            )
        );
    }

}
