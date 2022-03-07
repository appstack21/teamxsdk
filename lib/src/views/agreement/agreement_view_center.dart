import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teamxsdk/src/config/configurator.dart';
import 'package:teamxsdk/src/views/agreement/agreement_view.dart';
import 'package:teamxsdk/src/views/agreement/agreement_view_model.dart';

class TXAgreementViewCenter extends StatefulWidget {
  final Function callBack;
  final TXAgreementViewModel viewModel;
  const TXAgreementViewCenter(
      {Key? key, required this.callBack, required this.viewModel})
      : super(key: key);

  @override
  _TXAgreementViewCenterState createState() => _TXAgreementViewCenterState();
}

class _TXAgreementViewCenterState extends State<TXAgreementViewCenter> {
  BoxDecoration decoration() {
    //Setting cornerRadius
    double? cornerRadius = widget.viewModel.layout.viewStyle?.cornerRadius;

    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(cornerRadius ?? 5.0)));
  }

  didTapActionButton(bool isAccepted, String? encryptedText) {
    widget.callBack(isAccepted, encryptedText);
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.black.withOpacity(0.5),
          // appBar: AppBar(
          //   backgroundColor: Colors.transparent,
          // ),
          body: Center(
            child: Container(
              decoration: decoration(),
              margin: const EdgeInsets.fromLTRB(16, 44, 16, 44),
              height: 480,
              child: TXAgreementView(
                  callBack: didTapActionButton, viewModel: widget.viewModel),
            ),
          ),
        ));
  }
}
