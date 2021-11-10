import 'package:teamxsdk/models/partner.dart';
import 'package:teamxsdk/txhelper.dart';

import '../config.dart';

class TXInsuranceFeeManager {
  static double getInsuranceFee(TXPartnerInterface partner) {
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

    var amount = partner.amount;
    var pricingModel = partnerType.pricingModel(amount);
    var fee = 0.0;
    if (pricingModel == TXPricingModel.fixed) {
      fee = partnerType.getFixPremium(amount);
    } else {
      fee = partnerType.getVariablePremimum(amount);
    }

    var tax = partner.country.taxation.roundTo(3);

    var insuranceFee = fee + (fee * tax);
    insuranceFee = insuranceFee.roundTo(2);

    return insuranceFee;
  }

  static bool showModel(TXPartnerInterface partner) {
    var partnerType = TXHelper.getPartnerType(partner);
    return partnerType.showAgreementModel();
  }
}
