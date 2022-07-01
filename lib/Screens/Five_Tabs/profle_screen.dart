import 'dart:io';

import 'package:book_a_hall/authentication/login_screen.dart';
import 'package:book_a_hall/constants/consonants.dart';
import 'package:book_a_hall/Screens/favourites_screen.dart';
import 'package:book_a_hall/Static%20screens/help-screen.dart';
import 'package:book_a_hall/Screens/landing_screen.dart';
import 'package:book_a_hall/provider/user_provider.dart';
import 'package:book_a_hall/Screens/settings_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? image1;
  String downLoadLink = '';

  // UserProvider? userProvider;
  Future? future;

  @override
  void initState() {
    future = Provider.of<UserProvider>(context, listen: false).getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of(context, );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            FutureBuilder(
                future: future,
                builder: (context, snapshot) {
                  return Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * .25,
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
                      ),
                      Positioned(
                        top: 70,
                        left: 20,
                        child: InkWell(
                          onTap: () async {
                            var picker = await ImagePicker().getImage(
                                source: ImageSource.gallery, imageQuality: 10);
                            setState(() {
                              image1 = File(picker!.path);
                            });
                            if (image1 != null) {
                              try {
                                await uploadProfileImage();
                                await userProvider.getUserInfo();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('PROFILE PICTURE UPDATED!!')));
                              } on FirebaseException catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'ERROR IN UPDATING PROFILE PICTURE!!')));
                              }
                            }
                          },
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: const BoxDecoration(
                                color: Colors.black, shape: BoxShape.circle),
                            child: userProvider.user.profilePicture == null ||
                                    userProvider.user.profilePicture == ''
                                ? const Icon(
                                    Icons.person,
                                    size: 50,
                                    color: Colors.white,
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          userProvider.user.profilePicture!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 165,
                          left: 25,
                          child: Text(
                            userProvider.user.userName ?? 'username',
                            // 'Haider Naeem',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          )),
                    ],
                  );
                }),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LandingPage()),
                    (route) => false);
              },
              child: const ListTile(
                leading: Icon(
                  Icons.home,
                  color: greenColor,
                ),
                title: Text('Home'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FavouriteHallsScreen()));
              },
              child: const ListTile(
                leading: Icon(
                  Icons.favorite,
                  color: greenColor,
                ),
                title: Text('Favourites'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsScreen()));
              },
              child: const ListTile(
                leading: Icon(
                  Icons.settings,
                  color: greenColor,
                ),
                title: Text('Settings'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HelpScreen()));
              },
              child: const ListTile(
                leading: Icon(
                  Icons.help,
                  color: greenColor,
                ),
                title: Text('Help'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () async {
                showAlertDialog(context);
              },
              child: const ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  color: greenColor,
                ),
                title: Text('Exit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text(
        "OK",
        style: TextStyle(color: greenColor),
      ),
      onPressed: () {
        FirebaseAuth.instance.signOut();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false);
      },
    );
    Widget cancelButton = TextButton(
      child: const Text(
        "CANCEL",
        style: TextStyle(color: greenColor),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      content: const Text("Are you sure you want to Logout?"),
      actions: [
        cancelButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  uploadProfileImage() async {
    var currentUser = FirebaseAuth.instance.currentUser!.uid.toString();
    try {
      if (image1 == null) {}
      if (image1 != null) {
        var reference1 = FirebaseStorage.instance.ref(
            'Images/profile-pictures/${FirebaseAuth.instance.currentUser!.uid.toString()}/$image1');
        await reference1.putFile(image1!);
        String download1 = await reference1.getDownloadURL();
        setState(() {
          downLoadLink = download1;
        });
        await FirebaseFirestore.instance
            .collection(kUsers)
            .doc(currentUser)
            .update({
          kProfilePicture: downLoadLink,
        });
        if (kDebugMode) {
          print('Image1 DOWNLOAD URL:$download1');
        }
      }
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(
            'RUNNING CATCH BLOCK OF UPLOAD PROFILE IMAGE FROM VIEW AND EDIT SCREEN :${e.message}');
      }
    }
  }
}
