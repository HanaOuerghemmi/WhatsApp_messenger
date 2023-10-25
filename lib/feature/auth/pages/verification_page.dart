import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_messenger/common/extension/custom_theme_extension.dart';
import 'package:whatsapp_messenger/feature/auth/controller/auth_controller.dart';
import 'package:whatsapp_messenger/feature/auth/widgets/custom_icon.dart';
import 'package:whatsapp_messenger/feature/auth/widgets/custom_text_field.dart';

class VerificationPage extends ConsumerWidget {
  final String smsCodeId, phoneNumber;

  const VerificationPage({super.key, 
  required this.smsCodeId, 
  required this.phoneNumber});

  void verifySmsCode(
    BuildContext context,
    WidgetRef ref,
    String smsCode,
  ){
    ref.read(authControllerProvider).verifySmsCode(
      context: context, 
      smsCodeId: smsCodeId, 
      smsCode: smsCode, 
      mounted: true
      );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Text(
          'Verify your number',
          style: TextStyle(
            color: context.theme.authAppBarTextColor,
          ),
          ),
          centerTitle: true,
          actions: [
            CustomIconButton(
              onTap: (){},
             icon: Icons.more_vert,
             ),
          ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
              style: TextStyle(
                color: context.theme.greyColor, height: 1.5
              ),
              children: [
                TextSpan(
                  text: "You've tried to register +216 22 000 000 before requesting an SMS or Call with your code "
                ),
                TextSpan(
                  text: "Wrong Number?",
                  style: TextStyle(
                    color: context.theme.blueColor,
                  )
                ),
              ]
            )),
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 80),
              child: CustomTextField(
                hintText: '- - - - - -',
                fontsize: 30,
                autoFocus: true,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.length == 6){
                    return verifySmsCode(context, ref, value);
                  }
                },
              ),  
            ),

            SizedBox(height: 20,),
            Text('Enter 6-digit code',
            style: TextStyle(
              color: context.theme.greyColor,
            ),
            ),
            SizedBox(height: 30,),
            Row(
              children: [
                Icon(Icons.message, color: context.theme.greyColor,),
                SizedBox(width: 20,),
                Text("Resend SMS",
                style:TextStyle(
                  color: context.theme.greyColor
                )
                )
              ],
            ),
            SizedBox(height: 10,),
            Divider(color: context.theme.blueColor!.withOpacity(0.2),),
            SizedBox(height: 10,),
             Row(
              children: [
                Icon(Icons.phone, color: context.theme.greyColor,),
                SizedBox(width: 20,),
                Text("Call Me .",
                style:TextStyle(
                  color: context.theme.greyColor
                )
                )
              ],
            ),
            
        ]),
      ),
    );
  }
}