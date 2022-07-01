import 'package:book_a_hall/provider/hall_book_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Widgets/order_item.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  // HallBookProvider? hallBookProvider;
  Future? future;

  @override
  void initState() {
    var userId = FirebaseAuth.instance.currentUser!.uid.toString();
    Provider.of<HallBookProvider>(context, listen: false)
        .getOrderHistory(userId);
    future = Provider.of<HallBookProvider>(context, listen: false)
        .getOrderHistory(userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HallBookProvider hallBookProvider = Provider.of(context);
    // hallBookProvider.getOrderHistory(userId);
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body:
            hallBookProvider.orderHistory.isNotEmpty
                ?
            FutureBuilder(
          future: future,
          builder: (context, snap) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 8),
                    child: OrderItem(
                        orderId:
                            hallBookProvider.orderHistory[index].orderId ?? '',
                        orderDate:
                            hallBookProvider.orderHistory[index].orderDate ??
                                '',
                        orderStatus:
                            hallBookProvider.orderHistory[index].orderStatus ??
                                'processing',
                        hallName:
                            hallBookProvider.orderHistory[index].hallName ??
                                'hall-name'),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                itemCount: hallBookProvider.orderHistory.length);
          },
        )
        : Center(child: Image.asset('assets/images/no-order.png')),
        );
  }
}
