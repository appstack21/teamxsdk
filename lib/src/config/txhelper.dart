import 'dart:math';

class TXHelper {}

extension MyDouble on double {
  double roundTo(int places) {
    var divisor = pow(10.0, places);
    return (this * divisor).round() / divisor;
  }
}
