import 'package:book_a_hall/Models/chat_model.dart';
import 'package:book_a_hall/constants/consonants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ChatProvider extends ChangeNotifier {
  List<ChatModel> allMessages = [];
  List<ChatModel> unreadMessages=[];

  getUserChatWithAdmin() async {
    print('get user chat with admin');
    List<ChatModel> tempChat = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection(kChats)
        .orderBy(kDateTime, descending: false)
        .get();
    for (var element in value.docs) {
      if (element.get(kSentTo) == '123456789' &&
          element.get(kSentBy) ==
              FirebaseAuth.instance.currentUser!.uid.toString()) {
        ChatModel chatModel = ChatModel(
          message: element.get(kMessage),
          sentTo: element.get(kSentTo),
          sentBy: element.get(kSentBy),
          time: (element.get(kDateTime) as Timestamp).toDate(),
        );
        tempChat.add(chatModel);
      }
      if (element.get(kSentTo) ==
              FirebaseAuth.instance.currentUser!.uid.toString() &&
          element.get(kSentBy) == '123456789') {
        ChatModel chatModel = ChatModel(
          message: element.get(kMessage),
          sentTo: element.get(kSentTo),
          sentBy: element.get(kSentBy),
          time: (element.get(kDateTime) as Timestamp).toDate(),
        );
        tempChat.add(chatModel);
      }
    }
    allMessages = tempChat;
    notifyListeners();
  }

  getUnreadChatWithAdmin() async {
    print('get un read chat with admin');
    List<ChatModel> tempUnreadMessages = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection(kChats)
        .orderBy(kDateTime, descending: false)
        .get();
    for (var element in value.docs) {
      if (element.get(kSentTo) ==
          FirebaseAuth.instance.currentUser!.uid.toString() &&
          element.get(kSentBy) == '123456789'&&element.get(kSeen)==false) {
        ChatModel chatModel = ChatModel(
          message: element.get(kMessage),
          sentTo: element.get(kSentTo),
          sentBy: element.get(kSentBy),
          time: (element.get(kDateTime) as Timestamp).toDate(),
          messageId: element.get(kMessageId),
          seen: element.get(kSeen),
        );
        tempUnreadMessages.add(chatModel);
      }
    }
    unreadMessages = tempUnreadMessages;
    notifyListeners();
  }

  clearUnreadMessage(List<ChatModel> messageIds){
    print('clear- un read messages ');
    for (var element in messageIds) {
      FirebaseFirestore.instance
          .collection(kChats)
          .doc(element.messageId)
          .update({
        kSeen: true,
      });
    }
  }
}
