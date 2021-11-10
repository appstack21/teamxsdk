import 'dart:math';

import 'package:teamxsdk/config.dart';
import 'package:teamxsdk/configurator.dart';
import 'package:teamxsdk/models/partner.dart';
import 'package:flutter/material.dart';

class TXHelper {
  static String getTitleText(TXPartnerInterface partner) {
    return partner.productCode.description;
  }

  static String getInsuranceInfoMessage(TXPartnerInterface partner) {
    var message = partner.productCode.cardText;
    return message;
  }

  static String getCurrency(TXCountry country) {
    var currency = country.currency;
    return currency;
  }

  static String getProductName(TXPartnerInterface partner) {
    return partner.productCode.name;
  }

  static String getAgreementDesctiptionText(TXPartnerInterface partner) {
    var partnerType = getPartnerType(partner);
    return partnerType.agreementDescription;
  }

  static TXPartnerType getPartnerType(TXPartnerInterface partner) {
    var code = partner.partnerCode;
    var partnerType = TXPartnerType.other;
    switch (code) {
      case TXParnerCode.yuu:
        partnerType = TXPartnerType.yuu;
        break;
      case TXParnerCode.grab:
        partnerType = TXPartnerType.grab;
        break;
      case TXParnerCode.dbs:
        partnerType = TXPartnerType.dbs;
        break;
      default:
        break;
    }
    return partnerType;
  }
}

extension MyDouble on double {
  double roundTo(int places) {
    var divisor = pow(10.0, places);
    return (this * divisor).round() / divisor;
  }
}
