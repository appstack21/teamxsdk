import 'package:teamxsdk/src/models/view_interfaces.dart';

abstract class TXInsuranceCardInterface {
  late TXCardType cardType;
  late TXCardSelectionStyle selectionStyle;
  TXCardViewStyleInterface? cardViewStyle;
}

/// A Insurance Card Data Model
///
/// Use this data model to show Insurance Card View
///
///
/// Insurance Card data model requires theree parameters
/// ```
/// cardType
/// selectionStyle
/// cardViewStyle
/// ```
/// Example of Use
/// ```
/// // Styling is optional
/// var cardViewStyle = TXCardViewStyle()
/// cardViewStyle.backgroundViewColor = "#FFFFFF"
/// cardViewStyle.borderWidth = 1.0
/// cardViewStyle.borderColor = "#A26255"
/// cardViewStyle.cornerRadius = 8.0
/// cardViewStyle.insuranceFeeTextColor = "#000000"
/// cardViewStyle.informationTextColor = "#171822"
/// cardViewStyle.linkTitleColor = "#000000"
///
///let insuranceCard = TXInsuranceCard.init(selectionStyle: .checkBox, cardViewStyle: cardViewStyle)
///
///  ```
///
class TXInsuranceLayout implements TXInsuranceCardInterface {
  @override
  TXCardType cardType;

  @override
  TXCardViewStyleInterface? cardViewStyle;

  @override
  TXCardSelectionStyle selectionStyle;

  TXInsuranceLayout(
      {required this.cardType,
      required this.selectionStyle,
      this.cardViewStyle});

  static defaultLayout() {
    return TXInsuranceLayout(
        cardType: TXCardType.short,
        selectionStyle: TXCardSelectionStyle.checkBox);
  }
}

//Card Type
enum TXCardType { short }

/// Card Selection Style
///
///
/// You can select style to show the type of selection style you want on card view.
/// You can show `checkBox` For example:
///
///     // Create the builder
///     let cardBuilder = TXInsuranceCardBuilder()
///
///     // Set selection style as checkBoxStyle
///     cardBuilder.setSelectionStyle(selectionStyle: .checkBox)
///
/// Or you can show `switch`
///
///     // Create the builder
///     let cardBuilder = TXInsuranceCardBuilder()
///
///     // Set selection style as checkBoxStyle
///     cardBuilder.setSelectionStyle(selectionStyle: .switch)
enum TXCardSelectionStyle {
  /// If checkBox is used, Card View will show checkBox as selection style
  /// You can show `checkBox` For example:
  checkBox,

  /// If switch is used, Card View will show checkBox as selection style
  /// You can show `switch` For example:
  toggle
}

/// Card View Style
///
/// Using this Type you can design the card view, you can match the theme if you have any.
///
///
/// All the properties are mention in the style struct is optional.
/// If not passed, Card View will use default style.
///
///
/// This can be initialized below...
///
/// ```
///  var cardViewStyle = TXCardViewStyle()
///  cardViewStyle.backgroundViewColor = "#FFFFFF"
///  cardViewStyle.borderWidth = 1.0
///  cardViewStyle.borderColor = "#A26255"
///  cardViewStyle.cornerRadius = 8.0
///  cardViewStyle.insuranceFeeTextColor = "#000000"
///  cardViewStyle.informationTextColor = "#171822"
///  cardViewStyle.linkTitleColor = "#000000"
/// // Set the card style using card builder
///  cardBuilder.setCardViewStyle(cardViewStyle: style)
/// ```
class TXCardViewStyle implements TXCardViewStyleInterface {
  @override
  String? backgroundColor;

  @override
  String? borderColor;

  @override
  double? borderWidth;

  @override
  double? cornerRadius;

  @override
  String? linkTitleColor;

  @override
  String? subtitleColor;

  @override
  String? titleColor;
}
