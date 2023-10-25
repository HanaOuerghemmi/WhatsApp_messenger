import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_messenger/common/extension/custom_theme_extension.dart';
import 'package:whatsapp_messenger/common/helper/show_dialog.dart';
import 'package:whatsapp_messenger/common/utils/colors.dart';
import 'package:whatsapp_messenger/feature/auth/controller/auth_controller.dart';
import 'package:whatsapp_messenger/feature/auth/widgets/custom_icon.dart';
import 'package:whatsapp_messenger/feature/auth/widgets/custom_text_field.dart';
import 'package:whatsapp_messenger/feature/welcome/pages/widgets/custom_button.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late TextEditingController countryNameController;
  late TextEditingController countryCodeController;
  late TextEditingController phoneNumberController;

  sendCodeToPhone() {
    final phoneNumber = phoneNumberController.text;
    final countryName = countryNameController.text;
    final countryCode = countryCodeController.text;

    if (phoneNumber.isEmpty) {
      return showAlertDialog(context: context, 
      message: "Please enter your phone number" );
    }
     else if (phoneNumber.length < 8) {
       return showAlertDialog(context: context, 
       message: "The phone number tou entred is to short for the country: $countryName \n\nInclude your area code if you haven't" );
    } else if (phoneNumber.length > 10) {
       return showAlertDialog(context: context, 
       message: "The phone number tou entred is to long for the country: $countryName " );
    }

     ref.read(authControllerProvider).sendSmsCode(
       context: context,
       phoneNumber: "+$countryCode$phoneNumber",
     );
  }

  showCodeCountryPicker() {
    showCountryPicker(
        context: context,
        showPhoneCode: true,
        favorite: ['TN'],
        onSelect: (country) {
          countryNameController.text = country.name;
          countryCodeController.text = country.phoneCode;
        },
        countryListTheme: CountryListThemeData(
          bottomSheetHeight: 600,
          backgroundColor: Theme.of(context).backgroundColor,
          flagSize: 22,
          borderRadius: BorderRadius.circular(20),
          textStyle: TextStyle(color: context.theme.greyColor),
          inputDecoration: InputDecoration(
            labelStyle: TextStyle(color: context.theme.greyColor),
            prefixIcon: const Icon(
              Icons.language,
              color: Coloors.greenDark,
            ),
            hintText: 'Search country code or Name',
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: context.theme.greyColor!.withOpacity(0.2))),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
              color: Coloors.greenDark,
            )),
          ),
        ));
  }

  @override
  void initState() {
    countryNameController = TextEditingController(text: "Tunisia");
    countryCodeController = TextEditingController(text: "216");
    phoneNumberController = TextEditingController();
    super.initState();
  }

  void dispose() {
    countryNameController.dispose();
    countryCodeController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          "Enter your phone number",
          style: TextStyle(
            color: context.theme.authAppBarTextColor,
          ),
        ),
        centerTitle: true,
        actions: [
          CustomIconButton(
           onTap:(){} ,
           icon: Icons.more_vert,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: RichText(
              text: TextSpan(
                  text: "WhatsApp will need to verify your phone number. ",
                  style: TextStyle(
                    color: context.theme.greyColor,
                    height: 1.5,
                  ),
                  children: [
                    TextSpan(
                        text: "What's my number?",
                        style: TextStyle(
                          color: context.theme.blueColor,
                        ))
                  ]),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: CustomTextField(
              controller: countryNameController,
              onTap: showCodeCountryPicker,
              readOnly: true,
              suffixion: Icon(
                Icons.arrow_drop_down,
                color: Coloors.greenDark,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              children: [
                SizedBox(
                  width: 70,
                  child: CustomTextField(
                    controller: countryCodeController,
                    onTap: showCodeCountryPicker,
                    readOnly: true,
                    prefixText: "+",
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: CustomTextField(
                  controller: phoneNumberController,
                  hintText: 'phone number',
                  textAlign: TextAlign.left,
                  keyboardType: TextInputType.number,
                )),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Carrier charges may apply',
            style: TextStyle(color: context.theme.greyColor),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomEvatedButton(
        onPressed: sendCodeToPhone,
        text: "NEXT",
        buttonWith: 90,
      ),
    );
  }
}
