class TXResult<T> {
  TXResult._();
  factory TXResult.success(T value) = SuccessState<T>;
  factory TXResult.error(T error) = ErrorState<T>;
  factory TXResult.loading(T msg) = LoadingState<T>;
}

class ErrorState<T> extends TXResult<T> {
  ErrorState(this.msg) : super._();
  final T msg;
}

class SuccessState<T> extends TXResult<T> {
  SuccessState(this.value) : super._();
  final T value;
}

class LoadingState<T> extends TXResult<T> {
  LoadingState(this.msg) : super._();
  final T msg;
}
