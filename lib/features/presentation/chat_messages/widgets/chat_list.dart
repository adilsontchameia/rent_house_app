import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:rent_house_app/features/data/models/message_model.dart';
import 'package:rent_house_app/features/presentation/chat_messages/widgets/my_message.dart';
import 'package:rent_house_app/features/presentation/chat_messages/widgets/sender_message.dart';
import 'package:rent_house_app/features/services/auth_service.dart';
import 'package:rent_house_app/features/services/chat_service.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key, required this.sellerId}) : super(key: key);
  final String sellerId;

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  final ScrollController messageController = ScrollController();
  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return StreamBuilder<QuerySnapshot>(
      stream: _chatService.getAllChatsMessage(widget.sellerId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text(
              'Carregando...',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('Diz Olá !'),
          );
        } else {
          final messages = snapshot.data!.docs
              .map((doc) =>
                  MessageModel.fromMap(doc.data() as Map<String, dynamic>))
              .toList();
          SchedulerBinding.instance.addPostFrameCallback((_) {
            messageController
                .jumpTo(messageController.position.maxScrollExtent);
          });
          return Stack(
            children: [
              Opacity(
                opacity: 0.3,
                child: Image.asset(
                  'assets/home_view.jpg',
                  fit: BoxFit.fitHeight,
                  height: height,
                ),
              ),
              ListView.builder(
                itemCount: messages.length,
                controller: messageController,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final isMe = message.senderId == _authService.getUser().uid;

                  //?Check if another user read the message
                  if (!message.isSeen &&
                      message.receiverId == _authService.getUser().uid) {
                    _chatService.setChatMessageSeen(
                      message.receiverId,
                      message.messageId,
                    );
                  }
                  DateTime dateTime = message.date;
                  String formattedTime = DateFormat('HH:mm').format(dateTime);

                  if (isMe) {
                    return MyMessageCard(
                      message: message.message,
                      date: formattedTime.toString(),
                      isSeen: message.isSeen,
                    );
                  } else {
                    return SenderMessageCard(
                      message: message.message,
                      date: formattedTime.toString(),
                    );
                  }
                },
              ),
            ],
          );
        }
      },
    );
  }

  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = '${diff.inDays} DAY AGO';
      } else {
        time = '${diff.inDays} DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = '${(diff.inDays / 7).floor()} WEEK AGO';
      } else {
        time = '${(diff.inDays / 7).floor()} WEEKS AGO';
      }
    }

    return time;
  }
}
