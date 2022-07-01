import 'package:book_a_hall/Models/chat_model.dart';
import 'package:book_a_hall/Widgets/chat_bubble_widget.dart';
import 'package:book_a_hall/provider/chat_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../constants/consonants.dart';
import 'package:async/async.dart';
class ConversationScreen extends StatefulWidget {
  const ConversationScreen({Key? key}) : super(key: key);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  TextEditingController messageController = TextEditingController();

  // getUnreadMessageCount() async {
  //   var userId = FirebaseAuth.instance.currentUser!.uid.toString();
  //   DocumentSnapshot value = await FirebaseFirestore.instance
  //       .collection(kAdmin)
  //       .doc('a9WBHXTOwETcS3Qwlx7M')
  //       .collection(kContacts)
  //       .doc(userId)
  //       .get();
  // }

  bool loader = false;
  // ChatProvider? chatProvider;
  Future? future;
  // final AsyncMemoizer _memoizer = AsyncMemoizer();
  List<ChatModel> messageIds=[];
  @override
  void initState() {
     Provider.of<ChatProvider>(context, listen: false)
        .getUserChatWithAdmin();
     future= Provider.of<ChatProvider>(context, listen: false)
         .getUserChatWithAdmin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ChatModel chatModel = ChatModel();
    ChatProvider chatProvider = Provider.of(context);
    chatProvider.unreadMessages=[];
    // chatProvider.getUserChatWithAdmin();
    // List<ChatModel> messageIds = chatProvider.unreadMessages;
    // chatProvider.clearUnreadMessage(messageIds);
    // for (var element in messageIds) {
    //   FirebaseFirestore.instance
    //       .collection(kChats)
    //       .doc(element.messageId)
    //       .update({
    //     kSeen: true,
    //   });
    //   print('Updated');
    // }
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADMIN'),
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                  builder: (context,snap){
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        return InkWell(
                          onLongPress: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return SizedBox(
                                    height: 150,
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            await FirebaseFirestore.instance
                                                .collection(kChats)
                                                .doc(chatProvider
                                                .allMessages[index].messageId)
                                                .delete();
                                            Navigator.pop(context);
                                          },
                                          child: const ListTile(
                                            title: Text('Delete Message'),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: const ListTile(
                                            title: Text('Cancel'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: ChatBubbleWidget(
                            text: chatProvider.allMessages[index].message!,
                            dateTime:
                            chatProvider.allMessages[index].time.toString(),
                            isYourMessage:
                            chatProvider.allMessages[index].sentBy ==
                                FirebaseAuth.instance.currentUser!.uid
                                    .toString()
                                ? true
                                : false,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 5,
                      ),
                      itemCount: chatProvider.allMessages.length,
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: TextFormField(
                    controller: messageController,
                    decoration: InputDecoration(
                        hintText: 'Enter Message',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: greenColor,
                              width: 1,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: greenColor,
                              width: 1,
                            )),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: greenColor,
                            width: 1,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: greenColor,
                            width: 1,
                          ),
                        ),
                        suffixIcon: InkWell(
                            onTap: () async {
                              if (FirebaseAuth.instance.currentUser != null &&
                                  messageController.text.isNotEmpty) {
                                try {
                                  var messageId = const Uuid().v1();
                                  setState(() {
                                    loader = true;
                                  });
                                  chatModel.time = DateTime.now();
                                  chatModel.sentTo = '123456789';
                                  chatModel.sentBy = FirebaseAuth
                                      .instance.currentUser!.uid
                                      .toString();
                                  chatModel.message =
                                      messageController.text.trim();
                                  chatModel.seen = true;
                                  chatModel.messageId = messageId;
                                  await FirebaseFirestore.instance
                                      .collection(kChats)
                                      .doc(messageId)
                                      .set(chatModel.asMap());
                                  messageController.clear();
                                  var userId = FirebaseAuth
                                      .instance.currentUser!.uid
                                      .toString();
                                  await FirebaseFirestore.instance
                                      .collection(kAdmin)
                                      .doc('a9WBHXTOwETcS3Qwlx7M')
                                      .collection(kContacts)
                                      .doc(userId)
                                      .set({
                                    'user-id': userId,
                                    'last-message': DateTime.now().toString(),
                                  });
                                  await chatProvider.getUserChatWithAdmin();
                                  await FirebaseFirestore.instance
                                      .collection(kUsers)
                                      .doc(userId)
                                      .update({
                                    kUnReadMessage: FieldValue.increment(1),
                                  }).then((value) => print('unread count +1'));
                                  setState(() {
                                    loader = false;
                                  });
                                } on FirebaseException catch (e) {
                                  setState(() {
                                    loader = false;
                                  });
                                }
                              }
                            },
                            child: loader == false
                                ? const Icon(Icons.send, color: purpleColor)
                                : const CircularProgressIndicator(
                              color: Colors.black,
                            ))),
                  ),
                ),
              ),
            ],
          ),
        ),
      // body: FutureBuilder(
      //     builder: (context, snapshot) {
      //   return Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 15.0),
      //     child: Column(
      //       children: [
      //         Expanded(
      //           child: ListView.separated(
      //             itemBuilder: (context, index) {
      //               return InkWell(
      //                 onLongPress: () {
      //                   showModalBottomSheet(
      //                       context: context,
      //                       builder: (context) {
      //                         return SizedBox(
      //                           height: 150,
      //                           child: Column(
      //                             children: [
      //                               InkWell(
      //                                 onTap: () async {
      //                                   await FirebaseFirestore.instance
      //                                       .collection(kChats)
      //                                       .doc(chatProvider!
      //                                           .allMessages[index].messageId)
      //                                       .delete();
      //                                   Navigator.pop(context);
      //                                 },
      //                                 child: const ListTile(
      //                                   title: Text('Delete Message'),
      //                                 ),
      //                               ),
      //                               InkWell(
      //                                 onTap: () {
      //                                   Navigator.pop(context);
      //                                 },
      //                                 child: const ListTile(
      //                                   title: Text('Cancel'),
      //                                 ),
      //                               ),
      //                             ],
      //                           ),
      //                         );
      //                       });
      //                 },
      //                 child: ChatBubbleWidget(
      //                   text: chatProvider!.allMessages[index].message!,
      //                   dateTime:
      //                       chatProvider!.allMessages[index].time.toString(),
      //                   isYourMessage:
      //                       chatProvider!.allMessages[index].sentBy ==
      //                               FirebaseAuth.instance.currentUser!.uid
      //                                   .toString()
      //                           ? true
      //                           : false,
      //                 ),
      //               );
      //             },
      //             separatorBuilder: (context, index) => const SizedBox(
      //               height: 5,
      //             ),
      //             itemCount: chatProvider!.allMessages.length,
      //           ),
      //         ),
      //         Align(
      //           alignment: Alignment.bottomCenter,
      //           child: Padding(
      //             padding: const EdgeInsets.symmetric(vertical: 20.0),
      //             child: TextFormField(
      //               controller: messageController,
      //               decoration: InputDecoration(
      //                   hintText: 'Enter Message',
      //                   enabledBorder: OutlineInputBorder(
      //                       borderRadius: BorderRadius.circular(10),
      //                       borderSide: const BorderSide(
      //                         color: greenColor,
      //                         width: 1,
      //                       )),
      //                   focusedBorder: OutlineInputBorder(
      //                       borderRadius: BorderRadius.circular(10),
      //                       borderSide: const BorderSide(
      //                         color: greenColor,
      //                         width: 1,
      //                       )),
      //                   errorBorder: OutlineInputBorder(
      //                     borderRadius: BorderRadius.circular(10),
      //                     borderSide: const BorderSide(
      //                       color: greenColor,
      //                       width: 1,
      //                     ),
      //                   ),
      //                   focusedErrorBorder: OutlineInputBorder(
      //                     borderRadius: BorderRadius.circular(10),
      //                     borderSide: const BorderSide(
      //                       color: greenColor,
      //                       width: 1,
      //                     ),
      //                   ),
      //                   suffixIcon: InkWell(
      //                       onTap: () async {
      //                         if (FirebaseAuth.instance.currentUser != null &&
      //                             messageController.text.isNotEmpty) {
      //                           try {
      //                             var messageId = const Uuid().v1();
      //                             setState(() {
      //                               loader = true;
      //                             });
      //                             chatModel.time = DateTime.now();
      //                             chatModel.sentTo = '123456789';
      //                             chatModel.sentBy = FirebaseAuth
      //                                 .instance.currentUser!.uid
      //                                 .toString();
      //                             chatModel.message =
      //                                 messageController.text.trim();
      //                             chatModel.seen = false;
      //                             chatModel.messageId = messageId;
      //                             await FirebaseFirestore.instance
      //                                 .collection(kChats)
      //                                 .doc(messageId)
      //                                 .set(chatModel.asMap());
      //                             messageController.clear();
      //                             var userId = FirebaseAuth
      //                                 .instance.currentUser!.uid
      //                                 .toString();
      //                             await FirebaseFirestore.instance
      //                                 .collection(kAdmin)
      //                                 .doc('a9WBHXTOwETcS3Qwlx7M')
      //                                 .collection(kContacts)
      //                                 .doc(userId)
      //                                 .set({
      //                               'user-id': userId,
      //                               'last-message': DateTime.now().toString(),
      //                             });
      //                             await FirebaseFirestore.instance
      //                                 .collection(kUsers)
      //                                 .doc(userId)
      //                                 .update({
      //                               kUnReadMessage: FieldValue.increment(1),
      //                             });
      //                             setState(() {
      //                               loader = false;
      //                             });
      //                           } on FirebaseException catch (e) {
      //                             setState(() {
      //                               loader = false;
      //                             });
      //                           }
      //                         }
      //                       },
      //                       child: loader == false
      //                           ? const Icon(Icons.send, color: purpleColor)
      //                           : const CircularProgressIndicator(
      //                               color: Colors.black,
      //                             ))),
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   );
      // }),
    );
  }
}
