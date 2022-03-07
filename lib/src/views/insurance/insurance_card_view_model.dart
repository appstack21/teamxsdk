import 'package:teamxsdk/src/data_layer/data/entity/partner_model.dart';
import 'package:teamxsdk/src/data_layer/service/api_result.dart';
import 'package:teamxsdk/src/data_layer/service/api_service.dart';

class TXInsuranceCardviewModel {
  final String token;

  TXInsuranceCardviewModel(this.token);

  TXPartner? partner;
  TXAPIService service = TXAPIService();
  void setPartner(TXPartner partner) {
    print(partner);
    this.partner = partner;
  }

  TXPartner? get getPartner {
    return partner;
  }

  Future<TXResult?> loadPartner(String code) {
    return service.fetchPartner(token, code).then((response) {
      if (response is SuccessState) {
        if (response.value is TXPartner) {
          setPartner(response.value as TXPartner);
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

  Future<String?> bookPolicy(String code) {
    // return Future.delayed(const Duration(seconds: 2), () => 'A6908AHBGGL');
    return Future.delayed(const Duration(seconds: 2), () => null);
    // return service.bookPolicy(token, code).then((response) {
    //   if (response is SuccessState) {
    //     if (response.value is String) {
    //       return response;
    //     }
    //   } else if (response is ErrorState) {
    //     return response;
    //   } else {
    //     return response;
    //   }
    // });
  }
}
