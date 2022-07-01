import 'dart:io';
import 'package:book_a_hall/Widgets/custom_textfield.dart';
import 'package:book_a_hall/authentication/auth.dart';
import 'package:book_a_hall/constants/consonants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  File? profileImage;
  final Auth auth = Auth();
  bool loader = false;
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var repeatPasswordController = TextEditingController();
  var key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: greenColor,
        title: const Text(
          'GET REGISTER',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Center(
                  child: InkWell(
                    onTap: () async {
                      var picker = await ImagePicker().getImage(
                          source: ImageSource.gallery, imageQuality: 20);
                      if (profileImage != null) {
                        setState(() {
                          profileImage = File(picker!.path);
                          print(profileImage);
                        });
                      }
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: purpleColor, width: 5)),
                      child: Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: greenColor,
                          child: profileImage == null
                              ? const Center(
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 70,
                                  ),
                                )
                              : Center(
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.black,
                                    child: Image.file(
                                      profileImage!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'First Name',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                CustomTextField(
                  hintText: 'Type your first name',
                  prefixIcon: Icons.person,
                  textColor: Colors.grey,
                  iconColor: Colors.grey,
                  controller: firstNameController,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Last Name',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                CustomTextField(
                  hintText: 'Type your last name',
                  prefixIcon: Icons.person,
                  textColor: Colors.grey,
                  iconColor: Colors.grey,
                  controller: lastNameController,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Email',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                CustomTextField(
                  hintText: 'Type your email',
                  prefixIcon: Icons.person,
                  textColor: Colors.grey,
                  iconColor: Colors.grey,
                  validator: (val) {
                    if (val!.contains('@') == false ||
                        val.contains('.') == false) {
                      return 'Enter valid email';
                    }
                    return null;
                  },
                  controller: emailController,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Password',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                CustomTextField(
                  hintText: 'Type your password',
                  prefixIcon: Icons.lock,
                  textColor: Colors.grey,
                  iconColor: Colors.grey,
                  obscureText: true,
                  controller: passwordController,
                  validator: (val) {
                    if (val!.length < 6) {
                      return 'Password is too short';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Confirm Password',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                CustomTextField(
                  hintText: 'Type your password again',
                  prefixIcon: Icons.lock,
                  textColor: Colors.grey,
                  iconColor: Colors.grey,
                  obscureText: true,
                  validator: (val) {
                    if (val != passwordController.text) {
                      return 'Password must match';
                    }
                    return null;
                  },
                  controller: repeatPasswordController,
                ),
                const SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () async {
                    if (key.currentState!.validate() == false) {
                      return;
                    } else {
                      try {
                        setState(() {
                          loader = true;
                        });
                        await auth.registerWithEmail(
                          context: context,
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                          name: firstNameController.text +
                              '' +
                              lastNameController.text,
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          profileImage: profileImage,
                        );
                        setState(() {
                          loader = false;
                        });
                      } on FirebaseAuthException catch (e) {
                        setState(() {
                          loader = false;
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
                    }
                  },
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: purpleColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: loader == false
                          ? const Text(
                              'Register',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500),
                            )
                          : const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
