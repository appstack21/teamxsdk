import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:teamxsdk/src/data_layer/service/api_request.dart';

abstract class TXAPIClientInterface {}

class TXAPIClient {
  TXAPIClient({required this.client});
  final http.Client client;

  Future<http.Response> sendRequest(TXTarget request) async {
    switch (request.requestType) {
      case TXRequestType.get:
        return client.get(
            Uri(
                host: request.baseUrl,
                path: request.path,
                queryParameters: request.params),
            headers: request.headers);
      case TXRequestType.post:
        var encodedData = request.params;
        print("ENCODED DATA: - $encodedData");
        return client.post(Uri(host: request.baseUrl, path: request.path),
            headers: request.headers, body: encodedData);
    }
  }
}
