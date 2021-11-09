import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teamxsdk/configurator.dart';
import 'package:teamxsdk/views/agreement_view.dart';

class TXAgreementViewCenter extends StatefulWidget {
  final Function callBack;
  final TXConfigurator configurator;
  const TXAgreementViewCenter(
      {Key? key, required this.callBack, required this.configurator})
      : super(key: key);

  @override
  _TXAgreementViewCenterState createState() => _TXAgreementViewCenterState();
}

class _TXAgreementViewCenterState extends State<TXAgreementViewCenter> {
  @override
  Widget build(BuildContext context) {
    print("Hello");
    return Container(
        height: 400,
        color: Colors.transparent,
        child: Center(
            child: TXAgreementView(
                callBack: widget.callBack, configurator: widget.configurator)));
  }
}
