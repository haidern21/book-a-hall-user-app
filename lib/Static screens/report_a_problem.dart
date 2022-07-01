import 'package:flutter/material.dart';

import '../constants/consonants.dart';

class ReportAProblem extends StatelessWidget {
  const ReportAProblem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text('REPORT A PROBLEM'),
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
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*.10,),
            Center(
              child: TextFormField(
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: 'REPORT A PROBLEM',
                  hintStyle: const TextStyle(fontSize: 14),
                  suffixIcon: const Icon(
                    Icons.send,
                    color: Colors.blue,
                  ),
                  contentPadding:  const EdgeInsets.all(10),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 1,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 1,
                      )),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                color: purpleColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child:  Text(
                  'REPORT',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
