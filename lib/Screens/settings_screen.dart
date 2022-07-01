import 'package:book_a_hall/Models/user_model.dart';
import 'package:book_a_hall/authentication/login_screen.dart';
import 'package:book_a_hall/provider/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/consonants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  UserModel userModel = UserModel();
  String? userName = '';
  String? userEmail = '';
  String? userPhoneNumber = '';
  String? userId = '';
  String? userProfilePhoto = '';
  String? userLastName = '';
  String? userFirstName = '';
  String? newUserName;
  String? newUserEmail;
  String? newUserPhoneNumber;
  bool loader = false;
  var key = GlobalKey<FormState>();
  TextEditingController currentPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController repNewPassController = TextEditingController();
  UserProvider? userProvider;
  Future? future;
  @override
  void initState() {
    future=Provider.of<UserProvider>(context,listen: false).getUserInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     userProvider = Provider.of(context, listen: false);
    // userProvider.getUserInfo();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
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
      backgroundColor: Colors.grey.shade200,
      body: FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            userName = userProvider!.user.userName ?? '';
            userEmail = userProvider!.user.email ?? '';
            userPhoneNumber = userProvider!.user.phoneNumber ?? '';
            userId = userProvider!.user.userId ?? '';
            userProfilePhoto = userProvider!.user.profilePicture ?? '';
            userFirstName = userProvider!.user.firstName ?? '';
            userLastName = userProvider!.user.lastName ?? '';
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                child: Form(
                  key: key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 7.0, horizontal: 30),
                              child: Text(
                                'ACCOUNT',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 7.0, horizontal: 30),
                                child: Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  color: greenColor,
                                  size: 25,
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          'Name',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: SizedBox(
                          height: 40,
                          child: TextFormField(
                            initialValue: userName,
                            onChanged: (value) {
                              setState(() {
                                newUserName = value;
                                if (kDebugMode) {
                                  print(userName);
                                }
                              });
                            },
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 1)),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                              ),
                              border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          'Phone Number',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: SizedBox(
                          height: 60,
                          child: TextFormField(
                            initialValue: userPhoneNumber,
                            validator: (val) {
                              if (val!.length != 11 ||
                                  !val.contains(RegExp('0'), 0) ||
                                  !val.contains(RegExp('3'), 1)) {
                                return 'Please provide valid phone number';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                newUserPhoneNumber = value;
                                if (kDebugMode) {
                                  print(newUserPhoneNumber);
                                }
                              });
                            },
                            keyboardType: TextInputType.number,
                            maxLength: 11,
                            decoration: const InputDecoration(
                              hintText: '03xx-xxxxxxx',
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 1)),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                              ),
                              border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          'Email',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: SizedBox(
                          height: 40,
                          child: TextFormField(
                            enabled: userEmail!.isEmpty ? true : false,
                            initialValue: userEmail,
                            validator: (val) {
                              if (!val!.contains('@') && !val.contains('.')) {
                                return 'Please enter valid email';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                newUserEmail = value;
                              });
                            },
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 1)),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                              ),
                              border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () async {
                            if (key.currentState!.validate() == false) {
                              return;
                            } else {
                              userModel.phoneNumber =
                                  newUserPhoneNumber ?? userPhoneNumber;
                              userModel.userName = newUserName ?? userName;
                              userModel.email = newUserEmail ?? userEmail;
                              userModel.userId = userId;
                              userModel.firstName = userFirstName;
                              userModel.lastName = userLastName;
                              userModel.profilePicture = userProfilePhoto;
                              try {
                                setState(() {
                                  loader = true;
                                });
                                await FirebaseFirestore.instance
                                    .collection(kUsers)
                                    .doc(FirebaseAuth.instance.currentUser!.uid
                                        .toString())
                                    .set(userModel.asMap());
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        backgroundColor: greenColor,
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        duration: const Duration(seconds: 2),
                                        content: const Text(
                                          'DATE UPDATED!!',
                                          style: TextStyle(color: Colors.white),
                                        )));
                                userProvider!.getUserInfo();
                                setState(() {
                                  loader = false;
                                });
                              } catch (e) {
                                setState(() {
                                  loader = false;
                                });
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        backgroundColor: greenColor,
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        duration: const Duration(seconds: 2),
                                        content: const Text(
                                          'ERROR IN UPDATING DATA!!',
                                          style: TextStyle(color: Colors.white),
                                        )));
                              }
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 150,
                            decoration: BoxDecoration(
                                color: purpleColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: loader == false
                                  ? const Text(
                                      'UPDATE',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    )
                                  : const CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 7.0, horizontal: 30),
                              child: Text(
                                'CHANGE PASSWORD',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 7.0, horizontal: 30),
                                child: Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  color: greenColor,
                                  size: 25,
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          'Current Password',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: SizedBox(
                          height: 40,
                          child: TextFormField(
                            controller: currentPassController,
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 1)),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                              ),
                              border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          'New Password',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: SizedBox(
                          height: 40,
                          child: TextFormField(
                            controller: newPassController,
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 1)),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                              ),
                              border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          'Repeat New Password',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: SizedBox(
                          height: 40,
                          child: TextFormField(
                            controller: repNewPassController,
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 1)),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                              ),
                              border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            _changePassword(
                                newPassController.text.trim(), userEmail!);
                          },
                          child: Container(
                            height: 40,
                            width: 150,
                            decoration: BoxDecoration(
                                color: purpleColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: const Center(
                              child: Text(
                                'UPDATE',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            showAlertDialog(context);
                          },
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: purpleColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                'SIGN OUT',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  void _changePassword(String password, String email) async {
    User user = FirebaseAuth.instance.currentUser!;

    //Create field for user to input old password

    //pass the password here
    String password = currentPassController.text;
    String newPassword = newPassController.text;

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      user.updatePassword(newPassword).then((_) {
        print("Successfully changed password");
      }).catchError((error) {
        print("Password can't be changed" + error.toString());
        //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
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
}
