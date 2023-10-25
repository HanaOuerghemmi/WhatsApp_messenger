import 'package:flutter/material.dart';
import 'package:whatsapp_messenger/common/utils/colors.dart';




class CustomEvatedButton extends StatelessWidget {
  final double? buttonWith;
  final VoidCallback onPressed;
  final String text;
  const CustomEvatedButton({
    super.key, this.buttonWith, required this.onPressed, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      width:buttonWith?? MediaQuery.of(context).size.width - 100,
      child: ElevatedButton(
          onPressed: onPressed,
          child:  Text(text)),
    );
  }
}

