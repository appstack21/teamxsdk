import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:teamxsdk/src/data_layer/data/entity/policy_request.dart';
import 'package:teamxsdk/src/data_layer/data/response/api_response.dart';
import 'package:teamxsdk/src/data_layer/service/api_client.dart';
import 'package:teamxsdk/src/data_layer/service/api_constants.dart';
import 'package:teamxsdk/src/data_layer/service/api_error.dart';
import 'package:teamxsdk/src/data_layer/service/api_request.dart';
import 'package:teamxsdk/src/data_layer/service/api_result.dart';
import 'package:http/http.dart' as http;

abstract class TXAPIServiceInterface {
  Future<TXResult> bookPolicy(String token, dynamic userData);
  Future<TXResult> fetchPartner(String token, String partnerCode);
}

class TXAPIService implements TXAPIServiceInterface {
  final TXAPIClient client = TXAPIClient(client: http.Client());

  @override
  Future<TXResult> bookPolicy(String token, dynamic userData) async {
    try {
      var header = TXHTTPHeader();
      header.token = token;
      var policyRequestData = TXPolicyBookRequest.createRequest();
      var request = TXServiceRequest(
          baseUrl: TXAPIConstants.baseUrl,
          path: TXAPIConstants.bookPolicyPath,
          requestType: TXRequestType.post,
          headers: header.bookPolicyHeader(),
          params: policyRequestData.toRawJson());
      var response = await client.sendRequest(request);
      response = _returnResponse(response);
      return TXResult<TXBookPolicyResponse>.success(
          TXBookPolicyResponse.fromRawJson(response.body));
    } catch (e) {
      if (e is TXErrorType) {
        return TXResult.error(e);
      } else if (e is Exception) {
        return handleException(e);
      } else {
        return TXResult.error(TXErrorType.unknown);
      }
    }
  }

  TXResult handleException(Exception e) {
    if (e is SocketException) {
      return TXResult.error(TXErrorType.gatewayTimeout);
    } else if (e is TimeoutException) {
      return TXResult.error(TXErrorType.gatewayTimeout);
    } else if (e is FormatException) {
      return TXResult.error(TXErrorType.incorrectDataReturned);
    } else {
      return TXResult.error(TXErrorType.unknown);
    }
  }

  @override
  Future<TXResult> fetchPartner(String token, String partnerCode) async {
    try {
      var jsonText = await rootBundle
          .loadString('packages/teamxsdk/assets/json/partner.json');
      var response = TXPartnerResponse.fromRawJson(jsonText);
      return TXResult.success(response.partner);
    } catch (e) {
      if (e is TXErrorType) {
        return TXResult.error(e);
      } else if (e is Exception) {
        return handleException(e);
      } else {
        return TXResult.error(TXErrorType.unknown);
      }
    }
  }

  http.Response _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 400:
        throw TXErrorType.badRequest;
      case 401:
        throw TXErrorType.unAuthorized;
      case 403:
        throw TXErrorType.accessForbidden;
      case 500:
        throw TXErrorType.internalServerError;
      case 501:
        throw TXErrorType.serviceUnavailable;
      case 503:
        throw TXErrorType.internalServerError;
      case 504:
        throw TXErrorType.gatewayTimeout;
      default:
        throw TXErrorType.unknown;
    }
  }
}
