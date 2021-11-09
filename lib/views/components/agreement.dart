import 'package:flutter/material.dart';
import 'package:teamxsdk/configurator.dart';

class Agreement extends StatefulWidget {
  final Function callback;
  final TXConfigurator configurator;
  const Agreement(
      {Key? key, required this.configurator, required this.callback})
      : super(key: key);

  @override
  _AgreementState createState() => _AgreementState();
}

class _AgreementState extends State<Agreement> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
