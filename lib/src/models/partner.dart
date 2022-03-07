// ignore: file_names
import 'package:teamxsdk/src/config/config.dart';
import 'package:teamxsdk/src/data_layer/data/entity/partner_model.dart';

abstract class TXBillDataInterFace {
  late String product;
  late double amount;
  late TXCountry country;
}

class TXBillData implements TXBillDataInterFace {
  @override
  double amount;

  @override
  TXCountry country;

  @override
  String product;

  TXProductCode get productCode {
    if (product == TXProductCode.purchaseProtect.productName) {
      return TXProductCode.purchaseProtect;
    } else if (product == TXProductCode.billProtect.productName) {
      return TXProductCode.billProtect;
    } else if (product == TXProductCode.bnplProtect.productName) {
      return TXProductCode.bnplProtect;
    } else {
      return TXProductCode.eventCancelation;
    }
  }

  TXBillData({
    required this.product,
    required this.amount,
    required this.country,
  });
}
