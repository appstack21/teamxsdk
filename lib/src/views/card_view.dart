import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teamxsdk/src/config/configurator.dart';
import 'package:teamxsdk/src/config/txhelper.dart';
import 'package:teamxsdk/src/constants/style.dart';
import 'package:teamxsdk/src/models/agreement.dart';
import 'package:teamxsdk/src/utility/encryption_manager.dart';
import 'package:teamxsdk/src/utility/insurance_manager.dart';
import 'package:teamxsdk/src/views/agreement_view_bottom.dart';
import 'package:teamxsdk/src/views/agreement_view_center.dart';

class TXCardView extends StatefulWidget {
  const TXCardView({Key? key, required this.configurator}) : super(key: key);
  final TXConfigurator configurator;

  @override
  _TXCardViewState createState() => _TXCardViewState();
}

class _TXCardViewState extends State<TXCardView> {
  bool isSelected = false;
  double insuranceFee = 0;
  didTapOnToggle(bool isChanged) {
    var isShowModel =
        TXInsuranceFeeManager.showModel(widget.configurator.partner);
    if (!isShowModel) {
      final text =
          TXEnryptionManager.encrypt(partner: widget.configurator.partner);
      print("Encrypted Text $text");
      widget.configurator.completionBlock(text, insuranceFee, true);
      return;
    }

    if (isChanged) {
      // ignore: unrelated_type_equality_checks
      if (widget.configurator.agreement.presentationStyle ==
          TXAgreementPresentationStyle.center) {
        showGeneralDialog(
          context: context,
          barrierColor: Colors.transparent,
          pageBuilder: (_, __, ___) => TXAgreementViewCenter(
              configurator: widget.configurator, callBack: didTapAction),
        );
      } else {
        showModalBottomSheet<dynamic>(
            isScrollControlled: true,
            isDismissible: false,
            context: context,
            builder: (context) {
              return TXAgreementViewBottom(
                  configurator: widget.configurator, callBack: didTapAction);
            });
      }
    } else {
      setState(() {
        isSelected = isChanged;
      });
      widget.configurator.completionBlock(null, insuranceFee, false);
    }
  }

  didTapAction(bool isAgree, String? encryptedText) {
    setState(() {
      isSelected = isAgree;
    });
    widget.configurator.completionBlock(encryptedText, insuranceFee, isAgree);
  }

  Text getInsuranceMessage() {
    // get text
    Color? subTitleColor = HexColor.fromHex(
        widget.configurator.insuranceCard.cardViewStyle?.subtitleColor);
    var text = TXHelper.getInsuranceInfoMessage(widget.configurator.partner);
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
    var text = TXHelper.getTitleText(widget.configurator.partner);
    var fee =
        TXInsuranceFeeManager.getInsuranceFee(widget.configurator.partner);
    setState(() {
      insuranceFee = fee;
    });
    Color? titleColor = HexColor.fromHex(
        widget.configurator.insuranceCard.cardViewStyle?.titleColor);
    String feeText =
        " ${TXHelper.getCurrency(widget.configurator.partner.country)} $fee ";
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
  }

  BoxDecoration decoration() {
    Color? backgroundColor = HexColor.fromHex(
        widget.configurator.insuranceCard.cardViewStyle?.backgroundColor);
    double? borderWidth =
        widget.configurator.insuranceCard.cardViewStyle?.borderWidth;

    double? cornerRadius =
        widget.configurator.insuranceCard.cardViewStyle?.cornerRadius;

    Color? borderColor = HexColor.fromHex(
        widget.configurator.insuranceCard.cardViewStyle?.borderColor);
    widget.configurator.partner.country;

    return BoxDecoration(
        color: backgroundColor ?? Colors.transparent,
        border: Border.all(
            color: borderColor ?? Colors.grey, width: borderWidth ?? 1.0),
        borderRadius: BorderRadius.all(Radius.circular(cornerRadius ?? 12.0)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: CupertinoSwitch(
                    // trackColor: Colors.grey,
                    value: isSelected,
                    onChanged: (isChange) {
                      didTapOnToggle(isChange);
                    }),
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
              // const Padding(
              //   padding: EdgeInsets.fromLTRB(0, 0, 8.0, 0),
              //   child: Text("CHUBBB"),
              // )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
