import 'package:flutter/material.dart';
import 'package:whatsapp_messenger/common/extension/custom_theme_extension.dart';

class YellowCard extends StatelessWidget {
  const YellowCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 30,
      ),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: context.theme.yellowCardBgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        "Message and calls are end-to end encryptes. No one outside of this chat, not even WhatsApp can read or listem to them. Tap to learn more",
        style:
            TextStyle(fontSize: 13, color: context.theme.yellowCardTextColor),
        textAlign: TextAlign.center,
      ),
    );
  }
}
