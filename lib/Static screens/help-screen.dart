import 'package:book_a_hall/Static%20screens/help-center.dart';
import 'package:book_a_hall/Static%20screens/privacy_and_security.dart';
import 'package:book_a_hall/Static%20screens/report_a_problem.dart';
import 'package:book_a_hall/Static%20screens/support_request.dart';
import 'package:flutter/material.dart';

import '../constants/consonants.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final List<String> helpTiles = [
    'REPORT A PROBLEM',
    'HELP CENTER',
    'SUPPORT REQUESTS',
    'PRIVACY & SECURITY HELP'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
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
      body: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ReportAProblem()));
            },
            child: ListTile(
              title: Text(
                helpTiles[0],
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                color: greenColor,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HelpCenterScreen()));
            },
            child: ListTile(
              title: Text(
                helpTiles[1],
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                color: greenColor,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SupportRequests()));
            },
            child: ListTile(
              title: Text(
                helpTiles[2],
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                color: greenColor,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PrivacyAndSecurity()));
            },
            child: ListTile(
              title: Text(
                helpTiles[3],
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                color: greenColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
