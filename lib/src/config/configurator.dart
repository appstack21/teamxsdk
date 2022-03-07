import 'package:flutter/material.dart';
import 'package:teamxsdk/src/models/agreement.dart';
import 'package:teamxsdk/src/models/insurance_card.dart';

/// A Configurator class for setting up TeamX SDK Data

/// Use this class to setup configuration
///
/// Configurator  requires theree parameters
/// ```
/// partner
/// insuranceCard
/// agreement
/// ```
///
/// Example of use
/// ```
/// //Create Partner Data
/// let partner = TXPartner(partnerCode: "GR001", product: .purchaseProtect, amount: 1550.0, country: .singapore)
///
/// //Create Card Data
/// let cardBuilder: TXInsuranceCardBuilderProtocol = TXInsuranceCardBuilder()
/// cardBuilder.setSelectionStyle(selectionStyle: .checkBox)
/// cardBuilder.setCardType(cardType: .short)
///
/// let insuranceCard = cardBuilder.build()
///
/// //Create Agreement
/// let agreementBuilder: TXInsuranceCardBuilderProtocol = TXAgreementBuilder()
///
/// //Set presentation style
/// agreementBuilder.setPresentationStyle(style: .center)
///
/// let txAgreement = agreementBuilder.build()
///
/// let configurator = TXConfigurator(partner: partner, cardData: insuranceCard, agreementData: txAgreement, parentViewController: self)
/// ```
///
class TXConfigurator {
  late TXInsuranceCardInterface insuranceCard;
  late TXAgreementInterface agreement;
  late BuildContext context;
  late Function(String? encryptedText, double? insuranceFee, bool isAccepted)
      completionBlock;

  TXConfigurator(
      {required this.insuranceCard,
      required this.agreement,
      required this.context,
      required this.completionBlock});
}
