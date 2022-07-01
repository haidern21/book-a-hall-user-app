import 'package:book_a_hall/Models/hall_book_model.dart';
import 'package:book_a_hall/Screens/landing_screen.dart';
import 'package:book_a_hall/provider/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../Widgets/custom_textfield.dart';
import '../constants/consonants.dart';

class HallBookingFarm extends StatefulWidget {
  final String hallName;

  const HallBookingFarm({Key? key, required this.hallName}) : super(key: key);

  @override
  _HallBookingFarmState createState() => _HallBookingFarmState();
}

class _HallBookingFarmState extends State<HallBookingFarm> {
  String eventType = '';
  int value = 0;

  Widget CustomRadioButton(String text, int index, String getText) {
    return OutlineButton(
      onPressed: () {
        setState(() {
          value = index;
          getText = text;
          eventType = getText;
          print(getText);
        });
      },
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          fontWeight: (value == index) ? FontWeight.bold : FontWeight.normal,
          color: (value == index) ? greenColor : Colors.black,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      borderSide: BorderSide(
          color: (value == index) ? greenColor : Colors.black, width: 2),
    );
  }

  String? date;
  HallBookModel hallBookModel = HallBookModel();
  String? newPhoneNumber;
  String? newName;
  String? newUserEmail;
  bool loader = false;
  var key= GlobalKey<FormState>();
  UserProvider? userProvider;
  Future? future;
  @override
  void initState() {
    future=Provider.of<UserProvider>(context,listen: false).getUserInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     userProvider = Provider.of(context,listen: false);
    // userProvider.getUserInfo();
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(widget.hallName),
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
      body: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          String? userName = userProvider!.user.userName;
          String userEmail = userProvider!.user.email ?? '';
          String userPhoneNumber = userProvider!.user.phoneNumber ?? '';
          String profilePicture = userProvider!.user.profilePicture ?? '';
          String userId = userProvider!.user.userId ?? '';
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
              child: SingleChildScrollView(
                child: Form(
                  key: key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Row(
                        children: const [
                          Text(
                            'Name',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '*',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      CustomTextField(
                        hintText: 'Type your name',
                        initialValue: userName,
                        prefixIcon: Icons.person,
                        textColor: Colors.grey,
                        iconColor: Colors.grey,
                        validator: (val){
                          if(val!.length<3){
                            return 'Invalid Name';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            newName = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          Text(
                            'Email',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      CustomTextField(
                        initialValue: userEmail,
                        enabled: userEmail.isEmpty ? true : false,
                        hintText: 'Type your email',
                        prefixIcon: Icons.mail,
                        textColor: Colors.grey,
                        iconColor: Colors.grey,
                        validator: (val){
                          if(!val!.contains('@')&&!val.contains('.')){
                            return 'Invalid Email';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            newUserEmail = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          Text(
                            'Phone Number',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '*',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      CustomTextField(
                        initialValue: userPhoneNumber,
                        enabled: userPhoneNumber.isEmpty ? true : false,
                        hintText: '03xx-xxxxxxx',
                        maxLength: 11,
                        keyboardType: TextInputType.number,
                        prefixIcon: Icons.phone,
                        textColor: Colors.grey,
                        iconColor: Colors.grey,
                        validator: (val){
                          if (val!.length != 11 ||
                              !val.contains(RegExp('0'), 0) ||
                              !val.contains(RegExp('3'), 1)) {
                            return 'Please provide valid phone number';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            newPhoneNumber = value;
                            print(newPhoneNumber);
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          Text(
                            'Event date',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '*',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2030))
                              .then((value) {
                            if (value != null) {
                              setState(() {
                                date = value.toString();
                                date = date!.substring(0, 10);
                              });
                            }
                          });
                        },
                        child: CustomTextField(
                          enabled: false,
                          hintText: date ?? 'DD/MM/YYYY',
                          prefixIcon: Icons.person,
                          textColor: Colors.black,
                          iconColor: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          Text(
                            'Event type',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomRadioButton('Wedding ', 1, eventType),
                            const SizedBox(
                              width: 10,
                            ),
                            CustomRadioButton('Concert ', 2, eventType),
                            const SizedBox(
                              width: 10,
                            ),
                            CustomRadioButton('Meeting ', 3, eventType),
                            const SizedBox(
                              width: 10,
                            ),
                            CustomRadioButton('Other ', 4, eventType),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 120,
                      ),
                      InkWell(
                        onTap: () async {
                          try {
                            if(key.currentState!.validate()==false){
                              return ;
                            }
                            else {
                              if(date!.isEmpty){
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    backgroundColor: greenColor,
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    duration: const Duration(seconds: 2),
                                    content: const Text(
                                      'Fill all required fields',
                                      style: TextStyle(color: Colors.white),
                                    )));
                                return ;
                              }
                              setState(() {
                                loader = true;
                                print('loader:$loader');
                              });
                              hallBookModel.userEmail = newUserEmail ?? userEmail;
                              hallBookModel.eventType = eventType;
                              hallBookModel.eventDate = date?.substring(0, 10) ??
                                  '';
                              hallBookModel.userId = userId;
                              hallBookModel.userProfilePicture = profilePicture;
                              hallBookModel.userPhoneNumber =
                                  newPhoneNumber ?? userPhoneNumber;
                              hallBookModel.userName = newName ?? userName;
                              hallBookModel.hallName = widget.hallName;
                              hallBookModel.orderDate =
                                  DateTime.now().toString().substring(0, 10);
                              hallBookModel.orderId = const Uuid().v1();
                              await FirebaseFirestore.instance
                                  .collection(kOrders)
                                  .doc(hallBookModel.orderId)
                                  .set(hallBookModel.asMap());
                              await showSnackBar();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LandingPage()),
                                      (route) => false);
                              print(hallBookModel.asMap());
                            }
                          } catch (e) {
                            setState(() {
                              print('catch:$loader');
                              loader = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: greenColor,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                duration: const Duration(seconds: 2),
                                content: const Text(
                                  'Fill all required fields',
                                  style: TextStyle(color: Colors.white),
                                )));
                          }
                        },
                        child: Container(
                          height: 50,
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
                          child: Center(
                            child: loader == false
                                ? const Text(
                              'Place Order',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
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
        }),
    );
  }

  showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: greenColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        duration: const Duration(seconds: 2),
        content: const Text(
          'ORDER PLACED!!',
          style: TextStyle(color: Colors.white),
        )));
  }
}
