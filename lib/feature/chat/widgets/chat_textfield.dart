import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_messenger/common/extension/custom_theme_extension.dart';
import 'package:whatsapp_messenger/common/utils/colors.dart';
import 'package:whatsapp_messenger/feature/auth/widgets/custom_icon.dart';
import 'package:whatsapp_messenger/feature/chat/controllers/chat_controller.dart';
import 'package:whatsapp_messenger/feature/chat/repository/chat_repository.dart';

class ChatTextField extends ConsumerStatefulWidget {
  final String receiverId;
  final ScrollController scrollController;

  const ChatTextField(
      {super.key, required this.scrollController, required this.receiverId});

  @override
  ConsumerState<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends ConsumerState<ChatTextField> {
  late TextEditingController messageController;

  bool isMessageIconEnabled = false;
  double cardHeight = 0;

  void sendTextMessage() async {
    if (isMessageIconEnabled) {
      ref.read(chatControllerProvider).sendTextMessage(
          context: context,
          textMessage: messageController.text,
          receiverId: widget.receiverId);
      print("messaage $messageController.text");
      messageController.clear();
    }

    await Future.delayed(const Duration(milliseconds: 100));
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      widget.scrollController.animateTo(
        widget.scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void initState() {
    messageController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          height: cardHeight,
          width: double.maxFinite,
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: context.theme.receiverChatCardBg,
              borderRadius: BorderRadius.circular(20)),
          duration: const Duration(milliseconds: 200),
          child: Center(
            child: SingleChildScrollView(
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    iconWithText(
                        onPressed: () {},
                        icon: Icons.book,
                        text: 'File',
                        background: Color(0xff7f66fe)),
                    iconWithText(
                        onPressed: () {},
                        icon: Icons.camera_alt,
                        text: 'Camera',
                        background: Color(0xfffe2e74)),
                    iconWithText(
                        onPressed: () {},
                        icon: Icons.photo,
                        text: 'Gallery',
                        background: Color(0xffc861f9)),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    iconWithText(
                        onPressed: () {},
                        icon: Icons.headphones,
                        text: 'Audio',
                        background: Color(0xfff96533)),
                    iconWithText(
                        onPressed: () {},
                        icon: Icons.location_on,
                        text: 'Location',
                        background: Color(0xff1fa855)),
                    iconWithText(
                        onPressed: () {},
                        icon: Icons.person,
                        text: 'Contact',
                        background: Color(0xff009de1)),
                  ],
                ),
              ]),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: messageController,
                  maxLines: 4,
                  minLines: 1,
                  onChanged: (value) {
                    value.isEmpty
                        ? setState(() => isMessageIconEnabled = false)
                        : setState(() => isMessageIconEnabled = true);
                  },
                  decoration: InputDecoration(
                    hintText: 'Message',
                    hintStyle: TextStyle(color: context.theme.greyColor),
                    filled: true,
                    fillColor: context.theme.chatTextFieldBg,
                    isDense: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(style: BorderStyle.none, width: 0),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    prefixIcon: Material(
                      color: Colors.transparent,
                      child: CustomIconButton(
                        onTap: () {},
                        icon: Icons.emoji_emotions_outlined,
                        iconColor: Theme.of(context).listTileTheme.iconColor,
                      ),
                    ),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RotatedBox(
                            quarterTurns: 45,
                            child: CustomIconButton(
                              onTap: () => setState(() => cardHeight == 0
                                  ? cardHeight = 220
                                  : cardHeight = 0),
                              icon: cardHeight == 0
                                  ? Icons.attach_file
                                  : Icons.close,
                              iconColor:
                                  Theme.of(context).listTileTheme.iconColor,
                            )),
                        CustomIconButton(
                          onTap: () {},
                          icon: Icons.camera_alt_outlined,
                          iconColor: Theme.of(context).listTileTheme.iconColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              CustomIconButton(
                onTap: sendTextMessage,
                icon: isMessageIconEnabled
                    ? Icons.send_outlined
                    : Icons.mic_none_outlined,
                background: Coloors.greenDark,
                iconColor: Colors.white,
              )
            ],
          ),
        ),
      ],
    );
  }

  iconWithText({
    required VoidCallback onPressed,
    required IconData icon,
    required String text,
    required Color background,
  }) {
    return Column(
      children: [
        CustomIconButton(
          onTap: onPressed,
          icon: icon,
          background: background,
          minWidth: 50,
          iconColor: Colors.white,
          border: Border.all(
            color: context.theme.greyColor!.withOpacity(.2),
            width: 1,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          text,
          style: TextStyle(
            color: context.theme.greyColor,
          ),
        ),
      ],
    );
  }
}
