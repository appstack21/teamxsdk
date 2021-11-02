abstract class TXViewStyleInterface {}

abstract class TXViewStyleColorInterface extends TXViewStyleInterface {
  String? backgroundColor;
  String? titleColor;
  String? subtitleColor;
}

abstract class TXViewStyleBorderInterface extends TXViewStyleInterface {
  double? borderWidth;
  double? cornerRadius;
  String? borderColor;
}

abstract class TXCardViewStyleInterface {
  String? linkTitleColor;
}

abstract class TXAgreementViewStyleInterface {
  String? buttonBackgroundColor;
  String? buttonTitleColor;
  String? secondartyButtonTitleColor;
  String? secondaryButtonBackgroundColor;
  String? secondaryButtonBackGroundColor;
}
