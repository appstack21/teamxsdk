import 'package:teamxservice/teamxservice.dart';

class TXInsuranceCardviewModel {
  final String token;

  TXInsuranceCardviewModel(this.token);

  TXSPartner? partner;
  TXSServiceWorker service = TXSServiceWorker();
  void setPartner(TXSPartner partner) {
    this.partner = partner;
  }

  TXSPartner? get getPartner {
    return partner;
  }

  Future<TXSResult?> loadPartner(String code) {
    return service.fetchPartner(token, code).then((response) {
      if (response is SuccessState) {
        if (response.value is TXSPartner) {
          setPartner(response.value as TXSPartner);
          return Future.value(response);
          // return response;
        }
      } else if (response is ErrorState) {
        return response;
      } else {
        return response;
      }
    });
  }

  Future<TXSResult> bookPolicy(dynamic config) {
    return service.bookPolicy(token, config);
  }
}
