import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:teamxsdk/src/constants/constants.dart';
import 'package:teamxsdk/src/constants/style.dart';
import 'package:teamxsdk/src/data_layer/data/entity/partner_model.dart';
import 'package:teamxsdk/src/data_layer/data/response/api_response.dart';
import 'package:teamxsdk/src/data_layer/service/api_error.dart';
import 'package:teamxsdk/src/data_layer/service/api_result.dart';
import 'package:teamxsdk/src/utility/encryption_manager.dart';
import 'package:teamxsdk/src/utility/insurance_manager.dart';
import 'package:teamxsdk/src/views/agreement/agreement_view_center.dart';
import 'package:teamxsdk/src/views/agreement/agreement_view_model.dart';
import 'package:teamxsdk/src/views/components/progress_dialog.dart';
import 'package:teamxsdk/src/views/insurance/insurance_card_view_model.dart';
import 'package:teamxsdk/teamxsdk.dart';

class TXCardView extends StatefulWidget {
  const TXCardView(
      {Key? key,
      required this.token,
      this.config,
      required this.controller,
      required this.onInitialized,
      required this.onLoad,
      required this.onBookePolicy,
      required this.onInsuranceOpted,
      required this.onInsuranceError})
      : super(key: key);

  final String token;
  final TXInsuranceViewController controller;
  final dynamic config;

  // Callbacks
  final Function() onInitialized;
  final Function() onLoad;
  final Function({required String policyId}) onBookePolicy;
  final Function({required bool isOpted, required double? insuranceFee})
      onInsuranceOpted;
  final Function({required TXError error}) onInsuranceError;

  @override
  // ignore: no_logic_in_create_state
  _TXCardViewState createState() => _TXCardViewState(controller);
}

class _TXCardViewState extends State<TXCardView> {
  _TXCardViewState(TXInsuranceViewController controller) {
    controller.bookPolicy = purchasePolicy;
    controller.loadData = loadData;
    // controller.initialize = initialize;

    controller.setAgreementLayout = setAgreementLayout;
    controller.setInsuranceLayout = setInsuranceLayout;
  }

  bool isSelected = false;
  double insuranceFee = 0;
  bool isInitialized = false;
  bool isLoaded = false;

  TXBillData? billData;
  TXProduct? selectedProduct;
  late TXInsuranceCardviewModel viewModel;

  TXInsuranceLayout layout = TXInsuranceLayout.defaultLayout();
  TXAgreementViewLayout agreementLayout = TXAgreementViewLayout.defaultLayout();

  @override
  void initState() {
    super.initState();
    viewModel = TXInsuranceCardviewModel(widget.token);
    loadPartner();
  }

  void initialize(String token) {
    if (kDebugMode) {
      print("Initialized");
    }
  }

  void setInsuranceLayout(TXInsuranceLayout layout) {
    setState(() {
      this.layout = layout;
    });
  }

  void setAgreementLayout(TXAgreementViewLayout layout) {
    setState(() {
      agreementLayout = layout;
    });
  }

  void purchasePolicy(String config) {
    if (kDebugMode) {
      print("Purchase policy clicked");
    }
    viewModel.bookPolicy("code").then((value) {
      if (value != null) {
        widget.onBookePolicy(policyId: value);
      } else {
        widget.onInsuranceError(
            error: InvalidInputException("Something Wrong"));
      }
    });
  }

  void loadPartner() {
    if (kDebugMode) {
      print("LOAD PARTNER");
    }
    if (widget.config != null) {
      var jsonString = widget.config as String;
      var response = TXPartnerResponse.fromRawJson(jsonString);
      if (response.partner != null) {
        viewModel.setPartner(response.partner!);
      } else {
        widget.onInsuranceError(error: BadRequestException("Invlid Config"));
      }
    } else {
      viewModel.loadPartner("code").then((response) {
        if (response is SuccessState) {
          setState(() {
            isInitialized = true;
          });
          if (kDebugMode) {
            print("PARTNER LOADED");
          }
          widget.onInitialized();
        } else if (response is ErrorState) {
          widget.onInsuranceError(error: BadRequestException("Invlid Config"));
        }
      });
    }
  }

  void loadData(TXBillData billData) {
    if (kDebugMode) {
      print(billData.productCode);
      print("LOADING BILL DATA");
    }
    var partner = viewModel.getPartner;
    selectedProduct =
        partner?.getProductDetailFromProductCode(billData.productCode);
    if (kDebugMode) {
      print("Selected Product $selectedProduct");
    }
    setState(() {
      this.billData = billData;
      isInitialized = true;
      isLoaded = true;
      if (kDebugMode) {
        print("BILL DATA LOADED");
      }
      widget.onLoad();
    });
  }

  didTapOnToggle(bool isChanged) {
    var isShowModel = viewModel.getPartner?.showAgreementModel ?? true;
    if (!isShowModel && viewModel.getPartner != null) {
      final text = TXEnryptionManager.encrypt(partner: viewModel.partner!);
      if (kDebugMode) {
        print("Encrypted Text $text");
      }
      widget.onInsuranceOpted(isOpted: true, insuranceFee: insuranceFee);
      return;
    }

    if (isChanged) {
      if (billData != null && viewModel.getPartner != null) {
        // ignore: unrelated_type_equality_checks
        if (agreementLayout.presentationStyle ==
            TXAgreementPresentationStyle.center) {
          showGeneralDialog(
              context: context,
              barrierColor: Colors.transparent,
              pageBuilder: (_, __, ___) {
                var agreementViewModel = TXAgreementViewModel(
                    billData: billData!,
                    partner: viewModel.getPartner!,
                    layout: agreementLayout);
                return TXAgreementViewCenter(
                    viewModel: agreementViewModel, callBack: didTapAction);
              });
        } else {
          showModalBottomSheet<dynamic>(
              isScrollControlled: true,
              isDismissible: false,
              context: context,
              builder: (context) {
                var agreementViewModel = TXAgreementViewModel(
                    billData: billData!,
                    partner: viewModel.getPartner!,
                    layout: agreementLayout);
                return TXAgreementViewCenter(
                    viewModel: agreementViewModel, callBack: didTapAction);
              });
        }
      }
    } else {
      setState(() {
        isSelected = isChanged;
      });

      widget.onInsuranceOpted(isOpted: false, insuranceFee: null);
    }
  }

  didTapAction(bool isAgree, String? encryptedText) {
    setState(() {
      isSelected = isAgree;
    });
    widget.onInsuranceOpted(
      isOpted: isAgree,
      insuranceFee: insuranceFee,
    );
  }

  Text getInsuranceMessage() {
    // get text
    Color? subTitleColor =
        HexColor.fromHex(layout.cardViewStyle?.subtitleColor);
    var text = selectedProduct?.insuranceInfo ??
        TXStringConstant.cardTextEventCanellationProtect;
    return Text(
      text,
      style: TXTextStyle.getTextStyleWithLineHeight(
          size: 15,
          weight: FontWeight.normal,
          color: subTitleColor ?? Colors.black,
          lineHeigh: 1.3),
    );
  }

  Widget insuranceFeeMessage() {
    if (viewModel.partner != null && billData != null) {
      var text = selectedProduct?.productDescription ??
          TXStringConstant.billProtectText;
      var fee = TXInsuranceFeeManager.getInsuranceFee(
          partner: viewModel.partner!, billData: billData!);
      setState(() {
        insuranceFee = fee;
      });
      // TXCountry? country = billData?.country;

      Color? titleColor = HexColor.fromHex(layout.cardViewStyle?.titleColor);
      String feeText = " ${billData?.country.currency ?? ""} $fee ";
      return Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: RichText(
          text: TextSpan(
            text: text,
            style: TXTextStyle.getTextStyle(
                size: 17,
                weight: FontWeight.normal,
                color: titleColor ?? Colors.black),
            children: <TextSpan>[
              TextSpan(
                  text: feeText,
                  style: TXTextStyle.getTextStyle(
                      size: 17,
                      weight: FontWeight.bold,
                      color: titleColor ?? Colors.black)),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  BoxDecoration decoration() {
    Color? backgroundColor =
        HexColor.fromHex(layout.cardViewStyle?.backgroundColor);
    double? borderWidth = layout.cardViewStyle?.borderWidth;

    double? cornerRadius = layout.cardViewStyle?.cornerRadius;

    Color? borderColor = HexColor.fromHex(layout.cardViewStyle?.borderColor);

    return BoxDecoration(
        color: backgroundColor ?? Colors.transparent,
        border: Border.all(
            color: borderColor ?? Colors.grey, width: borderWidth ?? 1.0),
        borderRadius: BorderRadius.all(Radius.circular(cornerRadius ?? 12.0)));
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded
        ? Container(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            decoration: decoration(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    layout.selectionStyle == TXCardSelectionStyle.checkBox
                        ? checkboxContainer()
                        : switchContainer(),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Container(
                        child: insuranceFeeMessage(),
                        color: Colors.transparent,
                      ),
                    )
                  ],
                ),
                // const SizedBox(
                //   height: 0,
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: getInsuranceMessage(),
                    color: Colors.transparent,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                        child: Text(
                          "Learn More",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: Colors.blue),
                        ),
                      ),
                      onTap: () {},
                    ),
                    const Expanded(child: Text("")),
                    const Image(
                        width: 110,
                        height: 10,
                        image: AssetImage('assets/images/chubb_logo.png',
                            package: 'teamxsdk')),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        : Container();
  }

  Widget checkboxContainer() {
    return GestureDetector(
      onTap: () {
        didTapOnToggle(!isSelected);
      },
      child: Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
              color: Color(0xFFF1F3F6),
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: isSelected
              ? const Center(
                  child: Icon(
                    Icons.done,
                    color: Color(0xFFFFAC30),
                    size: 40,
                  ),
                )
              : null),
    );
  }

  Widget switchContainer() {
    return CupertinoSwitch(
        // trackColor: Colors.grey,
        activeColor: TXColor.primaryColor,
        value: isSelected,
        onChanged: (isChange) {
          didTapOnToggle(isChange);
        });
  }
}
