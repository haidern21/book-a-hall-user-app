import 'package:book_a_hall/Widgets/custom_textfield.dart';
import 'package:book_a_hall/authentication/auth.dart';
import 'package:book_a_hall/authentication/registeration_screen.dart';
import 'package:book_a_hall/constants/consonants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var key = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
  Auth auth = Auth();
  bool loader=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Form(
        key: key,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .13,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                          child: Text(
                        'BUYER',
                        style: TextStyle(
                            color: greenColor,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      )),
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        'Email',
                        style: TextStyle(
                            color: greenColor, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomTextField(
                        hintText: 'Type your email',
                        prefixIcon: Icons.person,
                        controller: email,
                        textColor: greenColor,
                        iconColor: greenColor,
                        validator: (val) {
                          if (val!.contains('@') == false ||
                              val.contains('.') == false) {
                            return 'Invalid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Password',
                        style: TextStyle(
                            color: greenColor, fontWeight: FontWeight.w500),
                      ),
                      CustomTextField(
                          hintText: 'Type your Password',
                          prefixIcon: Icons.lock,
                          obscureText: true,
                          controller: password,
                          textColor: greenColor,
                          iconColor: greenColor,
                          validator: (val) {
                            if (val!.length < 6) {
                              return 'Password is too short';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  const Text(
                    'Forget Password?',
                    style: TextStyle(
                        color: greenColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 20),
                    child: Center(
                      child: GestureDetector(
                        onTap: () async {
                          if (key.currentState!.validate() == false) {
                            return;
                          } else {
                            try {
                              setState(() {
                                loader=true;
                              });
                              await auth.loginWithEmail(
                                  email.text.trim(), password.text, context);
                              setState(() {
                                loader=false;
                              });
                            } on FirebaseAuthException catch (e) {
                              setState(() {
                                loader=false;
                              });
                              email.clear();
                              password.clear();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Invalid Credentials')));
                            }
                          }
                        },
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: purpleColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child:  Center(
                            child:  loader==false? const Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500),
                            ): const CircularProgressIndicator(color: Colors.white,),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Center(
                      child: Text(
                    'or Sign up Using',
                    style: TextStyle(
                        color: greenColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  )),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // InkWell(
                      //   onTap: () async {
                      //     await auth.signInWithTwitter();
                      //     Navigator.pushAndRemoveUntil(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => const LandingPage()),
                      //         (route) => false);
                      //   },
                      //   child: Container(
                      //     height: 50,
                      //     width: 50,
                      //     decoration: BoxDecoration(
                      //       border: Border.all(color: greenColor, width: 3),
                      //       borderRadius: BorderRadius.circular(30),
                      //     ),
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(3.0),
                      //       child: SvgPicture.asset(
                      //           'assets/images/twitter-icon.svg'),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () async {
                          try {
                            setState(() {
                              loader=true;
                            });
                            await auth.signInWithFacebook(context);
                            setState(() {
                              loader=false;
                            });
                          } on FirebaseAuthException catch (e) {
                            setState(() {
                              loader=false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: greenColor,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                duration: const Duration(seconds: 2),
                                content: Text(
                                  e.message ?? '',
                                  style: const TextStyle(color: Colors.white),
                                )));
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: greenColor, width: 3),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: SvgPicture.asset(
                                'assets/images/facebook-icon.svg'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () async {
                          try {
                            setState(() {
                              loader=true;
                            });
                            await auth.signInWithGoogle(context);
                            setState(() {
                              loader=false;
                            });
                          } on FirebaseAuthException catch (e) {
                            setState(() {
                              loader=false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: greenColor,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                duration: const Duration(seconds: 2),
                                content: Text(
                                  e.message ?? '',
                                  style: const TextStyle(color: Colors.white),
                                )));
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: greenColor, width: 3),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: SvgPicture.asset(
                                'assets/images/google-icon.svg'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Center(
                      child: Text(
                    'Doesn\'t have an account',
                    style: TextStyle(
                        color: greenColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const RegistrationScreen()));
                    },
                    child: const Center(
                        child: Text(
                      'SIGN UP',
                      style: TextStyle(
                          color: greenColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
