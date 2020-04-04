import 'package:aquariumflutter/core/fish/fish.dart';
import 'package:aquariumflutter/core/fish/fish_factory.dart';
import 'package:aquariumflutter/data/fish_list/fish_list_repo.dart';
import 'package:aquariumflutter/data_impl/fish_list/fish_list_repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../fish_view/mock_fish.dart';
import 'mock_fish_factory.dart';

void main() {

    FishFactory _fishFactory;
    FishListRepo _repo;

    setUp(() {
        _fishFactory = MockFishFactory();
        when(_fishFactory.create()).thenReturn(MockFish());

        _repo = FishListRepoImpl(_fishFactory);
    });

    test("repos getRandomFish calls _fishFactory.create()", () {
        _repo.getRandomFish();

        verify(_fishFactory.create());
    });

    test("dispose calls dispose of all fishes in fishList", () {
        final fishList = List<Fish>(10);

        for (int i = 0; i < 10; i++) {
            fishList[i] = MockFish();
        }

        _repo.fishList.addAll(fishList);
        _repo.dispose();

        fishList.forEach((fish) {
            verify(fish.dispose());
        });
    });

}