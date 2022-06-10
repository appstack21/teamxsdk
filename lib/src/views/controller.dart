import 'package:teamxsdk/src/models/agreement.dart';
import 'package:teamxsdk/src/models/insurance_card.dart';
import 'package:teamxsdk/src/models/partner.dart';
import 'package:teamxservice/teamxservice.dart';

abstract class TXInsuranceViewCallBackInterface {
  void onInitialized(TXInsuranceViewController controller);
  void onLoad();
  void onInsuranceOpted(bool isOpted, double? insuranceFee);
  void onPurchasePolicy(String policyId);
  void onInsuranceError(TXSErrorType error);
}

class TXInsuranceViewController {
  late void Function(TXBillData data) loadData;
  late void Function(String config) bookPolicy;
  late void Function(TXInsuranceLayout laout) setInsuranceLayout;
  late void Function(TXAgreementViewLayout laout) setAgreementLayout;
}
