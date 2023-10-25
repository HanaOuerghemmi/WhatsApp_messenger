import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'package:whatsapp_messenger/common/enum/message_type.dart';
import 'package:whatsapp_messenger/common/helper/show_dialog.dart';
import 'package:whatsapp_messenger/common/models/las_message_model.dart';
import 'package:whatsapp_messenger/common/models/message_model.dart';
import 'package:whatsapp_messenger/common/models/user_model.dart';

final ChatRepositoryProvider = Provider((ref) {
  return ChatRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  );
});

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ChatRepository({required this.firestore, required this.auth});

  Stream<List<MessageModel>> getAllOneToOnetMessage(String receiverId) {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
          List<MessageModel> messages = [];
          for (var message in event.docs){
            messages.add(MessageModel.fromMap(message.data()));
          }
         return messages;
        });
  }

  Stream<List<LastMessageModel>> getAllLastMessageList() {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .snapshots()
        .asyncMap((event) async {
      List<LastMessageModel> contacts = [];
      for (var document in event.docs) {
        final lastMessage = LastMessageModel.fromMap(document.data());
        final userData = await firestore
            .collection('users')
            .doc(lastMessage.contactId)
            .get();
        final user = UserModel.fromMap(userData.data()!);
        contacts.add(LastMessageModel(
            username: user.username,
            profileImageUrl: user.profileImageUrl,
            contactId: lastMessage.contactId,
            timeSent: lastMessage.timeSent,
            lastMessage: lastMessage.lastMessage));
      }
      return contacts;
    });
  }

  void sendTextMessage({
    required BuildContext context,
    required String textMessage,
    required String receiverId,
    required UserModel senderData,
  }) async {
    try {
      final timeSent = DateTime.now();
      final receiverDataMap =
          await firestore.collection('users').doc(receiverId).get();
      final receiverData = UserModel.fromMap(receiverDataMap.data()!);
      final textMessageId = const Uuid().v1();

      saveToMessageCollection(
          receiverId: receiverId,
          textMessage: textMessage,
          textMessageId: textMessageId,
          senderUsername: senderData.username,
          receiverUsername: receiverData.username,
          messageType: MessageType.text,
          timeSent: timeSent);

      saveAsLastMessage(
          senderUserData: senderData,
          receiverUserData: receiverData,
          lastMessage: textMessage,
          receiverId: receiverId,
          timeSent: timeSent);
    } catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }

  void saveToMessageCollection({
    required String receiverId,
    required String textMessage,
    required String textMessageId,
    required String senderUsername,
    required String receiverUsername,
    required MessageType messageType,
    required DateTime timeSent,
  }) async {
    final message = MessageModel(
        senderId: auth.currentUser!.uid,
        receiverId: receiverId,
        textMessage: textMessage,
        type: MessageType.text,
        timeSent: timeSent,
        messageId: textMessageId,
        isSeen: false);

    //sender
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .doc(textMessageId)
        .set(message.toMap());

    //receiver
    await firestore
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .collection('messages')
        .doc(textMessageId)
        .set(message.toMap());
  }

  void saveAsLastMessage({
    required UserModel senderUserData,
    required UserModel receiverUserData,
    required String lastMessage,
    required String receiverId,
    required DateTime timeSent,
  }) async {
    final receiveLastMessage = LastMessageModel(
        username: senderUserData.username,
        profileImageUrl: senderUserData.profileImageUrl,
        contactId: senderUserData.uid,
        timeSent: timeSent,
        lastMessage: lastMessage);

    await firestore
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .set(receiveLastMessage.toMap());

    final senderLastMessage = LastMessageModel(
        username: receiverUserData.username,
        profileImageUrl: receiverUserData.profileImageUrl,
        contactId: receiverUserData.uid,
        timeSent: timeSent,
        lastMessage: lastMessage);

    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverId)
        .set(senderLastMessage.toMap());
  }
}
