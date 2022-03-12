// To parse this JSON data, do
//
//     final txPolicyBookRequest = txPolicyBookRequestFromJson(jsonString);

import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

extension DoubleExt on double {
  double roundTo(int places) {
    var divisor = pow(10.0, places);
    return (this * divisor).round() / divisor;
  }
}

class TXPolicyBookRequest {
  TXPolicyBookRequest({
    this.requestDate,
    this.channel,
    this.effectiveDate,
    this.contractHolders,
    this.insureds,
    this.insuranceSelections,
  });

  String? requestDate;
  String? channel;
  String? effectiveDate;
  List<ContractHolder>? contractHolders;
  List<Insured>? insureds;
  InsuranceSelections? insuranceSelections;

  factory TXPolicyBookRequest.fromRawJson(String str) =>
      TXPolicyBookRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TXPolicyBookRequest.fromJson(Map<String, dynamic> json) =>
      TXPolicyBookRequest(
        requestDate: json["request_date"],
        channel: json["channel"],
        effectiveDate: json["effective_date"],
        contractHolders: json["contract_holders"] == null
            ? null
            : List<ContractHolder>.from(json["contract_holders"]
                .map((x) => ContractHolder.fromJson(x))),
        insureds: json["insureds"] == null
            ? null
            : List<Insured>.from(
                json["insureds"].map((x) => Insured.fromJson(x))),
        insuranceSelections: json["insurance_selections"] == null
            ? null
            : InsuranceSelections.fromJson(json["insurance_selections"]),
      );

  Map<String, dynamic> toJson() => {
        "request_date": requestDate,
        "channel": channel,
        "effective_date": effectiveDate,
        "contract_holders": contractHolders == null
            ? null
            : List<dynamic>.from(contractHolders!.map((x) => x.toJson())),
        "insureds": insureds == null
            ? null
            : List<dynamic>.from(insureds!.map((x) => x.toJson())),
        "insurance_selections":
            insuranceSelections == null ? null : insuranceSelections!.toJson(),
      };

  static TXPolicyBookRequest createRequest() {
    var request = TXPolicyBookRequest();

    DateTime now = DateTime.now();
    String date = DateFormat('yyyy/MM/dd').format(now);

    request.requestDate = date;
    request.channel = "internet";
    request.effectiveDate = date;

    List<ContractHolder> contractHolders = [];
    ContractHolder holder = ContractHolder();

    holder.firstName = "John Cena";
    holder.nationality = "Singapore";
    holder.relationship = "self";
    holder.dateOfBirth = "2003/5/1";

    var rng = Random();
    var randomAccount = rng.nextInt(99999999);

    holder.identification = Identification(
        typeOfId: "Singapore NRIC", idValue: randomAccount.toString());
    //Address
    holder.homeAddress = HomeAddress(
        addressLines: [""], city: "", state: "", postalCode: "", country: "sg");
    holder.mailingAddress = false;
    //Phone
    holder.phone = [Phone(phoneNumber: "+65 88888888", type: "personal")];
    holder.email = "nagaraju.kunchala@chubb.com";
    contractHolders.add(holder);

    request.contractHolders = contractHolders;

    List<Insured> insureds = [];
    Insured insured = Insured();

    insured.insured = holder;
    insured.beneficiaries = [];
    insureds.add(insured);
    request.insureds = insureds;

    var insuranceSelection = InsuranceSelections();
    var checkout = now.add(const Duration(days: 4));
    var checkin = now.subtract(const Duration(days: 3));
    var daysCalculator = DaysCalculator(
        checkInDate: DateFormat('yyyy/MM/dd').format(checkin),
        checkOutDate: DateFormat('yyyy/MM/dd').format(checkout),
        duration: 8);

    insuranceSelection.campaignId = "pweb-sp";
    insuranceSelection.additionalData = AdditionalData(
        deviceDetails: ChannelPreferences(),
        channelPreferences: ChannelPreferences(),
        localeId: "en-SG",
        familyType: "myself",
        daysCalculator: daysCalculator);

    insuranceSelection.paymentType = "credit card";

    insuranceSelection.paymentDetails = PaymentDetails(
        cardType: "masterCard",
        cardholderName: "Christopher",
        paymentToken: "542288LZ83AP0007",
        expMonth: "07",
        expYear: "30",
        cvv: "123",
        paymentFrequency: 8);

    insuranceSelection.offerId = "1";
    insuranceSelection.offer = Offer(
        offerId: "1",
        name: "Classic",
        paymentFrequency: 8,
        additionalData: AdditionalDataClass(standardPrice: 16.56),
        premium: 13.93,
        tax: 0.97.roundTo(2),
        total: 14.9);

    List<PricingQuestion> pricingQuestions = [];

    var pricingQuestionOne = PricingQuestion(
        question: Question(
            questionId: "familyType",
            label: "Your Family",
            value: Value(code: "Your Family", description: "")));
    var pricingQuestionTwo = PricingQuestion(
        question: Question(
            questionId: "days-calculator",
            label: "Your Family",
            value: Value(code: daysCalculator, description: "")));

    var pricingQuestionThree = PricingQuestion(
        question: Question(
            questionId: "promo_code",
            label: "Your Family",
            value: Value(description: "")));

    pricingQuestions.add(pricingQuestionOne);
    pricingQuestions.add(pricingQuestionTwo);
    pricingQuestions.add(pricingQuestionThree);

    insuranceSelection.pricingQuestions = pricingQuestions;
    request.insuranceSelections = insuranceSelection;

    // printLongString(jsonEncode(request));
    return request;
  }

  static void printLongString(String text) {
    final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern
        .allMatches(text)
        .forEach((RegExpMatch match) => print(match.group(0)));
  }
}

class ContractHolder {
  ContractHolder({
    this.firstName,
    this.nationality,
    this.relationship,
    this.dateOfBirth,
    this.identification,
    this.homeAddress,
    this.mailingAddress,
    this.phone,
    this.email,
  });

  String? firstName;
  String? nationality;
  String? relationship;
  String? dateOfBirth;
  Identification? identification;
  HomeAddress? homeAddress;
  bool? mailingAddress;
  List<Phone>? phone;
  String? email;

  factory ContractHolder.fromRawJson(String str) =>
      ContractHolder.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ContractHolder.fromJson(Map<String, dynamic> json) => ContractHolder(
        firstName: json["first_name"],
        nationality: json["nationality"],
        relationship: json["relationship"],
        dateOfBirth: json["date_of_birth"],
        identification: json["identification"] == null
            ? null
            : Identification.fromJson(json["identification"]),
        homeAddress: json["home_address"] == null
            ? null
            : HomeAddress.fromJson(json["home_address"]),
        mailingAddress: json["mailing_address"],
        phone: json["phone"] == null
            ? null
            : List<Phone>.from(json["phone"].map((x) => Phone.fromJson(x))),
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "nationality": nationality,
        "relationship": relationship,
        "date_of_birth": dateOfBirth,
        "identification":
            identification == null ? null : identification!.toJson(),
        "home_address": homeAddress == null ? null : homeAddress!.toJson(),
        "mailing_address": mailingAddress,
        "phone": phone == null
            ? null
            : List<dynamic>.from(phone!.map((x) => x.toJson())),
        "email": email,
      };
}

class HomeAddress {
  HomeAddress({
    this.addressLines,
    this.city,
    this.state,
    this.postalCode,
    this.country,
  });

  List<String>? addressLines;
  String? city;
  String? state;
  String? postalCode;
  String? country;

  factory HomeAddress.fromRawJson(String str) =>
      HomeAddress.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HomeAddress.fromJson(Map<String, dynamic> json) => HomeAddress(
        addressLines: json["address_lines"] == null
            ? null
            : List<String>.from(json["address_lines"].map((x) => x)),
        city: json["city"],
        state: json["state"],
        postalCode: json["postal_code"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "address_lines": addressLines == null
            ? null
            : List<dynamic>.from(addressLines!.map((x) => x)),
        "city": city,
        "state": state,
        "postal_code": postalCode,
        "country": country,
      };
}

class Identification {
  Identification({
    this.typeOfId,
    this.idValue,
  });

  String? typeOfId;
  String? idValue;

  factory Identification.fromRawJson(String str) =>
      Identification.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Identification.fromJson(Map<String, dynamic> json) => Identification(
        typeOfId: json["type_of_id"],
        idValue: json["id_value"],
      );

  Map<String, dynamic> toJson() => {
        "type_of_id": typeOfId,
        "id_value": idValue,
      };
}

class Phone {
  Phone({
    this.phoneNumber,
    this.type,
  });

  String? phoneNumber;
  String? type;

  factory Phone.fromRawJson(String str) => Phone.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Phone.fromJson(Map<String, dynamic> json) => Phone(
        phoneNumber: json["phone_number"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber,
        "type": type,
      };
}

class InsuranceSelections {
  InsuranceSelections({
    this.campaignId,
    this.additionalData,
    this.paymentType,
    this.paymentDetails,
    this.offerId,
    this.offer,
    this.pricingQuestions,
  });

  String? campaignId;
  AdditionalData? additionalData;
  String? paymentType;
  PaymentDetails? paymentDetails;
  String? offerId;
  Offer? offer;
  List<PricingQuestion>? pricingQuestions;

  factory InsuranceSelections.fromRawJson(String str) =>
      InsuranceSelections.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InsuranceSelections.fromJson(Map<String, dynamic> json) =>
      InsuranceSelections(
        campaignId: json["campaign_id"],
        additionalData: json["additional_data"] == null
            ? null
            : AdditionalData.fromJson(json["additional_data"]),
        paymentType: json["payment_type"],
        paymentDetails: json["payment_details"] == null
            ? null
            : PaymentDetails.fromJson(json["payment_details"]),
        offerId: json["offer_id"],
        offer: json["offer"] == null ? null : Offer.fromJson(json["offer"]),
        pricingQuestions: json["pricing_questions"] == null
            ? null
            : List<PricingQuestion>.from(json["pricing_questions"]
                .map((x) => PricingQuestion.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "campaign_id": campaignId,
        "additional_data":
            additionalData == null ? null : additionalData!.toJson(),
        "payment_type": paymentType,
        "payment_details":
            paymentDetails == null ? null : paymentDetails!.toJson(),
        "offer_id": offerId ?? "1",
        "offer": offer == null ? null : offer!.toJson(),
        "pricing_questions": pricingQuestions == null
            ? null
            : List<dynamic>.from(pricingQuestions!.map((x) => x.toJson())),
      };
}

class AdditionalData {
  AdditionalData({
    this.deviceDetails,
    this.channelPreferences,
    this.localeId,
    this.familyType,
    this.daysCalculator,
  });

  ChannelPreferences? deviceDetails;
  ChannelPreferences? channelPreferences;
  String? localeId;
  String? familyType;
  DaysCalculator? daysCalculator;

  factory AdditionalData.fromRawJson(String str) =>
      AdditionalData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdditionalData.fromJson(Map<String, dynamic> json) => AdditionalData(
        deviceDetails: json["device_details"] == null
            ? null
            : ChannelPreferences.fromJson(json["device_details"]),
        channelPreferences: json["channel_preferences"] == null
            ? null
            : ChannelPreferences.fromJson(json["channel_preferences"]),
        localeId: json["locale_id"],
        familyType: json["familyType"],
        daysCalculator: json["days-calculator"] == null
            ? null
            : DaysCalculator.fromJson(json["days-calculator"]),
      );

  Map<String, dynamic> toJson() => {
        "device_details":
            deviceDetails == null ? null : deviceDetails?.toJson(),
        "channel_preferences":
            channelPreferences == null ? null : channelPreferences!.toJson(),
        "locale_id": localeId,
        "familyType": familyType,
        "days-calculator":
            daysCalculator == null ? null : daysCalculator!.toJson(),
      };
}

class ChannelPreferences {
  ChannelPreferences();

  factory ChannelPreferences.fromRawJson(String str) =>
      ChannelPreferences.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChannelPreferences.fromJson(Map<String, dynamic> json) =>
      ChannelPreferences();

  Map<String, dynamic> toJson() => {};
}

class DaysCalculator {
  DaysCalculator({
    this.checkInDate,
    this.checkOutDate,
    this.duration,
  });

  String? checkInDate;
  String? checkOutDate;
  int? duration;

  factory DaysCalculator.fromRawJson(String str) =>
      DaysCalculator.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DaysCalculator.fromJson(Map<String, dynamic> json) => DaysCalculator(
        checkInDate: json["checkInDate"],
        checkOutDate: json["checkOutDate"],
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "checkInDate": checkInDate,
        "checkOutDate": checkOutDate,
        "duration": duration,
      };
}

class Offer {
  Offer({
    this.offerId,
    this.name,
    this.paymentFrequency,
    this.additionalData,
    this.premium,
    this.tax,
    this.total,
  });

  String? offerId;
  String? name;
  int? paymentFrequency;
  AdditionalDataClass? additionalData;
  double? premium;
  double? tax;
  double? total;

  factory Offer.fromRawJson(String str) => Offer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        offerId: json["offerId"],
        name: json["name"],
        paymentFrequency: json["paymentFrequency"],
        additionalData: json["additionalData"] == null
            ? null
            : AdditionalDataClass.fromJson(json["additionalData"]),
        premium: json["premium"] == null ? null : json["premium"]!.toDouble(),
        tax: json["tax"] == null ? null : json["tax"]!.toDouble(),
        total: json["total"] == null ? null : json["total"]!.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "offerId": offerId,
        "name": name,
        "paymentFrequency": paymentFrequency,
        "additionalData":
            additionalData == null ? null : additionalData!.toJson(),
        "premium": premium,
        "tax": tax,
        "total": total,
      };
}

class AdditionalDataClass {
  AdditionalDataClass({
    this.standardPrice,
  });

  double? standardPrice;

  factory AdditionalDataClass.fromRawJson(String str) =>
      AdditionalDataClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdditionalDataClass.fromJson(Map<String, dynamic> json) =>
      AdditionalDataClass(
        standardPrice: json["standardPrice"] == null
            ? null
            : json["standardPrice"]!.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "standardPrice": standardPrice,
      };
}

class PaymentDetails {
  PaymentDetails({
    this.cardType,
    this.cardholderName,
    this.paymentToken,
    this.expMonth,
    this.expYear,
    this.cvv,
    this.paymentFrequency,
  });

  String? cardType;
  String? cardholderName;
  String? paymentToken;
  String? expMonth;
  String? expYear;
  String? cvv;
  int? paymentFrequency;

  factory PaymentDetails.fromRawJson(String str) =>
      PaymentDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentDetails.fromJson(Map<String, dynamic> json) => PaymentDetails(
        cardType: json["card_type"],
        cardholderName: json["cardholder_name"],
        paymentToken: json["payment_token"],
        expMonth: json["exp_month"],
        expYear: json["exp_year"],
        cvv: json["cvv"],
        paymentFrequency: json["payment_frequency"],
      );

  Map<String, dynamic> toJson() => {
        "card_type": cardType,
        "cardholder_name": cardholderName,
        "payment_token": paymentToken,
        "exp_month": expMonth,
        "exp_year": expYear,
        "cvv": cvv,
        "payment_frequency": paymentFrequency,
      };
}

class PricingQuestion {
  PricingQuestion({
    this.question,
  });

  Question? question;

  factory PricingQuestion.fromRawJson(String str) =>
      PricingQuestion.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PricingQuestion.fromJson(Map<String, dynamic> json) =>
      PricingQuestion(
        question: json["question"] == null
            ? null
            : Question.fromJson(json["question"]),
      );

  Map<String, dynamic> toJson() => {
        "question": question == null ? null : question!.toJson(),
      };
}

class Question {
  Question({
    this.questionId,
    this.label,
    this.value,
  });

  String? questionId;
  String? label;
  Value? value;

  factory Question.fromRawJson(String str) =>
      Question.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        questionId: json["question_id"],
        label: json["label"],
        value: json["value"] == null ? null : Value.fromJson(json["value"]),
      );

  Map<String, dynamic> toJson() => {
        "question_id": questionId,
        "label": label,
        "value": value == null ? null : value!.toJson(),
      };
}

class Value {
  Value({
    this.code,
    this.description,
  });

  dynamic code;
  String? description;

  factory Value.fromRawJson(String str) => Value.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        code: json["code"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};

    if (code != null) {
      json["code"] = code;
      json["description"] = description;
    } else {
      json["description"] = description;
    }

    return json;
  }
}

class Insured {
  Insured({
    this.insured,
    this.beneficiaries,
  });

  ContractHolder? insured;
  List<dynamic>? beneficiaries;

  factory Insured.fromRawJson(String str) => Insured.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Insured.fromJson(Map<String, dynamic> json) => Insured(
        insured: json["insured"] == null
            ? null
            : ContractHolder.fromJson(json["insured"]),
        beneficiaries: json["beneficiaries"] == null
            ? null
            : List<dynamic>.from(json["beneficiaries"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "insured": insured == null ? null : insured!.toJson(),
        "beneficiaries": beneficiaries == null
            ? null
            : List<dynamic>.from(beneficiaries!.map((x) => x)),
      };
}
