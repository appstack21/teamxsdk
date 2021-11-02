import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:teamxsdk/configurator.dart';
import 'package:teamxsdk/constants/style.dart';
import 'package:teamxsdk/txhelper.dart';

class TXCardView extends StatefulWidget {
  const TXCardView({Key? key, required this.configurator}) : super(key: key);
  final TXConfigurator configurator;

  @override
  _TXCardViewState createState() => _TXCardViewState();
}

class _TXCardViewState extends State<TXCardView> {
  bool isSelected = false;
  double insuranceFee = 0;

  didTapAction(bool isAgree, String? encryptedText) {
    if (isAgree == false) {
      setState(() {
        isSelected = isAgree;
      });
    }
    widget.configurator.completionBlock(encryptedText, insuranceFee, isAgree);
  }

  Text getInsuranceMessage() {
    // get text
    var text = TXHelper.getInsuranceInfoMessage(widget.configurator.partner);
    return Text(
      text,
      style: TXTextStyle.getTextStyle(
          size: 15, weight: FontWeight.normal, color: Colors.black),
    );
  }

  Widget insuranceFeeMessage() {
    var text = TXHelper.getTitleText(widget.configurator.partner);
    var fee = TXHelper.getInsuranceFee(widget.configurator);
    String feeText =
        " ${TXHelper.getCurrency(widget.configurator.partner.country)} $fee ";
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
        text: TextSpan(
          text: text,
          style: TXTextStyle.getTextStyle(
              size: 17, weight: FontWeight.normal, color: Colors.black),
          children: <TextSpan>[
            TextSpan(
                text: feeText,
                style: TXTextStyle.getTextStyle(
                    size: 17, weight: FontWeight.bold, color: Colors.black)),
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
      height: 220,
      // width: 320,
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
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: CupertinoSwitch(
                    // trackColor: Colors.grey,
                    value: isSelected,
                    onChanged: (changed) {
                      setState(() {
                        isSelected = changed;
                      });
                    }),
              ),
              Expanded(
                child: insuranceFeeMessage(),
              )
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
              padding: const EdgeInsets.all(8.0), child: getInsuranceMessage()),
          const SizedBox(
            height: 25,
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
                onTap: () {
                  print("tapped");
                },
              ),
              const Expanded(child: Text("")),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 8.0, 0),
                child: Text("CHUBBB"),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
