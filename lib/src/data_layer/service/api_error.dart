enum TXErrorType {
  emptyResponse,

  /// 400
  badRequest,

  /// 401
  unAuthorized,

  /// 403
  accessForbidden,

  /// 500
  internalServerError,

  /// 503
  serviceUnavailable,

  /// 504
  gatewayTimeout,

  invalidToken,

  /// Unknown or not supported error.

  unknown,

  /// Not connected to the internet.
  notConnectedToInternet,

  /// Cannot reach the server.
  notReachedServer,

  /// Incorrect data returned from the server.
  incorrectDataReturned,

  //Host Authentication Challanged
  cancelled,

  //Missing Token
  missingToken,

  invalidConfig,

  loadFailed,

  serverError,
}

enum TXInsuranceAction { initialize, load, bookPolicy }

extension TXErrorExt on TXErrorType {
  String get message {
    switch (this) {
      case TXErrorType.incorrectDataReturned:
        return "Incorrect JSON format";

      case TXErrorType.notConnectedToInternet:
        return "You are offline";

      case TXErrorType.notReachedServer:
        return "Server not found";

      case TXErrorType.cancelled:
        return "Request Cancelled";

      case TXErrorType.serviceUnavailable:
        return "Service Unavailable";

      case TXErrorType.emptyResponse:
        return "Empty Response";

      case TXErrorType.gatewayTimeout:
        return "Gateway Timeout";

      case TXErrorType.unAuthorized:
        return "Token Invalid";

      case TXErrorType.badRequest:
        return "Incorrect Request";

      case TXErrorType.internalServerError:
        return "Internal Server Error";

      case TXErrorType.accessForbidden:
        return "Access Forbiddon";

      case TXErrorType.invalidToken:
        return "Token Invalid";

      default:
        return "Unknown error";
    }
  }
}

class TXInsuranceError {
  TXInsuranceError._(this.errorType);
  final TXErrorType errorType;

  factory TXInsuranceError.missingToken() =>
      TXInsuranceError._(TXErrorType.missingToken);

  String get message {
    switch (errorType) {
      case TXErrorType.missingToken:
        return "Access Token is missing";
      case TXErrorType.invalidToken:
        return "Access Token is Invalid";
      case TXErrorType.invalidConfig:
        return "Invalid Config";
      case TXErrorType.loadFailed:
        return "Loading Failed";
      default:
        "Server Error";
    }
    return "";
  }

  // case missingToken

  // case invalidToken

  // case invalidConfig

  // case loadFailed

  // case serverError
}
