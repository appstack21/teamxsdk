import 'package:teamxsdk/src/config/config.dart';
import 'package:teamxsdk/src/config/txhelper.dart';
import 'package:teamxsdk/src/data_layer/data/entity/partner_model.dart';
import 'package:teamxsdk/src/models/partner.dart';

class TXInsuranceFeeManager {
  static double getInsuranceFee(
      {required TXPartner partner, required TXBillData billData}) {
    var amount = billData.amount;
    var pricingModel = partner.getPricingModel(amount);
    var fee = 0.0;
    if (pricingModel == TXPricingModel.fixed) {
      fee = partner.getFixPremium(amount);
    } else {
      fee = partner.getVariablePremimum(amount);
    }

    var tax = billData.country.taxation.roundTo(3);

    var insuranceFee = fee + (fee * tax);
    insuranceFee = insuranceFee.roundTo(2);

    return insuranceFee;
  }
}
