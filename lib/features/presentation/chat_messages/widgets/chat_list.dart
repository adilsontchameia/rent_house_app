import 'package:flutter/material.dart';
import 'package:rent_house_app/features/data/chat_mocked_info.dart';
import 'package:rent_house_app/features/presentation/chat_messages/widgets/my_message.dart';
import 'package:rent_house_app/features/presentation/chat_messages/widgets/sender_message.dart';

class ChatList extends StatelessWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
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
          itemBuilder: (context, index) {
            if (messages[index]['isMe'] == true) {
              return MyMessageCard(
                message: messages[index]['text'].toString(),
                date: messages[index]['time'].toString(),
              );
            }
            return SenderMessageCard(
              message: messages[index]['text'].toString(),
              date: messages[index]['time'].toString(),
            );
          },
        ),
      ],
    );
  }
}
