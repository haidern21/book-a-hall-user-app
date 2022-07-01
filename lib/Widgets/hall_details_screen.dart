import 'package:book_a_hall/Models/hall_model.dart';
import 'package:book_a_hall/Widgets/pageview_with_indicator.dart';
import 'package:book_a_hall/constants/consonants.dart';
import 'package:book_a_hall/Screens/conversation_screen.dart';
import 'package:book_a_hall/Screens/hall_booking_form.dart';
import 'package:book_a_hall/provider/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HallDetailsScreen extends StatefulWidget {
  final HallModel hallModel;

  const HallDetailsScreen({Key? key, required this.hallModel})
      : super(key: key);

  @override
  _HallDetailsScreenState createState() => _HallDetailsScreenState();
}

class _HallDetailsScreenState extends State<HallDetailsScreen> {
  bool isFavorite = false;

  @override
  void initState() {
    _checkIfFavorite().then((value) {
      isFavorite = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height * .35,
                      width: double.infinity,
                      child: widget.hallModel.hallImages == null
                          ? const Icon(Icons.image)
                          : PageViewWithIndicator(
                              onViewClicked: _onTabClicked,
                              imagesUrlList: widget.hallModel.hallImages!,
                            )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 40),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Icon(
                              Icons.arrow_back,
                              color: greenColor,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _favoritePressed();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 40),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Icon(
                              isFavorite != true
                                  ? Icons.favorite_border
                                  : Icons.favorite,
                              color: greenColor,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 3,
              ),
              Container(
                height: 60,
                width: double.infinity,
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
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    widget.hallModel.hallName ?? '',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: Text(
                  widget.hallModel.hallAddress ?? '',
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            right: BorderSide(color: greenColor, width: 2))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 30),
                      child: Text(
                        'Rs. ${widget.hallModel.ratePerPerson ?? ''}/person',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      'Max Capacity: ${widget.hallModel.maxCapacity} persons',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 40,
                width: double.infinity,
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
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                  child: Text(
                    'Features',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 20),
                          child: SizedBox(
                            height: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: 15),
                                        child: Icon(
                                          CupertinoIcons.circle_fill,
                                          color: greenColor,
                                          size: 5,
                                        ),
                                      ),
                                      height: 30,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      child: Text(
                                        widget.hallModel.hallFeatures![index],
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          50,
                                      height: 30,
                                    ),
                                  ],
                                ),
                                Container(
                                    height: 30,
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            50,
                                    decoration: const BoxDecoration(
                                        color: Colors.white),
                                    child: const Icon(
                                      CupertinoIcons.check_mark,
                                      color: purpleColor,
                                      size: 25,
                                    )),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 0,
                          ),
                      itemCount: widget.hallModel.hallFeatures!.length)),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ConversationScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              greenGradientColor5,
                              greenGradientColor1,
                              greenGradientColor4,
                              greenGradientColor6,
                              greenGradientColor7,
                            ]),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.chat_bubble,
                            color: purpleColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Chat',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      await userProvider.getUserInfo();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HallBookingFarm(
                                    hallName: widget.hallModel.hallName!,
                                  )));
                    },
                    child: Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              greenGradientColor5,
                              greenGradientColor1,
                              greenGradientColor4,
                              greenGradientColor6,
                              greenGradientColor7,
                            ]),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.shopping_cart,
                            color: purpleColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Proceed',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _removeFromFavorite() async {
    if (FirebaseAuth.instance.currentUser == null) {}
    try {
      await FirebaseFirestore.instance
          .collection(kUsers)
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .update({
        kFavouriteHalls: FieldValue.arrayRemove([widget.hallModel.hallId])
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _checkIfFavorite() async {
    if (FirebaseAuth.instance.currentUser != null) {}
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(kUsers)
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .get();
      List<dynamic> favorites = documentSnapshot.get(kFavouriteHalls);
      if (favorites.contains(widget.hallModel.hallId)) {
        setState(() {
          isFavorite == true;
        });
        return true;
      }
      if (favorites.contains(widget.hallModel.hallId) == false) {
        setState(() {
          isFavorite == false;
        });
        return false;
      }
      return favorites.contains(widget.hallModel.hallId);
    } catch (e) {
      return false;
    }
  }

  Future<bool> _addToFavorite() async {
    if (FirebaseAuth.instance.currentUser == null) {}
    try {
      await FirebaseFirestore.instance
          .collection(kUsers)
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .update({
        kFavouriteHalls: FieldValue.arrayUnion([widget.hallModel.hallId])
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  void _favoritePressed() {
    if (isFavorite == true) {
      _removeFromFavorite().then((value) {
        setState(() {
          isFavorite = false;
        });
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: greenColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          duration: const Duration(seconds: 2),
          content: const Text(
            'REMOVED FROM FAVORITES',
            style: TextStyle(color: Colors.white),
          )));
    } else {
      _addToFavorite().then((value) {
        setState(() {
          isFavorite = true;
        });
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: greenColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          duration: const Duration(seconds: 2),
          content: const Text(
            'ADDED TO FAVORITES',
            style: TextStyle(color: Colors.white),
          )));
    }
  }

  void _onTabClicked(String clickedImageUrl) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: InteractiveViewer(
              panEnabled: true,
              minScale: 0.001,
              child: Image.network(clickedImageUrl),
              // child: PageViewWithIndicator(imagesUrlList: ad.ima,),
            ),
          );
        });
  }
}
