import 'package:rent_house_app/features/presentation/chat_messages/widgets/bottom_chat_field.dart';
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

class _ChatMessagesScreenState extends State<ChatMessagesScreen> {
  final UserManager _userManager = UserManager();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 212, 212, 212),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.brown),
        title: StreamBuilder(
            stream: _userManager.getSellerById(widget.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(80.0),
                    child: CachedNetworkImage(
                      imageUrl: snapshot.data!.image!,
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: const TextStyle(
                          color: Colors.brown,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        snapshot.data!.isOnline! ? 'online' : 'offline',
                        style: const TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                        ),
                      ),
                    ],
                  )
                ],
              );
            }),
        centerTitle: false,
      ),
      body: Column(
        children: [
          const Expanded(
            child: ChatList(),
          ),
          BottomChatField(receiverId: widget.uid),
        ],
      ),
    );
  }
}
