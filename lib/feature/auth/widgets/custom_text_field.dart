import 'package:flutter/material.dart';
import 'package:whatsapp_messenger/common/extension/custom_theme_extension.dart';
import 'package:whatsapp_messenger/common/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool? readOnly;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final String? prefixText;
  final VoidCallback? onTap;
  final Widget? suffixion;
  final Function(String)? onChanged;
  final double? fontsize;
  final bool? autoFocus;

  const CustomTextField(
      {super.key,
      this.controller,
      this.hintText,
      this.readOnly,
      this.textAlign,
      this.keyboardType,
      this.prefixText,
      this.onTap,
      this.suffixion,
      this.onChanged, 
      this.fontsize,
      this.autoFocus});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      readOnly: readOnly ?? false,
      textAlign: textAlign ?? TextAlign.center,
      keyboardType: readOnly == null ? keyboardType: null,
      onChanged: onChanged,
      autofocus: autoFocus ?? false,
      style: TextStyle(fontSize: fontsize),
      decoration: InputDecoration(
        isDense: true,
        prefixText: prefixText,
        suffix: suffixion,
        hintText: hintText,
        hintStyle:TextStyle(color: context.theme.greyColor),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Coloors.greenDark),
      
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Coloors.greenDark, width: 2),
        )
      ),

    );
  }
}
