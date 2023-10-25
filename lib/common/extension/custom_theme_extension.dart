import 'package:flutter/material.dart';
import 'package:whatsapp_messenger/common/utils/colors.dart';

extension ExtendedTheme on BuildContext {
  CustomThemeExtension get theme {
    return Theme.of(this).extension<CustomThemeExtension>()!;
  }
}

class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
  static var lightMode = CustomThemeExtension(
    Color(0xFF25D366),
    Coloors.greyLight,
    Coloors.blueLight,
    Color(0xFFF7F8FA),
    Color(0xFFE8E8ED),
    Coloors.greenLight,
    Color(0xFFF1F1F1),
    Color(0xFF9DAAB3),
    Color(0xFFf7f8fa),
    Colors.white,
    Color(0xFFEFE7DE),
    Colors.white70,
    Color(0xFFE7FFDB),
    Color(0xFFFFFFFF),
    Color(0xFFFFEECC),
    Color(0xFF13191C),
  );
  static var darkMode = CustomThemeExtension(
    Coloors.greenDark,
    Coloors.greyDark,
    Coloors.blueDark,
    Color(0xFF182229),
    Color(0xFF09141A),
    Color(0xffe9edef),
    Color(0xFF283339),
    Color(0xFF61717B),
    Color(0xFF0b141a),
    Coloors.greyBackground,
    Color(0xFF081419),
    Color(0xFF172428),
    Color(0xFF005C4B),
    Coloors.greyBackground,
    Color(0xFF222E35),
    Color(0xFFFFD279),
  );
  final Color? circleImageColor;
  final Color? greyColor;
  final Color? blueColor;
  final Color? langBgColor;
  final Color? langHightlightColor;
  final Color? authAppBarTextColor;
  final Color? photoIconBgColor;
  final Color? photoIconColor;
  final Color? profilPageBg;
  final Color? chatTextFieldBg;
  final Color? chatPageBgColor;
  final Color? chatPageDoodleColor;
  final Color? senderChatCardBg;
  final Color? receiverChatCardBg;
  final Color? yellowCardBgColor;
  final Color? yellowCardTextColor;
  CustomThemeExtension(
      this.circleImageColor,
      this.greyColor,
      this.blueColor,
      this.langBgColor,
      this.langHightlightColor,
      this.authAppBarTextColor,
      this.photoIconBgColor,
      this.photoIconColor,
      this.profilPageBg,
      this.chatTextFieldBg,
      this.chatPageBgColor,
      this.chatPageDoodleColor,
      this.senderChatCardBg,
      this.receiverChatCardBg,
      this.yellowCardBgColor,
      this.yellowCardTextColor);

  @override
  ThemeExtension<CustomThemeExtension> copyWith({
    Color? circleImageColor,
    Color? greyColor,
    Color? blueColor,
    Color? langBgColor,
    Color? langHightlightColor,
    Color? authAppBarTextColor,
    Color? photoIconBgColor,
    Color? photoIconColor,
    Color? profilPageBg,
    Color? chatTextFieldBg,
    Color? chatPageBgColor,
    Color? chatPageDoodleColor,
    Color? senderChatCardBg,
    Color? receiverChatCardBg,
    Color? yellowCardBgColor,
    Color? yellowCardTextColor,
  }) {
    return CustomThemeExtension(
      circleImageColor ?? this.circleImageColor,
      greyColor ?? this.greyColor,
      blueColor ?? this.blueColor,
      langBgColor ?? this.langBgColor,
      langHightlightColor ?? this.langHightlightColor,
      authAppBarTextColor ?? this.authAppBarTextColor,
      photoIconBgColor ?? this.photoIconBgColor,
      photoIconColor ?? this.photoIconColor,
      profilPageBg ?? this.profilPageBg,
      chatTextFieldBg ?? this.chatTextFieldBg,
      chatPageBgColor ?? this.chatPageBgColor,
      chatPageDoodleColor ?? this.chatPageDoodleColor,
      senderChatCardBg ?? this.senderChatCardBg,
      receiverChatCardBg ?? this.receiverChatCardBg,
      yellowCardBgColor ?? this.yellowCardBgColor,
      yellowCardTextColor ?? this.yellowCardTextColor,
    );
  }

  @override
  ThemeExtension<CustomThemeExtension> lerp(
      ThemeExtension<CustomThemeExtension>? other, double t) {
    if (other is! CustomThemeExtension) return this;
    return CustomThemeExtension(
      Color.lerp(circleImageColor, other.circleImageColor, t),
      Color.lerp(greyColor, other.greyColor, t),
      Color.lerp(blueColor, other.blueColor, t),
      Color.lerp(langBgColor, other.langBgColor, t),
      Color.lerp(langHightlightColor, other.langHightlightColor, t),
      Color.lerp(authAppBarTextColor, other.authAppBarTextColor, t),
      Color.lerp(photoIconBgColor, other.photoIconBgColor, t),
      Color.lerp(photoIconColor, other.photoIconColor, t),
      Color.lerp(profilPageBg, other.profilPageBg, t),
      Color.lerp(chatTextFieldBg, other.chatTextFieldBg, t),
      Color.lerp(chatPageBgColor, other.chatPageBgColor, t),
      Color.lerp(chatPageDoodleColor, other.chatPageDoodleColor, t),
      Color.lerp(senderChatCardBg, other.senderChatCardBg, t),
      Color.lerp(receiverChatCardBg, other.receiverChatCardBg, t),
      Color.lerp(yellowCardBgColor, other.yellowCardBgColor, t),
      Color.lerp(yellowCardTextColor, other.yellowCardTextColor, t),
    );
  }
}
