import 'dart:convert';

class TXPartner {
  TXPartner({
    this.code,
    this.name,
    this.agreementText,
    this.cardLinkText,
    this.agreeButtonText,
    this.cancelButtonText,
    this.products,
    this.pricingModel,
    this.premiums,
    this.showWebView,
    this.showAgreementModel,
  });

  String? code;
  String? name;
  String? agreementText;
  String? cardLinkText;
  String? agreeButtonText;
  String? cancelButtonText;
  List<TXProduct>? products;
  List<String>? pricingModel;

  List<TXPricingModel>? get pricingModelEnum {
    List<TXPricingModel> models = [];
    pricingModel?.forEach((element) {
      if (element == TXPricingModel.fixed.name) {
        models.add(TXPricingModel.fixed);
      } else if (element == TXPricingModel.variable.name) {
        models.add(TXPricingModel.variable);
      }
    });
    return models;
  }

  List<double>? premiums;
  bool? showWebView;
  bool? showAgreementModel;

  factory TXPartner.fromRawJson(String str) =>
      TXPartner.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TXPartner.fromJson(Map<String, dynamic> json) => TXPartner(
        code: json["code"],
        name: json["name"],
        agreementText: json["agreementText"],
        cardLinkText: json["cardLinkText"],
        agreeButtonText: json["agreeButtonText"],
        cancelButtonText: json["cancelButtonText"],
        products: json["products"] == null
            ? null
            : List<TXProduct>.from(
                json["products"].map((x) => TXProduct.fromJson(x))),
        pricingModel: json["pricingModel"] == null
            ? null
            : List<String>.from(json["pricingModel"].map((x) => x)),
        premiums: json["premiums"] == null
            ? null
            : List<double>.from(json["premiums"].map((x) => x)),
        showWebView: json["showWebView"],
        showAgreementModel: json["showAgreementModel"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "agreementText": agreementText,
        "cardLinkText": cardLinkText,
        "agreeButtonText": agreeButtonText,
        "cancelButtonText": cancelButtonText,
        "products": products == null
            ? null
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "pricingModel": pricingModel == null
            ? null
            : List<dynamic>.from(pricingModel!.map((x) => x)),
        "premiums": premiums == null
            ? null
            : List<dynamic>.from(premiums!.map((x) => x)),
        "showWebView": showWebView,
        "showAgreementModel": showAgreementModel,
      };

  TXPricingModel getPricingModel(double amount) {
    switch (code) {
      case "YUU001":
        return TXPricingModel.fixed;
      default:
        if (amount > 500.00) {
          return TXPricingModel.variable;
        }
        return TXPricingModel.fixed;
    }
  }

  double getFixPremium(double amount) {
    if (premiums?.isEmpty == true) {
      return 2.0;
    }
    var premium = 5.0;

    switch (code) {
      case "YUU001":
        if (amount > 0 && amount <= 500) {
          if (premiums?.isEmpty == false) {
            return premiums?.first ?? 0.0;
          }
        } else if (amount > 500.01 && amount <= 2000) {
          if ((premiums?.length ?? 0) > 1) {
            return premiums?[1] ?? 0.0;
          }
        } else if (amount > 2000.01 && amount <= 5000) {
          if ((premiums?.length ?? 0) > 2) {
            return premiums?[2] ?? 0.0;
          }
        } else if (amount > 5000.01 && amount <= 10000) {
          if ((premiums?.length ?? 0) > 3) {
            return premiums?[3] ?? 0.0;
          }
        } else {
          return 2.0;
        }
        break;
      default:
        premium = 5.0;
    }
    return premium;
  }

  double getVariablePremimum(double amount) {
    double percentage = 0.01;
    switch (code) {
      default:
        percentage = 1.0 / 100;
    }
    double permium = amount * percentage;
    return permium;
  }

  TXProduct? getProductDetailFromProductCode(TXProductCode code) {
    var filterProducts = products?.where((element) {
      return element.code == code.productName;
    }).toList();
    if (filterProducts?.isNotEmpty ?? false) {
      return filterProducts?.first;
    }
  }
}

class TXProduct {
  TXProduct({
    this.code,
    this.name,
    this.productDescription,
    this.insuranceInfo,
  });

  String? code;
  String? name;
  String? productDescription;
  String? insuranceInfo;

  TXProductCode? get productCodeEnum {
    if (code == TXProductCode.purchaseProtect.name) {
      return TXProductCode.purchaseProtect;
    } else if (code == TXProductCode.billProtect.name) {
      return TXProductCode.billProtect;
    } else if (code == TXProductCode.bnplProtect.name) {
      return TXProductCode.bnplProtect;
    } else {
      return TXProductCode.eventCancelation;
    }
  }

  factory TXProduct.fromRawJson(String str) =>
      TXProduct.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TXProduct.fromJson(Map<String, dynamic> json) => TXProduct(
        code: json["code"],
        name: json["name"],
        productDescription: json["productDescription"],
        insuranceInfo: json["insuranceInfo"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "productDescription": productDescription,
        "insuranceInfo": insuranceInfo,
      };
}

enum TXProductCode {
  purchaseProtect,
  billProtect,
  bnplProtect,
  eventCancelation
}

extension TXProductCodeExt on TXProductCode {
  String get productName {
    switch (this) {
      case TXProductCode.billProtect:
        return "BILLPROTECT";

      case TXProductCode.bnplProtect:
        return "BNPLPROTECT";

      case TXProductCode.eventCancelation:
        return "EVENTCANCELLATIONPROTECT";

      case TXProductCode.purchaseProtect:
        return "PURCHASEPROTECT";
    }
  }
}

enum TXPricingModel { fixed, variable }

extension TXPricingModelExt on TXPricingModel {
  String get name {
    switch (this) {
      case TXPricingModel.fixed:
        return "FIXED";
      case TXPricingModel.variable:
        return "VARIABLE";
    }
  }
}
