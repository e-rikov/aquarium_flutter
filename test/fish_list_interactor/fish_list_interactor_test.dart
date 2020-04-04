import 'dart:async';
import 'dart:math';

import 'package:aquariumflutter/core/timer_factory.dart';
import 'package:aquariumflutter/core/fish/fish.dart';
import 'package:aquariumflutter/domain/fish_list/fish_list_interactor.dart';
import 'package:aquariumflutter/data/fish_list/fish_list_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../tools/tools.dart';
import 'mock_fish_list_repo.dart';

void main() {

    FishListRepo _repo;
    FishListInteractor _interactor;
    NoInteractionTimerFactory _timerFactory;

    _createInteractor(List<Fish> fishList) {
        final nonNullableFishList = fishList ?? createMockFishList(10);

        when(_repo.getRandomFish()).thenAnswer((_) =>
            nonNullableFishList.removeAt(0));

        _interactor = FishListInteractor(
            _repo,
            Duration(milliseconds: 100),
            _timerFactory);
    }

    setUp(() {
        _repo = MockFishListRepo();
        _timerFactory = NoInteractionTimerFactory();
        when(_repo.fishList).thenReturn(List<Fish>());
    });

    tearDown(() {
        _interactor.dispose();
    });

    test("repo.fishList contains 10 fishes after interactor creation", () {
        _createInteractor(null);
        expect(_repo.fishList.length, equals(10));
    });

    test("fishListStream emits 10 fishes after interactor creation", () {
        _createInteractor(null);
        expect(_interactor.fishListStream, emits(_repo.fishList));
    });

    test("no fish eats other fishes", () async {
        final resultList = List<List<Fish>>();

        _createInteractor(null);

        _interactor.fishListStream.listen((event) {
            resultList.add(event.toList());
        });

        _timerFactory.callback();

        expect(_repo.fishList.length, equals(10));

        await Future.delayed(Duration(seconds: 1));

        expect(resultList[0].length, equals(10));
        expect(resultList.length, equals(1));
    });

    test("one angry fish eats one fish", () async {
        final fishList = createMockFishList(10);
        final fish = createMockFish(isAngry: false, position: Point(0.9, 0.9));
        final angryFish = createMockFish(
            isAngry: true, position: Point(0.9, 0.9));
        final resultList = List<List<Fish>>();

        when(angryFish.canEat(fish)).thenReturn(true);

        fishList.insert(0, angryFish);
        fishList.insert(0, fish);
        _createInteractor(fishList);

        _interactor.fishListStream.listen((event) {
            resultList.add(event.toList());
        });

        _timerFactory.callback();

        expect(_repo.fishList.length, equals(9));

        await Future.delayed(Duration(seconds: 1));

        expect(_repo.fishList.length, equals(10));
        expect(resultList[1].length, equals(9));
        expect(resultList[2].length, equals(10));
    });

    test("dispose", () {
        _createInteractor(null);
        _interactor.dispose();

        verify(_repo.dispose());
        expect(_timerFactory.timer.isActive, equals(false));
    });

}

class NoInteractionTimerFactory implements TimerFactory {

    Function callback;
    Timer timer;

    @override
    Timer create(Function callback) {
        this.callback = callback;

        timer = Timer.periodic(
            Duration(seconds: 1),
            (timer) => {});

        return timer;
    }

}