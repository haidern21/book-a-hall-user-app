import 'package:book_a_hall/constants/consonants.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HallBookModel {
  String? userId;
  String? userName;
  String? userEmail;
  String? userPhoneNumber;
  String? eventDate;
  String? eventType;
  String? orderId;
  String? hallName;
  String? orderStatus;
  String? orderDate;
  String? userProfilePicture;

  HallBookModel(
      {this.eventType,
      this.userId,
      this.userPhoneNumber,
      this.userEmail,
      this.userName,
      this.orderDate,
      this.orderId,
      this.orderStatus,
      this.hallName,
      this.eventDate,
      this.userProfilePicture});

  Map<String, dynamic> asMap() {
    return {
      kUserId: userId ?? '',
      kUserName: userName ?? '',
      kUserPhoneNumber: userPhoneNumber ?? '',
      kProfilePicture: userProfilePicture ?? '',
      kEventDate: eventDate ?? '',
      kEventType: eventType ?? '',
      kUserEmail: userEmail ?? '',
      kHallName: hallName ?? '',
      kOrderStatus: orderStatus ?? 'Processing',
      kOrderId: orderId ?? '',
      kOrderDate: orderDate ?? DateTime.now().toString(),
    };
  }
}
