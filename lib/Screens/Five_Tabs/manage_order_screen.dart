import 'package:book_a_hall/Screens/order/cancelled_order_screen.dart';
import 'package:book_a_hall/Screens/order/in_process_order_screen.dart';
import 'package:book_a_hall/Screens/order/order_history_screen.dart';
import 'package:flutter/material.dart';

import '../../constants/consonants.dart';

class ManageOrderScreen extends StatefulWidget {
  const ManageOrderScreen({Key? key}) : super(key: key);

  @override
  State<ManageOrderScreen> createState() => _ManageOrderScreenState();
}

class _ManageOrderScreenState extends State<ManageOrderScreen>
    with SingleTickerProviderStateMixin {
  TabController? controller;

  @override
  void initState() {
    controller = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ORDERS'),
        bottom: TabBar(
          indicator: const BoxDecoration(
              border: Border(bottom: BorderSide(color: purpleColor, width: 3))),
          controller: controller,
          onTap: (index) {
            // Tab index when user select it, it start from zero
          },
          tabs: const [
            Tab(
              text: 'In Process',
            ),
            Tab(
              text: 'Order History',
            ),
            Tab(
              text: 'Cancelled',
            ),
          ],
        ),
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
      body: TabBarView(
        controller: controller,
        children: const [
          InProcessOrderScreen(),
          OrderHistoryScreen(),
          CancelledOrderScreen(),
        ],
      ),
    );
  }
}
