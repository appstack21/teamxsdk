// ignore: file_names
import 'package:teamxsdk/src/config/config.dart';
import 'package:teamxservice/teamxservice.dart';

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

  TXSProductCode get productCode {
    if (product == TXSProductCode.purchaseProtect.productName) {
      return TXSProductCode.purchaseProtect;
    } else if (product == TXSProductCode.billProtect.productName) {
      return TXSProductCode.billProtect;
    } else if (product == TXSProductCode.bnplProtect.productName) {
      return TXSProductCode.bnplProtect;
    } else {
      return TXSProductCode.eventCancelation;
    }
  }

  TXBillData({
    required this.product,
    required this.amount,
    required this.country,
  });
}
