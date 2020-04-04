import 'package:aquariumflutter/core/fish/fish.dart';
import 'package:aquariumflutter/core/fish/fish_factory.dart';
import 'package:aquariumflutter/data/fish_list/fish_list_repo.dart';

class FishListRepoImpl implements FishListRepo {

    @override
    final fishList = List<Fish>();

    final FishFactory _fishFactory;


    FishListRepoImpl(this._fishFactory);


    @override
    Fish getRandomFish() => _fishFactory.create();

    @override
    dispose() {
        fishList.forEach((fish) {
            fish.dispose();
        });
    }

}