import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teamxsdk/config.dart';
import 'package:teamxsdk/configurator.dart';
import 'package:teamxsdk/constants/constants.dart';
import 'package:teamxsdk/constants/style.dart';
import 'package:teamxsdk/models/partner.dart';

import '../txhelper.dart';

class TXAgreementView extends StatefulWidget {
  final Function callBack;
  final TXConfigurator configurator;
  const TXAgreementView(
      {Key? key, required this.callBack, required this.configurator})
      : super(key: key);

  @override
  _TXAgreementViewState createState() => _TXAgreementViewState();
}

class _TXAgreementViewState extends State<TXAgreementView> {
  Widget getTitleText() {
    String titleText = "${TXStringConstant.agreementTitleText} \n";
    TXProductType productType = widget.configurator.partner.productCode;
    String billProtectText = productType.productName;

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
    var text =
        TXHelper.getAgreementDesctiptionText(widget.configurator.partner);
    return Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TXTextStyle.getTextStyle(
              size: 17, weight: FontWeight.normal, color: Colors.black),
        ));
  }

  BoxDecoration decoration() {
    //Setting backgroundColor
    Color? backgroundColor = HexColor.fromHex(
        widget.configurator.agreement.viewStyle?.backgroundColor);
    //Setting borderWithd
    double? borderWidth = widget.configurator.agreement.viewStyle?.borderWidth;

    //Setting borderColor
    Color? borderColor =
        HexColor.fromHex(widget.configurator.agreement.viewStyle?.borderColor);

    //Setting cornerRadius
    double? cornerRadius =
        widget.configurator.agreement.viewStyle?.cornerRadius;

    return BoxDecoration(
        color: backgroundColor ?? Colors.white,
        border: Border.all(
            color: borderColor ?? Colors.grey, width: borderWidth ?? 1.0),
        borderRadius: BorderRadius.all(Radius.circular(cornerRadius ?? 25.0)));
  }

  BoxDecoration agreeButtonDecoration() {
    Color? backgroundColor = HexColor.fromHex(
        widget.configurator.agreement.viewStyle?.buttonBackgroundColor);

    double? cornerRadius =
        widget.configurator.agreement.viewStyle?.cornerRadius;

    return BoxDecoration(
        color: backgroundColor ?? TXColor.primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(cornerRadius ?? 10.0)));
  }

  BoxDecoration cancelButtonDecoration() {
    Color? backgroundColor = HexColor.fromHex(widget
        .configurator.agreement.viewStyle?.secondaryButtonBackgroundColor);

    double? cornerRadius =
        widget.configurator.agreement.viewStyle?.cornerRadius;

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
                child: Text(
                  "AGREE",
                  style: TXTextStyle.getTextStyle(
                      size: 23, weight: FontWeight.bold, color: Colors.white),
                ),
                onPressed: () {
                  widget.callBack(true, null);
                  Navigator.of(context, rootNavigator: true).pop("Discard");
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
                  child: Text(
                    "NO, JUST PAY THE BILL ",
                    style: TXTextStyle.getTextStyle(
                        size: 14, weight: FontWeight.bold, color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop("Discard");
                  })),
          const SizedBox(
            height: 0,
          ),
        ],
      ),
    );
  }
}
