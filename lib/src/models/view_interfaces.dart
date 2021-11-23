abstract class TXViewStyleInterface {}

mixin TXViewStyleColorInterface {
  String? backgroundColor;
  String? titleColor;
  String? subtitleColor;
}
mixin TXViewStyleBorderInterface {
  double? borderWidth;
  double? cornerRadius;
  String? borderColor;
}

abstract class TXCardViewStyleInterface
    with TXViewStyleColorInterface, TXViewStyleBorderInterface {
  String? linkTitleColor;
}

abstract class TXAgreementViewStyleInterface
    with TXViewStyleColorInterface, TXViewStyleBorderInterface {
  String? buttonBackgroundColor;
  String? buttonTitleColor;
  String? secondaryButtonTitleColor;
  String? secondaryButtonBackgroundColor;
}
