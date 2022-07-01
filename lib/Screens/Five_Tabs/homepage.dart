import 'package:book_a_hall/Screens/search_screen.dart';
import 'package:book_a_hall/Widgets/hall_details_screen.dart';
import 'package:book_a_hall/Widgets/hall_item.dart';
import 'package:book_a_hall/constants/consonants.dart';
import 'package:book_a_hall/provider/hall_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // HallProvider? hallProvider;
  Future? future;
  @override
  void initState() {
    Provider.of<HallProvider>(context,listen: false).getAllHalls();
    future=Provider.of<HallProvider>(context,listen: false).getAllHalls();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   HallProvider hallProvider = Provider.of(context);
   // hallProvider.getAllHalls();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: greenColor,
          elevation: 0,
          title: const Text('HomePage'),
          centerTitle: true,
        ),
        backgroundColor: Colors.grey.shade300,
        body: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchScreen(
                              allHalls: hallProvider.halls,
                            )));
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 8, left: 10),
                        child: Icon(
                          Icons.search,
                          size: 25,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                            top: 8.0,
                            bottom: 8,
                            left: 15,
                          ),
                          child: Text(
                            'Search',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          )),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: future,
                builder: (context, snapshot) {
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HallDetailsScreen(
                                    hallModel: hallProvider.halls[index],
                                  )));
                        },
                        child: HallItem(
                          hallImage:
                          hallProvider.halls[index].hallImages!.first,
                          hallName: hallProvider.halls[index].hallName,
                          hallAddress: hallProvider.halls[index].hallAddress,
                          maxCapacity: hallProvider.halls[index].maxCapacity,
                          ratePerPerson:
                          hallProvider.halls[index].ratePerPerson,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                    itemCount: hallProvider.halls.length,
                  );
                },
              ),
              // child: FutureBuilder(
              //     // future: future,
              //     builder: (context, snapshot) {
              //       return ListView.separated(
              //         itemBuilder: (context, index) {
              //           // if (index == 0) {
              //           //   return InkWell(
              //           //     onTap: (){
              //           //       Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchScreen(allHalls: hallProvider.halls,)));
              //           //     },
              //           //     child: Padding(
              //           //       padding: const EdgeInsets.only(
              //           //           top: 8.0, left: 8, right: 8, bottom: 0),
              //           //       child: Container(
              //           //         height: 50,
              //           //         width: double.infinity,
              //           //         decoration: BoxDecoration(
              //           //             borderRadius: BorderRadius.circular(10),
              //           //             border: Border.all(color: Colors.black, width: 1)),
              //           //         child:  Padding(
              //           //           padding:const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
              //           //           child: Row(
              //           //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           //             children: const [
              //           //               Text(
              //           //                 'SEARCH',
              //           //                 style: TextStyle(color: Colors.black,fontSize: 16),
              //           //               ),
              //           //               Icon(Icons.search,color: Colors.black,size: 25,)
              //           //             ],
              //           //           ),
              //           //         ),
              //           //       ),
              //           //     ),
              //           //   );
              //           // }
              //           return InkWell(
              //             onTap: () {
              //               Navigator.push(
              //                   context,
              //                   MaterialPageRoute(
              //                       builder: (context) => HallDetailsScreen(
              //                             hallModel: hallProvider!.halls[index],
              //                           )));
              //             },
              //             child: HallItem(
              //               hallImage:
              //                   hallProvider!.halls[index].hallImages!.first,
              //               hallName: hallProvider!.halls[index].hallName,
              //               hallAddress: hallProvider!.halls[index].hallAddress,
              //               maxCapacity: hallProvider!.halls[index].maxCapacity,
              //               ratePerPerson:
              //                   hallProvider!.halls[index].ratePerPerson,
              //             ),
              //           );
              //         },
              //         separatorBuilder: (context, index) => const SizedBox(
              //           height: 10,
              //         ),
              //         itemCount: hallProvider!.halls.length,
              //       );
              //     }),
            )
          ],
        )
        // body: ListView.separated(
        //     itemBuilder: (context,index){
        //       return InkWell(
        //         onTap: () {
        //           Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                   builder: (context) => HallDetailsScreen(
        //                     hallModel: hallProvider.halls[index],
        //                   )));
        //         },
        //         child: HallItem(
        //           // hallAddress: 'H 10 near graveyard on main Gt Road Islamabad',
        //           // hallName: 'Toopaz Marquee',
        //           // maxCapacity: '1200',
        //           // ratePerPerson: '2300',
        //           hallImage: hallProvider.halls[index].hallImages!.first,
        //           hallName: hallProvider.halls[index].hallName,
        //           hallAddress: hallProvider.halls[index].hallAddress,
        //           maxCapacity: hallProvider.halls[index].maxCapacity,
        //           ratePerPerson: hallProvider.halls[index].ratePerPerson,
        //         ),
        //       );
        //     },
        //     separatorBuilder: (context,index)=> const SizedBox(height: 0,),
        //     itemCount: hallProvider.halls.length),
        );
  }
}
