import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:teamxsdk/src/data_layer/data/response/api_response.dart';
import 'package:teamxsdk/src/data_layer/service/api_client.dart';
import 'package:teamxsdk/src/data_layer/service/api_constants.dart';
import 'package:teamxsdk/src/data_layer/service/api_error.dart';
import 'package:teamxsdk/src/data_layer/service/api_request.dart';
import 'package:teamxsdk/src/data_layer/service/api_result.dart';
import 'package:http/http.dart' as http;
import 'package:teamxsdk/teamxsdk.dart';

abstract class TXAPIServiceInterface {
  Future<TXResult> bookPolicy(String token, dynamic userData);

  Future<TXResult> fetchPartner(String token, String partnerCode);
}

class TXAPIService implements TXAPIServiceInterface {
  final TXAPIClient client = TXAPIClient(client: http.Client());
  @override
  Future<TXResult> bookPolicy(String token, userData) async {
    try {
      var request = TXServiceRequest(
          baseUrl: TXAPIConstants.baseUrl,
          path: TXAPIConstants.bookPolicyPath,
          requestType: TXRequestType.post);
      var response = await client.sendRequest(request);
      response = _returnResponse(response);
      return TXResult<TXBookPolicyResponse>.success(
          TXBookPolicyResponse.fromRawJson(response.body));
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
  }

  @override
  Future<TXResult> fetchPartner(String token, String partnerCode) async {
    try {
      var jsonText = await rootBundle
          .loadString('packages/teamxsdk/assets/json/partner.json');
      var response = TXPartnerResponse.fromRawJson(jsonText);
      return TXResult.success(response.partner);
    } catch (error) {
      return TXResult.error(FetchDataException("Data Not found"));
    }
  }

  http.Response _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
