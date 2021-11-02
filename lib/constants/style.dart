import 'package:flutter/material.dart';

class TXTextStyle {
  static TextStyle? getTextStyle(
      {required double size,
      required FontWeight weight,
      required Color color}) {
    return TextStyle(
      fontSize: size,
      fontWeight: weight,
      color: color,
    );
  }
}

class TXFonts {
  static String avenirNextRegular = "AvenirNext-Regular";
  static String avenirNextDemiBold = "AvenirNext-DemiBold";
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color? fromHex(String? hexString) {
    if (hexString == null) {
      return null;
    }
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

class TXColor {
  static var cardBackGroundColor = Colors.white;
  // ignore: prefer_const_constructors
  static var cardBorderColor = Color(0x00848a91);
  // ignore: prefer_const_constructors
  static var cardInformationColor = Color(0x00171822);
}
