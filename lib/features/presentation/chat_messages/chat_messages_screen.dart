import 'dart:developer';

import 'package:rent_house_app/features/data/chat_mocked_info.dart';

import 'package:rent_house_app/features/presentation/chat_messages/widgets/chat_list.dart';
import 'package:rent_house_app/features/services/user_manager.dart';

import '../home_screen/home.dart';

class ChatMessagesScreen extends StatefulWidget {
  static const routeName = '/chat-screen';
  const ChatMessagesScreen({
    Key? key,
    required this.name,
    required this.uid,
  }) : super(key: key);
  final String name;
  final String uid;
  @override
  State<ChatMessagesScreen> createState() => _ChatMessagesScreenState();
}

final TextEditingController _sendMessageController = TextEditingController();

class _ChatMessagesScreenState extends State<ChatMessagesScreen> {
  

  @override
  void dispose() {
    try {
      _sendMessageController.dispose();
    } catch (e) {
      log(e.toString());
    }
    super.dispose();
  }

  bool isWritting = false;

  final UserManager _userManager = UserManager();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return StreamBuilder(
        stream: _userManager.getByIdAsStream( widget.uid;),
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 212, 212, 212),
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(color: Colors.brown),
              title: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(80.0),
                    child: CachedNetworkImage(
                      imageUrl: info[3]['profilePic'].toString(),
                      fit: BoxFit.fill,
                      height: 30.0,
                      width: 30.0,
                      placeholder: (context, str) => Center(
                        child: Container(
                            color: Colors.white,
                            height: height,
                            width: width,
                            child: Image.asset('assets/loading.gif')),
                      ),
                      errorWidget: (context, url, error) =>
                          const ErrorIconOnFetching(),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    widget.name,
                    style: const TextStyle(
                      color: Colors.brown,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              centerTitle: false,
            ),
            body: Column(
              children: [
                const Expanded(
                  child: ChatList(),
                ),
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  onChanged: (value) {
                    setState(() {
                      if (value.trim().isNotEmpty) {
                        isWritting = true;
                      } else {
                        isWritting = false;
                      }
                    });
                  },
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
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              _sendMessageController.text = '';
                              log('Message Sent');
                            });
                          },
                          icon: const Icon(
                            FontAwesomeIcons.paperPlane,
                            size: 18.0,
                          ),
                          color: Colors.brown,
                        ),
                      ),
                    ),
                    hintText: 'Escreva um mensagem aqui...',
                    hintStyle: const TextStyle(color: Colors.black),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(15),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
