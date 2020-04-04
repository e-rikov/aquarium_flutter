import 'dart:async';

import 'package:aquariumflutter/core/timer_factory.dart';
import 'package:aquariumflutter/core/tools/time_extentions.dart';

class FishListInteractionTimerFactory implements TimerFactory {

    @override
    Timer create(Function callback) =>
        Timer.periodic(
            20.milliseconds,
                (timer) => callback());

}