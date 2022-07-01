import 'package:book_a_hall/Widgets/notification_item.dart';
import 'package:book_a_hall/provider/hall_book_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/consonants.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  HallBookProvider? hallBookProvider;
  Future? future;
  @override
  void initState() {
    var userId = FirebaseAuth.instance.currentUser!.uid.toString();
    future=Provider.of<HallBookProvider>(context,listen: false).getUserNotification(userId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     hallBookProvider = Provider.of(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('NOTIFICATIONS'),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 15),
        child: FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              return hallBookProvider!.userNotifications.isNotEmpty
                  ? ListView.separated(
                      itemBuilder: (context, index) {
                        return NotificationItem(
                            hallName: hallBookProvider!
                                .userNotifications[index].hallName!,
                            orderStatus: hallBookProvider!
                                .userNotifications[index].orderStatus!);
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemCount: hallBookProvider!.userNotifications.length)
                  : Center(
                      child: Image.asset('assets/images/no-order.png'),
                    );
            }),
      ),
    );
  }
}
