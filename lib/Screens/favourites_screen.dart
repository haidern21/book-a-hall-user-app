import 'package:book_a_hall/Widgets/hall_details_screen.dart';
import 'package:book_a_hall/Widgets/hall_item.dart';
import 'package:book_a_hall/provider/hall_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/consonants.dart';

class FavouriteHallsScreen extends StatefulWidget {
  const FavouriteHallsScreen({Key? key}) : super(key: key);

  @override
  _FavouriteHallsScreenState createState() => _FavouriteHallsScreenState();
}

class _FavouriteHallsScreenState extends State<FavouriteHallsScreen> {
  HallProvider? hallProvider;
  Future? future;
  @override
  void initState() {
    future=Provider.of<HallProvider>(context,listen: false).getFavoriteHalls();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     hallProvider = Provider.of(context,listen: false);
    return Scaffold(
        appBar: AppBar(
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
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
          ),
          title: const Text('Favourites'),
        ),
        body: FutureBuilder(
            future: future,
            builder: (context, index) {
              return hallProvider!.favouriteHalls.isEmpty
                  ? Center(
                      child: Image.asset("assets/images/no_fav.png"),
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HallDetailsScreen(
                                        hallModel: hallProvider!
                                            .favouriteHalls[index])));
                          },
                          child: HallItem(
                            hallImage: hallProvider!
                                .favouriteHalls[index].hallImages!.first,
                            hallName:
                                hallProvider!.favouriteHalls[index].hallName,
                            hallAddress:
                                hallProvider!.favouriteHalls[index].hallAddress,
                            maxCapacity:
                                hallProvider!.favouriteHalls[index].maxCapacity,
                            ratePerPerson: hallProvider!
                                .favouriteHalls[index].ratePerPerson,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemCount: hallProvider!.favouriteHalls.length);
            }));
  }
}
