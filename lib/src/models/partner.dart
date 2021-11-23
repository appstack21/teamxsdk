// ignore: file_names
import 'package:teamxsdk/src/config/config.dart';

abstract class TXPartnerInterface {
  late String partnerCode;
  late TXProductType productCode;
  late double amount;
  late TXCountry country;
}

class TXPartner implements TXPartnerInterface {
  @override
  double amount;

  @override
  TXCountry country;

  @override
  String partnerCode;

  @override
  TXProductType productCode;

  TXPartner(
      {required this.partnerCode,
      required this.country,
      required this.productCode,
      required this.amount});
}
