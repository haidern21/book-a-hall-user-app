import 'package:flutter/material.dart';

import '../constants/consonants.dart';

class NotificationItem extends StatelessWidget {
  final String hallName;
  final String orderStatus;

  const NotificationItem(
      {Key? key, required this.hallName, required this.orderStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black, width: 1),borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: const CircleAvatar(
          radius: 30,
          backgroundColor: purpleColor,
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Your Booking for $hallName has been $orderStatus. You can further contact with support for further details.',
            style: const TextStyle(color: Colors.black, fontSize: 14),
          ),
        ),
      ),
    );
  }
}
