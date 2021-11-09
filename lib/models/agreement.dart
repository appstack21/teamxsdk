import 'package:teamxsdk/models/view_interfaces.dart';

abstract class TXAgreementInterface {
  late TXAgreementPresentationStyle presentationStyle;
  late TXAgreementViewStyleInterface? viewStyle;
}

/// An Agreement  Data Model
///
/// Use this data model to show Agreement View
///
/// Insurance Card data model requires theree parameters
/// Agreement data model requires theree parameters
/// ```
/// presentationStyle
/// viewStyle
/// ```
/// Example of use
/// ```
/// // Styling is optional
/// var viewStyle = TXAgreementViewStyle()
/// viewStyle.backgroundColor = "#FFFFFF"
/// viewStyle.borderWidth = 1.0
/// viewStyle.borderColor = "#A26255"
/// viewStyle.cornerRadius = 8.0
/// viewStyle.titleColor = "#000000"
/// viewStyle.subTitleColor = "#171822"
/// viewStyle.buttonTitleColor = "#000000"
///
/// let agreementData = TXAgreement(style:.center , agreementViewStyle: viewStyle)
///
/// ```

class TXAgreement implements TXAgreementInterface {
  @override
  TXAgreementPresentationStyle presentationStyle;

  @override
  TXAgreementViewStyleInterface? viewStyle;

  TXAgreement({required this.presentationStyle, this.viewStyle});
}

/// Agreement View presentation style
///
///
/// You can select presentation style to show the agreement view.
/// ```
/// // Choose this if you want to show the agrrement model
/// // in the center of the screen
/// case center
///
/// // Choose this if you want to show the agreement model
/// // from the bottom of the screen
/// case bottom
///```
/// You can choose `center` For example:
///
///     // Create the builder
///     let agreementBuilder = TXAgreementBuilder()
///
///     // Set presentation style as `center`
///     agreementBuilder.setPresentationStyle(presentationStyle: .center)
///
/// Or you can choose `bottom`
///
///     // Create the builder
///     let agreementBuilder = TXAgreementBuilder()
///
///     // Set presentation style as `bottom`
///     agreementBuilder.setPresentationStyle(presentationStyle: .bottom)
///
enum TXAgreementPresentationStyle {
  /// Shows the Agreement View on the center of the screen
  ///
  /// You can choose `center` For example:
  ///
  ///     // Create the builder
  ///     let agreementBuilder = TXAgreementBuilder()
  ///
  ///     // Set presentation style as `center`
  ///     agreementBuilder.setPresentationStyle(presentationStyle: .center)
  center,

  /// Shows the Agreement View on the bottom of the screen
  ///
  /// You can choose `bottom`
  ///
  ///     // Create the builder
  ///     let agreementBuilder = TXAgreementBuilder()
  ///
  ///     // Set presentation style as `bottom`
  ///     agreementBuilder.setPresentationStyle(presentationStyle: .bottom)
  ///
  bottom
}

/// Agreement View Style
///
/// Using this Type you can design the agreement view, you can match the theme if you have any.
///
///
/// All the properties are mention in the style struct is optional.
/// If not passed, Presentation View will use default style.
///
///
/// This can be initialized below...
///
/// ```
///  var viewStyle = TXAgreementViewStyle()
///
///  viewStyle.backgroundColor = "#FFFFFF"
///  viewStyle.borderWidth = 1.0
///  viewStyle.borderColor = "#A26255"
///  viewStyle.cornerRadius = 8.0
///  viewStyle.titleColor = "#000000"
///  viewStyle.subTitleColor = "#171822"
///  viewStyle.buttonTitleColor = "#000000"
/// // Set the card style using card builder
///  agreementBuilder.setPresentationStyle(style: style)
/// ```

class TXAgreementViewStyle implements TXAgreementViewStyleInterface {
  @override
  String? backgroundColor;

  @override
  String? borderColor;

  @override
  double? borderWidth;

  @override
  String? buttonBackgroundColor;

  @override
  String? buttonTitleColor;

  @override
  double? cornerRadius;

  @override
  String? secondaryButtonTitleColor;

  @override
  String? secondaryButtonBackgroundColor;

  @override
  String? subtitleColor;

  @override
  String? titleColor;
}
