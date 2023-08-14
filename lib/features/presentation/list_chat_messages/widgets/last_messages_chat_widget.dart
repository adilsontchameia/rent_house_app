import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rent_house_app/features/presentation/chat_messages/chat_messages_screen.dart';

import '../../../services/auth_service.dart';
import '../../../services/chat_service.dart';
import '../../home_screen/home.dart';

class LastMessagesChatWidget extends StatelessWidget {
  LastMessagesChatWidget({super.key});
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _chatService.listAllChatsMessage(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //? Filtering to skip current user UID
          final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
          final currentUserUid = _authService.getUser().uid;
          final filteredUIDs = documents
              .map((doc) => doc.id)
              .where((uid) => uid != currentUserUid)
              .toList();

          return SizedBox(
            height: 200.0,
            child: ListView.builder(
              itemCount: filteredUIDs.length,
              itemBuilder: (context, index) {
                final uid = filteredUIDs[index];
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    ChatMessagesScreen.routeName,
                    arguments: {
                      'name': 'Name', //TODO store userName on model either
                      'uid': uid,
                    },
                  ),
                  child: FutureBuilder<Map<String, dynamic>>(
                    future: _chatService.getLastMessage(uid),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final lastMessage = snapshot.data!;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(80.0),
                              child: CachedNetworkImage(
                                //TODO store seller imageUrl
                                imageUrl:
                                    'https://firebasestorage.googleapis.com/v0/b/homerent-a6208.appspot.com/o/profilePics%2F2023-08-02%2016%3A29%3A40.016667?alt=media&token=abb87b01-47c9-4762-812f-e8bb7be31be8',
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressOnFecthing(),
                                ),
                                errorWidget: (context, url, error) =>
                                    const ErrorIconOnFetching(),
                                fit: BoxFit.fill,
                                height: 50.0,
                                width: 50.0,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    uid,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.brown,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        lastMessage['lastMessage'],
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      Text(
                                        lastMessage['lastMessageDate']
                                            .toString(),
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.brown,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
