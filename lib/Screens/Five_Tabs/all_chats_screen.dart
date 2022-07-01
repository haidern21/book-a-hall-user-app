import 'package:book_a_hall/Screens/conversation_screen.dart';
import 'package:book_a_hall/provider/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/chat_model.dart';
import '../../constants/consonants.dart';

class AllChatsScreen extends StatefulWidget {
  const AllChatsScreen({Key? key}) : super(key: key);

  @override
  State<AllChatsScreen> createState() => _AllChatsScreenState();
}

class _AllChatsScreenState extends State<AllChatsScreen> {
  Future? future;
  List<ChatModel> messageIds = [];

  @override
  void initState() {
    Provider.of<ChatProvider>(context, listen: false).getUserChatWithAdmin();
    future = Provider.of<ChatProvider>(context, listen: false)
        .getUserChatWithAdmin();
    Provider.of<ChatProvider>(context, listen: false).getUnreadChatWithAdmin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ChatProvider chatProvider = Provider.of(context);
    messageIds = chatProvider.unreadMessages;
    // chatProvider.getUserChatWithAdmin();
    // chatProvider.getUnreadChatWithAdmin();
    return Scaffold(
        appBar: AppBar(
          title: const Text(' MESSAGES'),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    greenGradientColor5,
                    greenGradientColor1,
                    greenGradientColor4,
                    greenGradientColor6,
                    greenGradientColor7,
                  ]),
            ),
          ),
        ),
        body:
            // chatProvider.allMessages.isNotEmpty
            //     ?
            FutureBuilder(
          future: future,
          builder: (context, snap) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Column(
                children: [
                  Expanded(
                      child: ListView(
                    children: [
                      InkWell(
                        onTap: () async {
                          await chatProvider.clearUnreadMessage(messageIds);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ConversationScreen()));
                        },
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey, width: 2)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              trailing: messageIds.isNotEmpty
                                  ?  Container(
                                      height: 20,
                                      width: 20,
                                      decoration: const BoxDecoration(
                                        color: purpleColor,
                                        shape: BoxShape.circle
                                      ),
                                      child: Center(
                                        child: Text(messageIds.length.toString(),style: const TextStyle(color: Colors.white,fontSize: 10),),
                                      ),
                                    )
                                  : const SizedBox(
                                      height: 14,
                                    ),
                              leading: const CircleAvatar(
                                  backgroundColor: purpleColor,
                                  radius: 30,
                                  child: Icon(
                                    Icons.person,
                                    size: 40,
                                    color: Colors.white,
                                  )),
                              title: const Text(
                                'ADMIN',
                                style: TextStyle(
                                    color: purpleColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            );
          },
        )
        //     // : Center(
        //     //     child: Image.asset('assets/images/no_fav.png'),
        //     //   ),
        );
  }
}
