import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teamxsdk/configurator.dart';
import 'package:teamxsdk/views/agreement_view.dart';

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
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      child: TXAgreementView(
          callBack: widget.callBack, configurator: widget.configurator),
    );
  }
}
