import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teamxsdk/src/config/configurator.dart';
import 'package:teamxsdk/src/views/agreement_view.dart';

class TXAgreementViewBottom extends StatefulWidget {
  final Function callBack;
  final TXConfigurator configurator;
  const TXAgreementViewBottom(
      {Key? key, required this.callBack, required this.configurator})
      : super(key: key);

  @override
  _TXAgreementViewBottomState createState() => _TXAgreementViewBottomState();
}

class _TXAgreementViewBottomState extends State<TXAgreementViewBottom> {
  didTapActionButton(bool isAccepted, String? encryptedText) {
    widget.callBack(isAccepted, encryptedText);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      child: TXAgreementView(
          callBack: didTapActionButton, configurator: widget.configurator),
    );
  }
}
