import 'package:teamxsdk/teamxsdk.dart';
import 'package:teamxservice/teamxservice.dart';

class TXAgreementViewModel {
  final TXBillData billData;
  final TXSPartner partner;
  final TXAgreementViewLayout layout;

  TXAgreementViewModel(
      {required this.billData, required this.partner, required this.layout});
}
