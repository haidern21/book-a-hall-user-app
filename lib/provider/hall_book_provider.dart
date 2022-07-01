import 'package:book_a_hall/Models/hall_book_model.dart';
import 'package:book_a_hall/constants/consonants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class HallBookProvider with ChangeNotifier {
  List<HallBookModel> inProcessOrder = [];
  List<HallBookModel> orderHistory = [];
  List<HallBookModel> cancelledOrder = [];
  List<HallBookModel> userNotifications = [];

  getInProcessOrders(String userId) async {
    print('hall bok place orders');
    List<HallBookModel> tempInProcessOrders = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection(kOrders)
        .orderBy(kOrderDate, descending: false)
        .get();
    for (var element in value.docs) {
      if (element.get(kUserId) == userId &&
          element.get(kOrderStatus) == kProcessing) {
        HallBookModel hallBookModel = HallBookModel(
          userId: element.get(kUserId) ?? '',
          hallName: element.get(kHallName) ?? '',
          userName: element.get(kUserName) ?? '',
          eventDate: element.get(kEventDate) ?? '',
          eventType: element.get(kEventType) ?? '',
          userEmail: element.get(kUserEmail) ?? '',
          userPhoneNumber: element.get(kUserPhoneNumber) ?? '',
          userProfilePicture: element.get(kProfilePicture) ?? '',
          orderId: element.get(kOrderId) ?? '',
          orderStatus: element.get(kOrderStatus) ?? '',
          orderDate: element.get(kOrderDate) ?? '',
        );
        tempInProcessOrders.add(hallBookModel);
      }
    }
    inProcessOrder = tempInProcessOrders;
    notifyListeners();
  }

  getOrderHistory(String userId) async {
    print('hall book histore');
    List<HallBookModel> tempOrderHistory = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection(kOrders)
        .orderBy(kOrderDate, descending: false)
        .get();
    for (var element in value.docs) {
      if (element.get(kUserId) == userId &&
          element.get(kOrderStatus) == kCompleted) {
        HallBookModel hallBookModel = HallBookModel(
          userId: element.get(kUserId) ?? '',
          hallName: element.get(kHallName) ?? '',
          userName: element.get(kUserName) ?? '',
          eventDate: element.get(kEventDate) ?? '',
          eventType: element.get(kEventType) ?? '',
          userEmail: element.get(kUserEmail) ?? '',
          userPhoneNumber: element.get(kUserPhoneNumber) ?? '',
          userProfilePicture: element.get(kProfilePicture) ?? '',
          orderId: element.get(kOrderId) ?? '',
          orderStatus: element.get(kOrderStatus) ?? '',
          orderDate: element.get(kOrderDate) ?? '',
        );
        tempOrderHistory.add(hallBookModel);
      }
    }
    orderHistory = tempOrderHistory;
    notifyListeners();
  }

  getCancelledOrder(String userId) async {
    print('hall book cancelled orders');
    List<HallBookModel> tempCancelledOrder = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection(kOrders)
        .orderBy(kOrderDate, descending: false)
        .get();
    for (var element in value.docs) {
      if (element.get(kOrderStatus) == kCancelled &&
          element.get(kUserId) == userId) {
        HallBookModel hallBookModel = HallBookModel(
          userId: element.get(kUserId) ?? '',
          hallName: element.get(kHallName) ?? '',
          userName: element.get(kUserName) ?? '',
          eventDate: element.get(kEventDate) ?? '',
          eventType: element.get(kEventType) ?? '',
          userEmail: element.get(kUserEmail) ?? '',
          userPhoneNumber: element.get(kUserPhoneNumber) ?? '',
          userProfilePicture: element.get(kProfilePicture) ?? '',
          orderId: element.get(kOrderId) ?? '',
          orderStatus: element.get(kOrderStatus) ?? '',
          orderDate: element.get(kOrderDate) ?? '',
        );
        tempCancelledOrder.add(hallBookModel);
      }
    }
    cancelledOrder = tempCancelledOrder;
    notifyListeners();
  }

  getUserNotification(String userId) async {
    List<HallBookModel> tempUserNotifications = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection(kOrders)
        .orderBy(kOrderDate, descending: false)
        .get();
    for (var element in value.docs) {
      if ((element.get(kOrderStatus) == kCompleted ||
              element.get(kOrderStatus) == kCancelled) &&
          (element.get(kOrderDate) ==
              DateTime.now().toString().substring(0, 10)||element.get(kOrderDate) ==
              DateTime.now().subtract(const Duration(days: 1)).toString().substring(0, 10)||element.get(kOrderDate) ==
              DateTime.now().subtract(const Duration(days: 2)).toString().substring(0, 10)) &&
          element.get(kUserId) == userId) {
        HallBookModel hallBookModel = HallBookModel(
          userId: element.get(kUserId) ?? '',
          hallName: element.get(kHallName) ?? '',
          userName: element.get(kUserName) ?? '',
          eventDate: element.get(kEventDate) ?? '',
          eventType: element.get(kEventType) ?? '',
          userEmail: element.get(kUserEmail) ?? '',
          userPhoneNumber: element.get(kUserPhoneNumber) ?? '',
          userProfilePicture: element.get(kProfilePicture) ?? '',
          orderId: element.get(kOrderId) ?? '',
          orderStatus: element.get(kOrderStatus) ?? '',
          orderDate: element.get(kOrderDate) ?? '',
        );
        tempUserNotifications.add(hallBookModel);
      }
    }
    userNotifications = tempUserNotifications;
    notifyListeners();
  }
}
