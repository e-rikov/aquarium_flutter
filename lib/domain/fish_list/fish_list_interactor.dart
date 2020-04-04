import 'dart:async';

import 'package:aquariumflutter/core/app_settings.dart';
import 'package:aquariumflutter/core/timer_factory.dart';
import 'package:aquariumflutter/core/fish/fish.dart';
import 'package:aquariumflutter/data/fish_list/fish_list_repo.dart';

class FishListInteractor {

    final _fishListStreamController = StreamController<List<Fish>>();
    final Duration _fishAppearanceTime;

    FishListRepo _repo;

    Timer _timer;

    Stream<List<Fish>> get fishListStream => _fishListStreamController.stream;

    Function onChange;


    FishListInteractor(
        this._repo,
        this._fishAppearanceTime,
        TimerFactory timerFactory
    ) {
        for (int i = 0; i < MAX_FISH_COUNT; i++) {
            _addFish();
        }

        _postFishList();

        _timer = timerFactory.create(_makeStep);
    }


    dispose() {
        if (_timer.isActive) {
            _timer.cancel();
        }

        _repo.dispose();
    }

    _addFish() {
        final fish = _repo.getRandomFish();
        _repo.fishList.add(fish);
    }

    _handleIntersections() {
        int removedFishCount = 0;

        _repo.fishList.removeWhere((fish1) =>
            _repo.fishList.any((fish2) {
                if (fish2.canEat(fish1)) {
                    removedFishCount++;
                    return true;
                }

                return false;
            })
        );

        if (removedFishCount != 0) {
            _postFishList();

            Future.delayed(_fishAppearanceTime, () {
                for (int i = 0; i < removedFishCount; i++) {
                    _addFish();
                }

                _postFishList();
            });
        }
    }

    _makeStep() {
        _repo.fishList.forEach((fish) => fish.makeStep());
        _handleIntersections();
        onChange?.call();
    }

    _postFishList() {
        _fishListStreamController.sink.add(_repo.fishList);
    }

}
