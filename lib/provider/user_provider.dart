import 'package:book_a_hall/Models/user_model.dart';
import 'package:book_a_hall/constants/consonants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  UserModel user = UserModel();
  List<UserModel> allUser=[];

  getUserInfo() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var uid = FirebaseAuth.instance.currentUser!.uid.toString();
      DocumentSnapshot userValue =
          await FirebaseFirestore.instance.collection(kUsers).doc(uid).get();
      user.firstName=userValue.get(kFirstName)??'';
      user.lastName=userValue.get(kLastName)??'';
      user.email=userValue.get(kUserEmail)??'';
      user.profilePicture=userValue.get(kProfilePicture)??'';
      user.userName=userValue.get(kUserName)??'';
      user.favouriteHalls=userValue.get(kFavouriteHalls)??[];
      user.phoneNumber=userValue.get(kUserPhoneNumber)??'';
      user.userId=userValue.get(kUserId)??'';
      allUser.add(user);
      user=allUser.first;
      notifyListeners();
    }
  }
}
