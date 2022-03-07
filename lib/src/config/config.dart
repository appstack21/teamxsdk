enum TXProductType {
  purchaseProtect,
  billProtect,
  bnplProtect,
  eventCancelation
}

//Country
enum TXCountry { singapore, hongKong }

extension TXCountryType on TXCountry {
  String getCurrency() {
    switch (this) {
      case TXCountry.singapore:
        return "S\$";
      case TXCountry.hongKong:
        return "HK\$";
    }
  }

  String get currency {
    switch (this) {
      case TXCountry.singapore:
        return "S\$";
      case TXCountry.hongKong:
        return "HK\$";
    }
  }

  double get taxation {
    switch (this) {
      case TXCountry.singapore:
        return 0.07;
      case TXCountry.hongKong:
        return 0.001;
    }
  }

  String get taxLabel {
    switch (this) {
      case TXCountry.singapore:
        return "GST";
      case TXCountry.hongKong:
        return "Levy";
    }
  }
}

enum TXPartnerType { dbs, yuu, grab, other }

class TXParnerCode {
  static const String dbs = "DB001";
  static const String yuu = "YU001";
  static const String grab = "GR001";
  static const String other = "OT001";
}
