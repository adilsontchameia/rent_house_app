import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rent_house_app/features/data/models/message_model.dart';
import 'package:rent_house_app/features/presentation/chat_messages/widgets/my_message.dart';
import 'package:rent_house_app/features/presentation/chat_messages/widgets/sender_message.dart';
import 'package:intl/intl.dart';

class ChatList extends StatelessWidget {
  const ChatList({Key? key}) : super(key: key);

  final String currentId = 'b6ROZ90YVOhuCU5kxOZVy0QxQ6t1';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(currentId)
          .collection('messages')
          .doc('KYG7pdk3ESjmqusYsKYI')
          .collection('chats')
          .orderBy(
            'date',
            descending: true,
          )
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('Say Hi !'),
          );
        } else {
          // Convert the QuerySnapshot to a list of MessageModel objects
          final messages = snapshot.data!.docs
              .map((doc) =>
                  MessageModel.fromMap(doc.data() as Map<String, dynamic>))
              .toList();

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
                //reverse: true,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final isMe = message.senderId == currentId;

                  // Format the DateTime to show only the hour and time
                  final formattedDate =
                      DateFormat('HH:mm a').format(message.date);

                  if (isMe) {
                    return MyMessageCard(
                      message: message.message,
                      date: formattedDate, // Use the formatted date here
                    );
                  } else {
                    return SenderMessageCard(
                      message: message.message,
                      date: formattedDate, // Use the formatted date here
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
}
