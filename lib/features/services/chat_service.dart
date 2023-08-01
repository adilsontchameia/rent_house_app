// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:rent_house_app/app/app.dart';
import 'package:rent_house_app/core/factories/dialogs.dart';
import 'package:rent_house_app/features/data/models/chat_contact.dart';
import 'package:rent_house_app/features/data/models/message_model.dart';
import 'package:rent_house_app/features/services/services.dart';
import 'package:uuid/uuid.dart';

class ChatService extends ChangeNotifier {
  late FirebaseFirestore firestore;
  late FirebaseAuth auth;
  final ShowAndHideDialogs _dialogs = ShowAndHideDialogs();
  static const usersCollection = 'users';
  static const chatsCollection = 'users';
  static const messagesCollection = 'users';

  ChatService() {
    firestore = FirebaseFirestore.instance;
    auth = FirebaseAuth.instance;
  }

  void _saveDataToContactSubCollection(
    UserModel senderUserData,
    UserModel receiverUserData,
    String text,
    DateTime timeSent,
    String receiverUserId,
  ) async {
    //? users -> receiverId -> chats -> store data
    var receiverChatContact = ChatContacts(
      name: '${senderUserData.firstName} ${senderUserData.surnName}',
      profilePic: senderUserData.image!,
      contactId: senderUserData.id!,
      timeSent: timeSent,
      lastMessage: text,
    );
    await firestore
        .collection(usersCollection)
        .doc(receiverUserId)
        .collection(chatsCollection)
        .doc(auth.currentUser!.uid)
        .set(
          receiverChatContact.toMap(),
        );
    //? users -> currentId -> chats -> store data
    var senderChatContact = ChatContacts(
      name: '${receiverUserData.firstName} ${receiverUserData.surnName}',
      profilePic: receiverUserData.image!,
      contactId: receiverUserData.id!,
      timeSent: timeSent,
      lastMessage: text,
    );
    await firestore
        .collection(usersCollection)
        .doc(auth.currentUser!.uid)
        .collection(chatsCollection)
        .doc(receiverUserId)
        .set(
          senderChatContact.toMap(),
        );
    notifyListeners();
  }

  void _saveMessageToMessageSubcollection({
    required String receiverUserId,
    required String text,
    required DateTime timeSent,
    required String messageId,
    required String userName,
    required String receiverUsername,
  }) async {
    final message = MessageModel(
      senderId: auth.currentUser!.uid,
      receiverId: receiverUserId,
      text: text,
      timeSent: timeSent,
      messageId: messageId,
      isSeen: false,
    );
    //? users ->  senderId -> receiverId -> messages -> store message
    await firestore
        .collection(usersCollection)
        .doc(receiverUserId)
        .collection(chatsCollection)
        .doc(auth.currentUser!.uid)
        .collection(messagesCollection)
        .doc(messageId)
        .set(
          message.toMap(),
        );
    //? users ->  senderId -> receiverId -> messages -> store message
    await firestore
        .collection(usersCollection)
        .doc(auth.currentUser!.uid)
        .collection(chatsCollection)
        .doc(receiverUserId)
        .collection(messagesCollection)
        .doc(messageId)
        .set(
          message.toMap(),
        );
    notifyListeners();
  }

  sendTextMessage({
    required String text,
    required String receiverId,
    required UserModel senderUser,
  }) async {
    //Chat schema
    //? user (senderId) -> receiverId -> messageId(collection) -> store message
    try {
      var timeSent = DateTime.now();
      UserModel receiverUserData;
      var userDataMap =
          await firestore.collection(usersCollection).doc(receiverId).get();

      receiverUserData = UserModel.fromJson(userDataMap.data()!);

      //? Generate unique userID
      var messageId = const Uuid().v1();
      //Saving the data to 2 collections
      _saveDataToContactSubCollection(
        senderUser,
        receiverUserData,
        text,
        timeSent,
        receiverId,
      );

      _saveMessageToMessageSubcollection(
        receiverUserId: receiverId,
        text: text,
        timeSent: timeSent,
        messageId: messageId,
        receiverUsername:
            '${receiverUserData.firstName} ${receiverUserData.surnName}',
        userName: '${senderUser.firstName} ${senderUser.surnName}',
      );
    } catch (e) {
      _dialogs.showToastMessage(e.toString());
    }
    notifyListeners();
  }
}
