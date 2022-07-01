import 'package:book_a_hall/constants/consonants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../Models/hall_model.dart';

class HallProvider extends ChangeNotifier {
  List<HallModel> halls = [];
  List<HallModel> favouriteHalls = [];

  Future getAllHalls() async {
    print('get all haslls');
    List<HallModel> tempHalls = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection(kHalls).get();
    for (var element in value.docs) {
      HallModel hallModel = HallModel(
        hallName: element.get(kHallName),
        hallAddress: element.get(kHallAddress),
        maxCapacity: element.get(kMaxCapacity),
        ratePerPerson: element.get(kRatePerPerson),
        hallFeatures: element.get(kHallFeatures),
        hallId: element.get(kHallId),
        hallImages: element.get(kHallImages),
      );
      tempHalls.add(hallModel);
    }
    halls = tempHalls;
    notifyListeners();
  }

  getFavoriteHalls() async {
    print('fav halls');
    List<HallModel> tempAds = [];
    List<HallModel> tempFavAds = [];
    List<dynamic> userFavAds = [];
    QuerySnapshot ads =
        await FirebaseFirestore.instance.collection(kHalls).get();
    for (var element in ads.docs) {
      HallModel hallModel = HallModel(
        hallName: element.get(kHallName),
        hallAddress: element.get(kHallAddress),
        maxCapacity: element.get(kMaxCapacity),
        ratePerPerson: element.get(kRatePerPerson),
        hallFeatures: element.get(kHallFeatures),
        hallId: element.get(kHallId),
        hallImages: element.get(kHallImages),
      );
      tempAds.add(hallModel);
    }
    DocumentSnapshot userValue = await FirebaseFirestore.instance
        .collection(kUsers)
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .get();
    userFavAds = userValue.get(kFavouriteHalls);
    for (int i = 0; i < userFavAds.length; i++) {
      tempAds
          .where((element) => element.hallId == userFavAds[i])
          .forEach((element) {
        tempFavAds.add(element);
      });
    }
    favouriteHalls = tempFavAds;
    notifyListeners();
  }
}
