import 'package:flutter_test/flutter_test.dart';

import 'package:aquariumflutter/core/tools/time_extentions.dart';

void main() {

    test("milliseconds", () {
        expect(25.milliseconds, equals(Duration(milliseconds: 25)));
    });

    test("seconds", () {
        expect(15.seconds, equals(Duration(seconds: 15)));
    });

}