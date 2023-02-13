import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rent_house_app/app/app.dart';
import 'package:rent_house_app/features/data/models/chat_contact.dart';
import 'package:rent_house_app/features/data/models/user_model.dart';
import 'package:uuid/uuid.dart';

import '../../core/factories/dialogs.dart';
import '../data/models/message_model.dart';

class ChatService extends ChangeNotifier {
  late FirebaseFirestore firestore;
  late FirebaseAuth auth;
  final ShowAndHideDialogs _dialogs = ShowAndHideDialogs();

  ChatService() {
    firestore = FirebaseFirestore.instance;
    auth = FirebaseAuth.instance;
  }

  void sendTextMessage({
    required String message,
    required String sellerId,
    required UserModel currentUserData,
  }) async {
    try {
      final DateTime timeSent = DateTime.now();
      log(timeSent.toString());
      log(currentUserData.image!);
      final currentId = auth.currentUser!.uid;
      final messageId = const Uuid().v1();
      final messageModel = MessageModel(
        senderId: currentId,
        receiverId: sellerId,
        message: message,
        date: timeSent,
        messageId: messageId,
        isSeen: false,
      );
      final contactChatModel = ChatContact(
        name: currentUserData.fullName!,
        profilePic: currentUserData.image!,
        contactId: currentUserData.id!,
        timeSent: timeSent,
        lastMessage: message,
      );
      await FirebaseFirestore.instance
          .collection('messages')
          .doc(sellerId)
          .collection('chats')
          .doc(messageId)
          .set(
            messageModel.toMap(),
          );
      log('Sender: ${auth.currentUser!.uid}');
      // Update last message for the seller
      await FirebaseFirestore.instance
          .collection('messages')
          .doc(sellerId)
          .set({
        'timeSent': timeSent,
        'lastMessage': message,
      });

      //_ User who we are talking to
      await FirebaseFirestore.instance
          .collection('messages')
          .doc(currentId)
          .collection('chats')
          .doc(messageId)
          .set(
            messageModel.toMap(),
          );

      // Update last message for the current user
      await FirebaseFirestore.instance
          .collection('messages')
          .doc(currentId)
          .set(
            contactChatModel.toMap(),
          );
    } catch (e) {
      _dialogs.showToastMessage(e.toString());
    }
  }

  Future<void> setChatMessageSeen(String userId, String messageId) async {
    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final chatDocRef = FirebaseFirestore.instance
            .collection('messages')
            .doc(userId)
            .collection('chats')
            .doc(messageId);

        final chatSnapshot = await transaction.get(chatDocRef);

        if (chatSnapshot.exists) {
          if (!chatSnapshot.data()!['isSeen']) {
            transaction.update(chatDocRef, {'isSeen': true});
          }
        }
      });
    } catch (e) {
      log('Error updating isSeen: $e');
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllChatsMessage(
      String sellerId) {
    return FirebaseFirestore.instance
        .collection('messages')
        .doc(sellerId)
        .collection('chats')
        .orderBy(
          'date',
          descending: false,
        )
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> listAllChatsMessage() {
    return FirebaseFirestore.instance.collection('messages').snapshots();
  }

  Future<ChatContact> getLastMessage(String chatId) async {
    ChatContact chatContact = ChatContact();

    final documentSnapshot = await FirebaseFirestore.instance
        .collection('messages')
        .doc(chatId)
        .get();

    if (documentSnapshot.exists) {
      return chatContact = ChatContact.fromMap(
        documentSnapshot.data() as Map<String, dynamic>,
      );
    } else {
      return chatContact;
    }
  }
}
