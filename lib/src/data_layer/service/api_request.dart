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
