import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/consonants.dart';

class HallItem extends StatefulWidget {
  final String? hallName;
  final String? hallAddress;
  final String? ratePerPerson;
  final String? maxCapacity;
  final String? hallImage;

  const HallItem(
      {Key? key,
      this.hallImage,
      this.maxCapacity,
      this.ratePerPerson,
      this.hallAddress,
      this.hallName})
      : super(key: key);

  @override
  _HallItemState createState() => _HallItemState();
}

class _HallItemState extends State<HallItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .32,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            child: widget.hallImage == null
                ? const Center(
                    child: Icon(
                    Icons.photo_size_select_actual_outlined,
                    size: 50,
                    color: Colors.grey,
                  ))
                : CachedNetworkImage(
                    imageUrl: widget.hallImage!,
                    fit: BoxFit.cover,
                  ),
            height: MediaQuery.of(context).size.height * .20,
            width: double.infinity,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              widget.hallName!,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w900),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              widget.hallAddress!,
              softWrap: true,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          SizedBox(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          right: BorderSide(color: greenColor, width: 2))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 50),
                    child: Text(
                      'Rs ${widget.ratePerPerson!}/ person',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    'Max capacity: ${widget.ratePerPerson}persons',
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
