import 'package:book_a_hall/constants/consonants.dart';

class ChatModel {
  String? message;
  DateTime? time;
  String? sentBy;
  String? sentTo;
  String? messageId;
  bool? seen;

  ChatModel({
    this.sentBy,
    this.message,
    this.sentTo,
    this.time,
    this.messageId,
    this.seen
  });

  Map<String, dynamic> asMap() {
    return {
      kMessage: message??'',
      kSentBy: sentBy??'',
      kSentTo: sentTo??'',
      kDateTime: time??'',
      kMessageId:messageId??'',
      kSeen:seen??false
    };
  }
}
