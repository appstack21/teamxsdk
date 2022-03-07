class TXError implements Exception {
  final _message;
  final _prefix;

  TXError(this._message, this._prefix);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends TXError {
  FetchDataException(message) : super(message, "Error During Communication: ");
}

class BadRequestException extends TXError {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends TXError {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends TXError {
  InvalidInputException([message]) : super(message, "Invalid Input: ");
}
