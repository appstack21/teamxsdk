import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:teamxsdk/teamxsdk.dart';
import 'package:teamxsdk/views/card_view.dart';
import 'package:teamxsdk/configurator.dart';
import 'package:teamxsdk/models/partner.dart';
import 'package:teamxsdk/config.dart';
import 'package:teamxsdk/models/insurance_card.dart';
import 'package:teamxsdk/models/agreement.dart';
import 'package:teamxsdk/models/view_interfaces.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  completionBlock(
      String? encryptedText, double? insuranceFee, bool isAccepted) {
    print("isAccepted $isAccepted");
    print("Completion Block Called $insuranceFee");
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await Teamxsdk.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  TXConfigurator getConfigurator() {
    TXPartnerInterface partner = TXPartner(
        partnerCode: 'YU001',
        productCode: TXProductType.purchaseProtect,
        amount: 50001,
        country: TXCountry.singapore);
    TXCardViewStyle style = TXCardViewStyle();
    // style.borderColor = Colors.accents.toString();
    TXInsuranceCardInterface insurance = TXInsuranceCard(
        cardType: TXCardType.short,
        selectionStyle: TXCardSelectionStyle.checkBox,
        cardViewStyle: style);
    TXAgreementInterface agreement =
        TXAgreement(presentationStyle: TXAgreementPresentationStyle.center);
    TXConfigurator configurator = TXConfigurator(
        partner: partner,
        insuranceCard: insurance,
        agreement: agreement,
        context: context,
        completionBlock: completionBlock);

    return configurator;
  }

  TXConfigurator getConfigurator2() {
    TXPartnerInterface partner = TXPartner(
        partnerCode: 'YU001',
        productCode: TXProductType.billProtect,
        amount: 50001,
        country: TXCountry.hongKong);
    TXCardViewStyle style = TXCardViewStyle();
    // style.borderColor = Colors.accents.toString();
    TXInsuranceCardInterface insurance = TXInsuranceCard(
        cardType: TXCardType.short,
        selectionStyle: TXCardSelectionStyle.checkBox,
        cardViewStyle: style);
    TXAgreementInterface agreement =
        TXAgreement(presentationStyle: TXAgreementPresentationStyle.bottom);
    TXConfigurator configurator = TXConfigurator(
        partner: partner,
        insuranceCard: insurance,
        agreement: agreement,
        context: context,
        completionBlock: completionBlock);

    return configurator;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Demo App'),
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                TXCardView(configurator: getConfigurator()),
                SizedBox(
                  height: 20,
                ),
                TXCardView(configurator: getConfigurator2())
              ],
            ),
          )),
        ),
      ),
    );
  }
}
