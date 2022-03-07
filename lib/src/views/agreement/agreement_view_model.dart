import 'package:teamxsdk/src/data_layer/data/entity/partner_model.dart';
import 'package:teamxsdk/teamxsdk.dart';

class TXAgreementViewModel {
  final TXBillData billData;
  final TXPartner partner;
  final TXAgreementViewLayout layout;

  TXAgreementViewModel(
      {required this.billData, required this.partner, required this.layout});
}
