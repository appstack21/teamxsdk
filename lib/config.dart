//Products
import 'package:teamxsdk/constants/constants.dart';

enum TXProductType {
  purchaseProtect,
  billProtect,
  bnplProtect,
  eventCancelation
}

extension TXProduct on TXProductType {
  String get description {
    switch (this) {
      case TXProductType.billProtect:
        return TXStringConstant.billProtectText;

      case TXProductType.bnplProtect:
        return TXStringConstant.cardTextBNPLProtect;

      case TXProductType.eventCancelation:
        return TXStringConstant.cardTextEventCanellationProtect;

      case TXProductType.purchaseProtect:
        return TXStringConstant.purchaseProtectText;
    }
  }

  String get productName {
    switch (this) {
      case TXProductType.purchaseProtect:
        return "Chubb Purchase Protect";

      case TXProductType.billProtect:
        return "Chubb Bill Protect";

      case TXProductType.bnplProtect:
        return "Chubb BNPL Protect";

      case TXProductType.eventCancelation:
        return "Chubb Event Cancellation Cover";
    }
  }

  String get cardText {
    switch (this) {
      case TXProductType.purchaseProtect:
        return TXStringConstant.cardTextPurchaseProtect;
      case TXProductType.billProtect:
        return TXStringConstant.cardTextBillProtect;
      case TXProductType.bnplProtect:
        return TXStringConstant.cardTextBNPLProtect;
      case TXProductType.eventCancelation:
        return TXStringConstant.cardTextEventCanellationProtect;
    }
  }
}

//Country
enum TXCountry { singapore, hongKong }

extension TXCountryType on TXCountry {
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

enum TXPricingModel { fixed, variable }
enum TXPartnerType { dbs, yuu, grab, other }

class TXParnerCode {
  static const String dbs = "DB001";
  static const String yuu = "YU001";
  static const String grab = "GR001";
  static const String other = "OT001";
}

extension Partner on TXPartnerType {
  TXPricingModel pricingModel(double amount) {
    switch (this) {
      case TXPartnerType.yuu:
        return TXPricingModel.fixed;
      default:
        if (amount > 500.00) {
          return TXPricingModel.variable;
        }
        return TXPricingModel.fixed;
    }
  }

  String get code {
    switch (this) {
      case TXPartnerType.yuu:
        return TXParnerCode.yuu;
      case TXPartnerType.grab:
        return TXParnerCode.grab;
      case TXPartnerType.dbs:
        return TXParnerCode.dbs;
      case TXPartnerType.other:
        return TXParnerCode.other;
    }
  }

  double getFixPremium(double amount) {
    double premimum = 2.0;
    switch (this) {
      case TXPartnerType.yuu:
        if (amount > 0 && amount <= 500) {
          premimum = 2.0;
        } else if (amount > 500.01 && amount <= 2000) {
          premimum = 5.0;
        } else if (amount > 2000.01 && amount <= 5000) {
          premimum = 10.0;
        } else if (amount > 5000.01 && amount <= 10000) {
          premimum = 20.0;
        } else {
          premimum = 2.0;
        }
        break;
      default:
        premimum = 5.0;
    }
    return premimum;
  }

  double getVariablePremimum(double amount) {
    double percentage = 0.1;
    percentage = percentage / 100;
    //check for partner
    double permium = amount * percentage;
    return permium;
  }

  String get agreementDescription {
    switch (this) {
      case TXPartnerType.yuu:
      case TXPartnerType.grab:
      case TXPartnerType.dbs:
      case TXPartnerType.other:
        return TXStringConstant.agreementInformationText;
    }
  }

  String get linkText {
    switch (this) {
      case TXPartnerType.yuu:
      case TXPartnerType.grab:
      case TXPartnerType.dbs:
      case TXPartnerType.other:
        return TXStringConstant.cardLinkTitle;
    }
  }

  String get agreeButtonTitle {
    switch (this) {
      case TXPartnerType.yuu:
      case TXPartnerType.grab:
      case TXPartnerType.dbs:
      case TXPartnerType.other:
        return TXStringConstant.agreeButtonTitle;
    }
  }

  String get cancelButtonText {
    switch (this) {
      case TXPartnerType.yuu:
      case TXPartnerType.grab:
      case TXPartnerType.dbs:
      case TXPartnerType.other:
        return TXStringConstant.cancelButtonTitle;
    }
  }

  bool showAgreementModel() {
    switch (this) {
      case TXPartnerType.yuu:
      case TXPartnerType.grab:
      case TXPartnerType.dbs:
      case TXPartnerType.other:
        return true;
    }
  }
}
