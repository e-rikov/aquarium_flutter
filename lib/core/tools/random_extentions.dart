import 'dart:math';

extension RandomExtentions on Random {

    get getNextNormalizedDouble => (this.nextDouble() - 0.5) * 2.0;

}