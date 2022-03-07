import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teamxsdk/src/config/config.dart';
import 'package:teamxsdk/src/config/configurator.dart';
import 'package:teamxsdk/src/config/txhelper.dart';
import 'package:teamxsdk/src/constants/constants.dart';
import 'package:teamxsdk/src/constants/style.dart';
import 'package:teamxsdk/src/data_layer/data/entity/partner_model.dart';
import 'package:teamxsdk/src/utility/encryption_manager.dart';
import 'package:teamxsdk/src/views/agreement/agreement_view_model.dart';

class TXAgreementView extends StatefulWidget {
  final Function callBack;
  final TXAgreementViewModel viewModel;
  const TXAgreementView({
    Key? key,
    required this.callBack,
    required this.viewModel,
  }) : super(key: key);

  @override
  _TXAgreementViewState createState() => _TXAgreementViewState();
}

class _TXAgreementViewState extends State<TXAgreementView> {
  Widget getTitleText() {
    String titleText = "${TXStringConstant.agreementTitleText} \n";

    TXProduct? selectedProduct = widget.viewModel.partner
        .getProductDetailFromProductCode(widget.viewModel.billData.productCode);
    String billProtectText = selectedProduct?.name ?? "";
    var ritchText = RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: titleText,
        style: TXTextStyle.getTextStyle(
          size: 17,
          weight: FontWeight.normal,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
              text: billProtectText,
              style: TXTextStyle.getTextStyle(
                  size: 17, weight: FontWeight.bold, color: Colors.black)),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: ritchText,
    );
  }

  Widget getAgreementDescriptionText() {
    // get text
    var text = widget.viewModel.partner.agreementText ?? "";
    return Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TXTextStyle.getTextStyle(
              size: 17, weight: FontWeight.normal, color: Colors.black),
        ));
  }

  Widget agreeButtonText() {
    final title = widget.viewModel.partner.agreeButtonText ??
        TXStringConstant.agreeButtonTitle;
    final Color? titleColor =
        HexColor.fromHex(widget.viewModel.layout.viewStyle?.buttonTitleColor);
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TXTextStyle.getTextStyle(
          size: 23, weight: FontWeight.bold, color: titleColor ?? Colors.white),
    );
  }

  Widget cancelButtonText() {
    final title = widget.viewModel.partner.cancelButtonText ??
        TXStringConstant.cancelButtonTitle;
    ;
    final Color? titleColor = HexColor.fromHex(
        widget.viewModel.layout.viewStyle?.secondaryButtonTitleColor);
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TXTextStyle.getTextStyle(
          size: 14, weight: FontWeight.bold, color: titleColor ?? Colors.black),
    );
  }

  BoxDecoration decoration() {
    //Setting backgroundColor
    Color? backgroundColor =
        HexColor.fromHex(widget.viewModel.layout.viewStyle?.backgroundColor);
    //Setting borderWithd
    double? borderWidth = widget.viewModel.layout.viewStyle?.borderWidth;

    //Setting borderColor
    Color? borderColor =
        HexColor.fromHex(widget.viewModel.layout.viewStyle?.borderColor);

    //Setting cornerRadius
    double? cornerRadius = widget.viewModel.layout.viewStyle?.cornerRadius;

    return BoxDecoration(
        color: backgroundColor ?? Colors.white,
        border: Border.all(
            color: borderColor ?? Colors.grey, width: borderWidth ?? 1.0),
        borderRadius: BorderRadius.all(Radius.circular(cornerRadius ?? 25.0)));
  }

  BoxDecoration agreeButtonDecoration() {
    Color? backgroundColor = HexColor.fromHex(
        widget.viewModel.layout.viewStyle?.buttonBackgroundColor);

    double? cornerRadius = widget.viewModel.layout.viewStyle?.cornerRadius;

    return BoxDecoration(
        color: backgroundColor ?? TXColor.primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(cornerRadius ?? 10.0)));
  }

  BoxDecoration cancelButtonDecoration() {
    Color? backgroundColor = HexColor.fromHex(
        widget.viewModel.layout.viewStyle?.secondaryButtonBackgroundColor);

    double? cornerRadius = widget.viewModel.layout.viewStyle?.cornerRadius;

    return BoxDecoration(
        color: backgroundColor ?? TXColor.secondaryBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(cornerRadius ?? 10.0)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 16,
          ),
          const Image(
              width: 70,
              height: 70,
              image: AssetImage('assets/images/celebration.png',
                  package: 'teamxsdk')),
          const SizedBox(
            height: 16,
          ),
          getTitleText(),
          const SizedBox(
            height: 10,
          ),
          getAgreementDescriptionText(),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(24, 0, 24, 0),
            height: 60,
            decoration: agreeButtonDecoration(),
            child: CupertinoButton(
                child: agreeButtonText(),
                onPressed: () {
                  final text = TXEnryptionManager.encrypt(
                      partner: widget.viewModel.partner);
                  widget.callBack(true, text);
                }),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              height: 60,
              decoration: cancelButtonDecoration(),
              child: CupertinoButton(
                  child: cancelButtonText(),
                  onPressed: () {
                    widget.callBack(false, null);
                  })),
          const SizedBox(
            height: 0,
          ),
        ],
      ),
    );
  }
}
