abstract class TXTarget {
  late String baseUrl;
  late String path;
  late TXRequestType requestType;
  late dynamic params;
  late dynamic headers;
}

enum TXRequestType { get, post }

extension TXRequestTypeExtention on TXRequestType {
  String get name {
    switch (this) {
      case TXRequestType.get:
        return "GET";

      case TXRequestType.post:
        return "POST";
    }
  }
}

class TXServiceRequest implements TXTarget {
  TXServiceRequest(
      {required this.baseUrl,
      required this.path,
      required this.requestType,
      this.headers,
      this.params});
  @override
  String baseUrl;

  @override
  dynamic headers;

  @override
  dynamic params;

  @override
  String path;

  @override
  TXRequestType requestType;
}

class TXHTTPHeader {
  String? token;
  static var country = "sg";
  static var product = "staycation";
  static var partner = "dbs";
  static var campaign = "pweb-sp";
  static var contentType = "application/json";
  static var authoraization = "Authorization";
  static var apiVersion = "apiVersion";

  static var subscriptionKey = "Ocp-Apim-Subscription-Key";

  Object bookPolicyHeader() {
    return {
      "Content-Type": TXHTTPHeader.contentType,
      "country": TXHTTPHeader.country,
      "product": TXHTTPHeader.product,
      "partner": TXHTTPHeader.partner,
      "campaign": TXHTTPHeader.campaign,
    };
  }

  Object commonHeader() {
    if (token != null) {
      return {
        "Authorization": "Bearer $token",
        "Content-Type": TXHTTPHeader.contentType,
        "country": TXHTTPHeader.country,
        "product": TXHTTPHeader.product,
        "partner": TXHTTPHeader.partner,
        "campaign": TXHTTPHeader.campaign,
      };
    }
    return {
      "Content-Type": TXHTTPHeader.contentType,
      "country": TXHTTPHeader.country,
      "product": TXHTTPHeader.product,
      "partner": TXHTTPHeader.partner,
      "campaign": TXHTTPHeader.campaign,
    };
  }
}
