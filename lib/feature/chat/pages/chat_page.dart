import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:shimmer/shimmer.dart';

import 'dart:math';
import 'package:whatsapp_messenger/common/extension/custom_theme_extension.dart';
import 'package:whatsapp_messenger/common/helper/last_seen_message.dart';
import 'package:whatsapp_messenger/common/models/user_model.dart';
import 'package:whatsapp_messenger/common/routes/routes.dart';
import 'package:whatsapp_messenger/feature/auth/controller/auth_controller.dart';
import 'package:whatsapp_messenger/feature/auth/widgets/custom_icon.dart';
import 'package:whatsapp_messenger/feature/chat/controllers/chat_controller.dart';
import 'package:whatsapp_messenger/feature/chat/widgets/chat_textfield.dart';
import 'package:whatsapp_messenger/feature/chat/widgets/message_card.dart';
import 'package:whatsapp_messenger/feature/chat/widgets/show_date_cad.dart';
import 'package:whatsapp_messenger/feature/chat/widgets/yellow_card.dart';

final pageStorageBucket = PageStorageBucket();

class ChatPage extends ConsumerWidget {
  final UserModel user;
  final ScrollController scrollController = ScrollController();

  ChatPage({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: context.theme.chatPageBgColor,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          borderRadius: BorderRadius.circular(20),
          child: Row(
            children: [
              Icon(Icons.arrow_back),
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(user.profileImageUrl),
              )
            ],
          ),
        ),
        title: InkWell(
          onTap: () {
            Navigator.pushNamed(context, Routes.profile, arguments: user);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.username,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                SizedBox(
                  height: 3,
                ),

                // const Text('last seen 2 min ago',
                // style: TextStyle(fontSize: 12),
                // ),
                StreamBuilder(
                  stream: ref
                      .read(authControllerProvider)
                      .getUserPresenceStatus(uid: user.uid),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState != ConnectionState.active) {
                      return const SizedBox();
                    }

                    final singleUserModel = snapshot.data!;
                    final lastMessage =
                        lastSeenMessage(singleUserModel.lastSeen);

                    return Text(
                      singleUserModel.active
                          ? 'online'
                          : "last seen $lastMessage ago",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          CustomIconButton(onTap: () {}, icon: Icons.video_call),
          CustomIconButton(onTap: () {}, icon: Icons.call),
          CustomIconButton(onTap: () {}, icon: Icons.more_vert),
        ],
      ),
      body: Stack(
        children: [
          Image(
            height: double.maxFinite,
            width: double.maxFinite,
            color: context.theme.chatPageDoodleColor,
            image: AssetImage("assets/images/doodle_bg.png"),
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: StreamBuilder(
                stream: ref
                    .watch(chatControllerProvider)
                    .getAllOneToOnetMessage(user.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.active) {
                    return ListView.builder(
                      itemCount: 15,
                      itemBuilder: (_, index) {
                        final random = Random().nextInt(14);
                        return Container(
                          alignment: random.isEven
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          margin: EdgeInsets.only(
                            top: 5,
                            bottom: 5,
                            left: random.isEven ? 150 : 15,
                            right: random.isEven ? 15 : 150,
                          ),
                          child: ClipPath(
                            clipper: UpperNipMessageClipperTwo(
                              random.isEven
                                  ? MessageType.send
                                  : MessageType.receive,
                              nipWidth: 8,
                              nipHeight: 10,
                              bubbleRadius: 12,
                            ),
                            child: Shimmer.fromColors(
                              baseColor: random.isEven
                                  ? context.theme.greyColor!.withOpacity(.3)
                                  : context.theme.greyColor!.withOpacity(.2),
                              highlightColor: random.isEven
                                  ? context.theme.greyColor!.withOpacity(.4)
                                  : context.theme.greyColor!.withOpacity(.3),
                              child: Container(
                                height: 40,
                                width: 170 +
                                    double.parse(
                                      (random * 2).toString(),
                                    ),
                                color: Colors.red,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }

                  return PageStorage(
                    bucket: pageStorageBucket,
                    child: ListView.builder(
                        key: const PageStorageKey('chat_page_list'),
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        controller: scrollController,
                        itemBuilder: (_, index) {
                          final message = snapshot.data![index];
                          final isSender = message.senderId ==
                              FirebaseAuth.instance.currentUser!.uid;

                          final haveNip = (index == 0) ||
                              (index == snapshot.data!.length - 1 &&
                                  message.senderId !=
                                      snapshot.data![index - 1].senderId) ||
                              (message.senderId !=
                                      snapshot.data![index - 1].senderId &&
                                  message.senderId ==
                                      snapshot.data![index + 1].senderId) ||
                              (message.senderId !=
                                      snapshot.data![index - 1].senderId &&
                                  message.senderId !=
                                      snapshot.data![index + 1].senderId);
                          //! date in chat page card of date
                          final isShowDateCard = (index == 0) ||
                              ((index == snapshot.data!.length - 1) &&
                                  (message.timeSent.day >
                                      snapshot
                                          .data![index - 1].timeSent.day)) ||
                              (message.timeSent.day >
                                      snapshot.data![index - 1].timeSent.day &&
                                  message.timeSent.day <=
                                      snapshot.data![index + 1].timeSent.day);
                         
                          
                          return Column(
                            children: [
                              if (index == 0) YellowCard(),
                              if (isShowDateCard) 
                              ShowDateCard(date: message.timeSent),
                              MessageCard(
                                  isSender: isSender,
                                  haveNip: haveNip,
                                  message: message),
                            ],
                          );
                        }),
                  );
                }),
          ),
          Container(
            alignment: const Alignment(0, 1),
            child: ChatTextField(
              receiverId: user.uid,
              scrollController: scrollController,
            ),
          ),
        ],
      ),
    );
  }
}
