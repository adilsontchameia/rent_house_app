import 'package:flutter/material.dart';

class ChatMessageScreen extends StatelessWidget {
  const ChatMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                //TODO custom modern and sells font
                'CHAT MESSAGES',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 21.0,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(
                height: height,
                width: width * 5,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //TODO profile pic
                          ClipRRect(
                            borderRadius: BorderRadius.circular(80.0),
                            child: Image.asset(
                              'assets/home_view.jpg',
                              fit: BoxFit.fill,
                              height: 50.0,
                              width: 50.0,
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          //TODO sender name
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Adilson Tchameia',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                //TODO message
                                Text(
                                  'Acho que vou ligar amanhã pelas 8h. Concordas ',
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
            ]),
          )),
    );
  }
}
