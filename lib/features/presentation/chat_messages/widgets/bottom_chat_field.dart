import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rent_house_app/features/data/models/user_model.dart';
import 'package:rent_house_app/features/services/chat_service.dart';

class BottomChatField extends StatefulWidget {
  final String receiverId;
  const BottomChatField({
    Key? key,
    required this.receiverId,
  }) : super(key: key);

  @override
  State<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends State<BottomChatField> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  bool isWritting = false;

  sendTextMessage() async {
    UserModel currentUser = UserModel(
      id: 'b6ROZ90YVOhuCU5kxOZVy0QxQ6t1',
      firstName: 'Yago',
      surnName: 'Mutango',
      phone: '12345678',
      email: 'yago@user.com',
      address: 'Estrada Nacional 280, EN280',
      latitude: -14.66254,
      longitude: 17.712765,
      image:
          'https://firebasestorage.googleapis.com/v0/b/homerent-a6208.appspot.com/o/profilePics%2F2023-07-29%2001%3A17%3A40.618135?alt=media&token=89048828-9e0c-4655-8b68-9674448b315d',
    );
    if (isWritting) {
      return _chatService.sendTextMessage(
        text: _messageController.text.trim(),
        receiverId: 'KYG7pdk3ESjmqusYsKYI',
        senderUser: currentUser,
      );
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _onTextChanged(String value) {
    setState(() {
      isWritting = value.trim().isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _messageController,
      style: const TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      onChanged: _onTextChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.5),
        focusColor: Colors.transparent,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        suffixIcon: Visibility(
          visible: isWritting,
          child: Container(
            height: 20.0,
            width: 20.0,
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: IconButton(
              onPressed: sendTextMessage,
              icon: const Icon(
                FontAwesomeIcons.paperPlane,
                size: 18.0,
              ),
              color: Colors.black,
            ),
          ),
        ),
        hintText: 'Escreva uma mensagem aqui...',
        hintStyle: const TextStyle(color: Colors.black),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        contentPadding: const EdgeInsets.all(15),
      ),
    );
  }
}
