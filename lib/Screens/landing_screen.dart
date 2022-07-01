import 'package:book_a_hall/Screens/Five_Tabs/all_chats_screen.dart';
import 'package:book_a_hall/constants/consonants.dart';
import 'package:book_a_hall/Screens/Five_Tabs/homepage.dart';
import 'package:book_a_hall/Screens/Five_Tabs/manage_order_screen.dart';
import 'package:book_a_hall/Screens/Five_Tabs/notification_screen.dart';
import 'package:book_a_hall/Screens/Five_Tabs/profle_screen.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int pageIndex = 0;

  final pages = [
    const HomePage(),
    const AllChatsScreen(),
    const ManageOrderScreen(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: purpleColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        currentIndex: pageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wysiwyg),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none_sharp),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          )
        ],
      ),
    );
  }
}
