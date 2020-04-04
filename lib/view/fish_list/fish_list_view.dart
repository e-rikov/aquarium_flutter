import 'package:aquariumflutter/core/app_settings.dart';
import 'package:aquariumflutter/core/environment.dart';
import 'package:aquariumflutter/core/fish/fish.dart';
import 'animation/fish_movement_animation_factory.dart';
import 'package:aquariumflutter/view/fish/fish_view.dart';
import 'package:aquariumflutter/data_impl/fish_list/fish_factory_impl.dart';
import 'package:aquariumflutter/domain/fish_list/fish_list_interaction_timer_factory.dart';
import 'package:aquariumflutter/data_impl/fish_list/fish_list_repo_impl.dart';
import 'package:aquariumflutter/domain/fish_list/fish_list_interactor.dart';
import 'package:aquariumflutter/core/tools/time_extentions.dart';
import 'package:flutter/material.dart';

class FishListView extends StatefulWidget {

    @override
    State<StatefulWidget> createState() => _FishListState();

}

class _FishListState extends State<FishListView> {

    FishListInteractor _interactor;

    @override
    void initState() {
        super.initState();

        Future.delayed(Duration.zero, () {
            setState(() {
                final environment = Environment(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height);

                final animationFactory = FishMovementAnimationFactory();
                final fishFactory = FishFactoryImpl(animationFactory, environment);
                final repo = FishListRepoImpl(fishFactory);

                _interactor = FishListInteractor(
                    repo,
                    FISH_APPEARANCE_TIME_IN_SECONDS.seconds,
                    FishListInteractionTimerFactory());

                _interactor.onChange = () => setState(() {});
            });
        });
    }

    @override
    Widget build(BuildContext context) =>
        _interactor != null
            ? _buildAquarium()
            : _buildProgress();

    Widget _buildProgress() =>
        const Center(
            child: CircularProgressIndicator(backgroundColor: Colors.white),
        );

    Widget _buildAquarium() =>
        StreamBuilder<List<Fish>>(
            stream: _interactor.fishListStream,
            builder: (context, snapshot) {
                final fishList = snapshot.data ?? List();

                return Stack(
                    children: fishList
                        .map((fish) => FishView(fish))
                        .toList(),
                );
            });

    @override
    void dispose() {
        _interactor.dispose();
        super.dispose();
    }

}