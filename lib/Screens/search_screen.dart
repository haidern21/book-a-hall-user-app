import 'package:book_a_hall/Models/hall_model.dart';
import 'package:book_a_hall/Widgets/hall_details_screen.dart';
import 'package:book_a_hall/Widgets/hall_item.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final List<HallModel> allHalls;

  const SearchScreen({Key? key, required this.allHalls}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<HallModel> filterAds = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextFormField(
                  onChanged: (value) {
                    List<HallModel> tempFilterHalls = [];
                    for (var element in widget.allHalls) {
                      element.hallName!.toLowerCase().contains(value)
                          ? tempFilterHalls.add(element)
                          : null;
                      print(filterAds.length);
                      setState(() {
                        filterAds = tempFilterHalls;
                      });
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'SEARCH',
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
                      suffixIcon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      )),
                ),
              ),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return filterAds.isEmpty
                          ? InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HallDetailsScreen(
                                            hallModel:
                                                widget.allHalls[index])));
                              },
                              child: HallItem(
                                hallImage: widget.allHalls[index].hallImages!.first,
                                hallName: widget.allHalls[index].hallName,
                                hallAddress: widget.allHalls[index].hallAddress,
                                maxCapacity: widget.allHalls[index].maxCapacity,
                                ratePerPerson:
                                    widget.allHalls[index].ratePerPerson,
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HallDetailsScreen(
                                            hallModel: filterAds[index])));
                              },
                              child: HallItem(
                                hallImage: filterAds[index].hallImages!.first,
                                hallName: filterAds[index].hallName,
                                hallAddress: filterAds[index].hallAddress,
                                maxCapacity: filterAds[index].maxCapacity,
                                ratePerPerson: filterAds[index].ratePerPerson,
                              ),
                            );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                    itemCount: filterAds.isEmpty
                        ? widget.allHalls.length
                        : filterAds.length),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
