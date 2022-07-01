import 'package:book_a_hall/Widgets/order_item.dart';
import 'package:book_a_hall/provider/hall_book_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InProcessOrderScreen extends StatefulWidget {
  const InProcessOrderScreen({Key? key}) : super(key: key);

  @override
  _InProcessOrderScreeState createState() => _InProcessOrderScreeState();
}

class _InProcessOrderScreeState extends State<InProcessOrderScreen> {
  // HallBookProvider? hallBookProvider;
  Future? future;
  @override
  void initState() {
    var userId = FirebaseAuth.instance.currentUser!.uid.toString();
    Provider.of<HallBookProvider>(context,listen: false).getInProcessOrders(userId);
    future=Provider.of<HallBookProvider>(context,listen: false).getInProcessOrders(userId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    HallBookProvider hallBookProvider = Provider.of(context);
    // hallBookProvider.getInProcessOrders(userId);
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body:
            hallBookProvider.inProcessOrder.isNotEmpty
                ?
            FutureBuilder(
          future:future,
          builder: (context, snap) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 8),
                    child: OrderItem(
                      orderDate:
                          hallBookProvider.inProcessOrder[index].orderDate ??
                              '',
                      orderStatus:
                          hallBookProvider.inProcessOrder[index].orderStatus ??
                              'processing',
                      hallName:
                          hallBookProvider.inProcessOrder[index].hallName ??
                              'hall-name',
                      orderId:
                          hallBookProvider.inProcessOrder[index].orderId ?? '',
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                itemCount: hallBookProvider.inProcessOrder.length);
          },
        )
        : Center(
            child: Image.asset('assets/images/no-order.png'),
          ),
        );
  }
}
