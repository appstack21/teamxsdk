import 'dart:convert';

import 'package:teamxsdk/src/data_layer/data/entity/partner_model.dart';

class TXBookPolicyResponse {
  String? accountId;
  String? policyNumber;

  TXBookPolicyResponse({this.accountId, this.policyNumber});
  factory TXBookPolicyResponse.fromRawJson(String str) =>
      TXBookPolicyResponse.fromJson(json.decode(str));
  factory TXBookPolicyResponse.fromJson(Map<String, dynamic> json) =>
      TXBookPolicyResponse(
          accountId: json["account_id"], policyNumber: json["policy_id"]);

  Map<String, dynamic> toJson() =>
      {"account_id": accountId, "policy_id": policyNumber};
}

class TXPartnerResponse {
  TXPartnerResponse({
    this.partner,
  });

  TXPartner? partner;

  factory TXPartnerResponse.fromRawJson(String str) =>
      TXPartnerResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TXPartnerResponse.fromJson(Map<String, dynamic> json) =>
      TXPartnerResponse(
        partner: json["partner"] == null
            ? null
            : TXPartner.fromJson(json["partner"]),
      );

  Map<String, dynamic> toJson() => {
        "partner": partner?.toJson(),
      };
}
