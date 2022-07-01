import 'package:flutter/material.dart';
import '../constants/consonants.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HELP CENTER'),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(
            height: 40,
          ),
          Center(
            child: Text(
              'USER GUIDE',
              style: TextStyle(
                  color: greenColor, fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry  standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
              style: TextStyle(color: Colors.black, fontSize: 13),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              'FAQ',
              style: TextStyle(
                  color: greenColor, fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              'Q: How to see the pictures of Hall?',
              style: TextStyle(color: Colors.black, fontSize: 13),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              'You can click on any hall and there will be a hall details screen, there you can find the pictures of hall.',
              style: TextStyle(color: Colors.black, fontSize: 13),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              'Q: Is Customer banking details are safe?',
              style: TextStyle(color: Colors.black, fontSize: 13),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              'Your financial details are safe.',
              style: TextStyle(color: Colors.black, fontSize: 13),
            ),
          ),
          SizedBox(height: 10,),
          Center(
            child: Text(
              'HOW TO BOOK A HALL',
              style: TextStyle(
                  color: greenColor, fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry  standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
              style: TextStyle(color: Colors.black, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
