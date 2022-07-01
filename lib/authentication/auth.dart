import 'dart:io';

import 'package:book_a_hall/Models/user_model.dart';
import 'package:book_a_hall/constants/consonants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:twitter_login/twitter_login.dart';

import '../Screens/landing_screen.dart';

class Auth {
  final UserModel userModel = UserModel();
  String? downLoadLink;

  Future signInWithGoogle(BuildContext context) async {
    GoogleSignInAccount? googleSignIn;
    try {
      googleSignIn = await GoogleSignIn().signIn();
      GoogleSignInAuthentication googleSignInAuthentication;
      googleSignInAuthentication = await googleSignIn!.authentication;
      OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (FirebaseAuth.instance.currentUser != null) {
        var uid = FirebaseAuth.instance.currentUser!.uid.toString();
        userModel.userId = uid;
        userModel.userName = userCredential.user!.displayName.toString();
        userModel.profilePicture = userCredential.user!.photoURL;
        userModel.firstName = '';
        userModel.lastName = '';
        userModel.email = userCredential.user!.email;
        bool docExist = await checkIfDocExists(uid);
        if (docExist == false) {
          await FirebaseFirestore.instance
              .collection(kUsers)
              .doc(uid)
              .set(userModel.asMap());
        }
      }
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const LandingPage()),
              (route) => false);
      if (kDebugMode) {
        print('Running TRY block of Google sign in ');
        print('USER CREDENTIALS FROM GOOGLE SIGN IN :$userCredential');
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: greenColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          duration: const Duration(seconds: 2),
          content:  Text(
            e.message??'',
            style: const TextStyle(color: Colors.white),
          )));
      if (kDebugMode) {
        print('Running catch block of Google sign in ');
        print('Problem occurred in google sign in function from Auth class');
        print('The problem is: ${e.message}');
      }
    }
  }

  Future signInWithFacebook(BuildContext context) async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      final OAuthCredential facebookCredential =
          FacebookAuthProvider.credential(result.accessToken!.token);
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(facebookCredential);
      if (FirebaseAuth.instance.currentUser != null) {
        var uid = FirebaseAuth.instance.currentUser!.uid.toString();
        userModel.userId = uid;
        userModel.firstName = '';
        userModel.lastName = '';
        userModel.userName = userCredential.user!.displayName.toString();
        userModel.profilePicture = userCredential.user!.photoURL;
        userModel.email = userCredential.user!.email;
        bool docExist = await checkIfDocExists(uid);
        if (docExist == false) {
          await FirebaseFirestore.instance
              .collection(kUsers)
              .doc(uid)
              .set(userModel.asMap());
        }
      }
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const LandingPage()),
              (route) => false);
      if (kDebugMode) {
        print('Running TRY block of Facebook sign in ');
        print('USER CREDENTIALS FROM FACEBOOK SIGN IN :$userCredential');
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: greenColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          duration: const Duration(seconds: 2),
          content:  Text(
            e.message??'',
            style: const TextStyle(color: Colors.white),
          )));
      if (kDebugMode) {
        print('Running catch block of Facebook sign in ');
        print('Problem occurred in Facebook sign in function from Auth class');
        print('The problem is: ${e.message}');
      }
    }
  }

  Future signInWithTwitter() async {
    try {
      final twitterLogin = TwitterLogin(
          apiKey: '<your consumer key>',
          apiSecretKey: ' <your consumer secret>',
          redirectURI: '<your_scheme>://');
      final authResult = await twitterLogin.login();
      final twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: authResult.authToken!,
        secret: authResult.authTokenSecret!,
      );
      await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
      if (kDebugMode) {
        print('Running TRY block of Twitter sign in ');
        print('USER CREDENTIALS FROM Twitter SIGN IN :$twitterAuthCredential');
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('Running catch block of Twitter sign in ');
        print('Problem occurred in Twitter sign in function from Auth class');
        print('The problem is: ${e.message}');
      }
    }
  }

  Future loginWithEmail(String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
              const LandingPage()),
              (route) => false);
      if (kDebugMode) {
        print('Running TRY block of EMAIL sign in ');
      }
      if (FirebaseAuth.instance.currentUser != null) {
        var uid = FirebaseAuth.instance.currentUser!.uid.toString();
        if (kDebugMode) {
          print(uid);
        }
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: greenColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          duration: const Duration(seconds: 2),
          content:  Text(
            e.message??'',
            style: const TextStyle(color: Colors.white),
          )));
      if (kDebugMode) {
        print('Running catch block of EMAIL sign in ');
        print('Error in EMAIL sign in:${e.message} ');
      }
    }
  }

  Future registerWithEmail({
    required String email,
    required String password,
    String? name,
    String? firstName,
    String? lastName,
    File? profileImage,
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const LandingPage()),
              (route) => false);
      if (kDebugMode) {
        print('Running TRY block of EMAIL sign in ');
      }
      if (FirebaseAuth.instance.currentUser != null) {
        uploadProfileImage(profileImage);
        var uid = FirebaseAuth.instance.currentUser!.uid.toString();
        bool docExist = await checkIfDocExists(uid);
        userModel.userId = uid;
        userModel.firstName = firstName;
        userModel.lastName = lastName;
        userModel.userName = name;
        userModel.profilePicture = downLoadLink;
        userModel.email = email;
        if (docExist == false) {
          await FirebaseFirestore.instance
              .collection(kUsers)
              .doc(uid)
              .set(userModel.asMap());
        }
      }

      if (kDebugMode) {
        print(FirebaseAuth.instance.currentUser!.uid.toString());
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: greenColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          duration: const Duration(seconds: 2),
          content:  Text(
            e.message??'',
            style: const TextStyle(color: Colors.white),
          )));
      if (kDebugMode) {
        print('Running catch block of EMAIL sign in ');
        print('Error in EMAIL sign in:${e.message} ');
      }
    }
  }

  Future uploadProfileImage(File? image) async {
    try {
      if (image == null) {}
      if (image != null) {
        var reference1 = FirebaseStorage.instance.ref(
            'Images/profile-pictures/${FirebaseAuth.instance.currentUser!.uid.toString()}/$image');
        await reference1.putFile(image);
        String download1 = await reference1.getDownloadURL();
        downLoadLink = download1;
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

  Future logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      if (kDebugMode) {
        print('RUNNING TRY BLOCK OF LOGOUT');
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('RUNNING CATCH BLOCK OF LOGOUT ${e.message}');
      }
    }
  }

  /// Check If Document Exists
  Future<bool> checkIfDocExists(String docId) async {
    try {
      // Get reference to Firestore collection
      var collectionRef = FirebaseFirestore.instance.collection(kUsers);

      var doc = await collectionRef.doc(docId).get();
      return doc.exists;
    } catch (e) {
      rethrow;
    }
  }
}
