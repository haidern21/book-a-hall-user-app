import 'package:book_a_hall/constants/consonants.dart';
import 'package:flutter/material.dart';

class ChatBubbleWidget extends StatefulWidget {
  final String? text;
  final String? dateTime;
  final bool? isYourMessage;

  const ChatBubbleWidget({
    Key? key,
    this.text,
    this.dateTime,
    this.isYourMessage,
  }) : super(key: key);

  @override
  State<ChatBubbleWidget> createState() => _ChatBubbleWidgetState();
}

class _ChatBubbleWidgetState extends State<ChatBubbleWidget> {
  bool showFullDate = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: (widget.isYourMessage!)
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                // color: (isYourMessage!) ? purpleColor : Colors.green,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: (widget.isYourMessage!)
                      ? [
                          purpleGradientColor1,
                          purpleGradientColor1,
                          purpleGradientColor1,
                          purpleGradientColor1,
                        ]
                      : [
                          greenGradientColor5,
                          greenGradientColor1,
                          greenGradientColor4,
                          greenGradientColor6,
                          greenGradientColor7,
                        ],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              padding: const EdgeInsets.all(15),
              child: Text(
                widget.text!,
                style: TextStyle(
                    color: (widget.isYourMessage!)
                        ? Colors.white
                        : Colors.black),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            InkWell(
                onTap: () {
                  setState(() {
                    showFullDate = !showFullDate;
                  });
                },
                child: Text(showFullDate == false
                    ? widget.dateTime.toString().substring(11, 16)
                    : widget.dateTime.toString().substring(0, 16)))
          ],
        ));
  }
}
