import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rent_house_app/features/services/chat_service.dart';
import 'package:rent_house_app/features/services/user_manager.dart';

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
  final UserManager _userManager = UserManager();
  bool isWritting = false;

  sendTextMessage() async {
    setState(() {
      if (isWritting) {
        final message = _messageController.text.trim();
        _chatService.sendTextMessage(
          message: message,
          sellerId: widget.receiverId,
        );
      }
      _messageController.text = '';
      _userManager.isNotWriting();
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _userManager.isNotWriting();
    super.dispose();
  }

  void _onTextChanged(String value) {
    setState(() {
      isWritting = value.trim().isNotEmpty;
      if (isWritting) {
        _userManager.isWriting();
      } else {
        _userManager.isNotWriting();
      }
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
