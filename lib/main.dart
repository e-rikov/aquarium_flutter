import 'package:aquariumflutter/view/fish_list/fish_list_view.dart';
import 'package:flutter/material.dart';

void main() {
    runApp(MyApp());
}

class MyApp extends StatelessWidget {

    @override
    Widget build(BuildContext context) =>
        MaterialApp(
            title: 'Aquarium Flutter',
            theme: ThemeData(
                primarySwatch: Colors.blue,
            ),
            home: Scaffold(
                backgroundColor: Colors.blue,
                body: FishListView()
            ),
        );

}
