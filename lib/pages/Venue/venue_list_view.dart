import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planner_app/business_logic.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../components.dart';
import '../Events/event.dart';

class VenueView extends ConsumerWidget {
  final int eventIndex;
   const VenueView({super.key,required this.eventIndex});
  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final provider = ref.watch(stateProvider);
    Box<Event> eventBox = Hive.box('event');
    return Scaffold(
      appBar: AppBar(
        title: const FrenchCannon(text:"Venues", color: Colors.white, weight: FontWeight.bold),
      ),
      body:
      Builder(builder: (context){
        Future snapshot= provider.getVenues();
        return Center();
        // return ListView.builder(
        //     itemCount: snapshot.da,
        //     itemBuilder: (context, index) {
        //       DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
        //       String venueId = documentSnapshot.id;
        //       return Padding(
        //         padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
        //         child: SizedBox(
        //           height: 200,
        //           child: ListTile(
        //             tileColor: lightDustyRose,
        //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        //             onTap: () {
        //               Navigator.of(context).pushNamed('/singlevenue', arguments: documentSnapshot);
        //             },
        //             leading: Image.network(documentSnapshot["image_url"], fit: BoxFit.fitHeight),
        //             title: Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 BulletoKilla(text: documentSnapshot["name"], color: Colors.black, size: 15.0),
        //                 const SizedBox(height: 10),
        //                 const Text("Location:", style: TextStyle(fontWeight: FontWeight.bold)),
        //                 Text(documentSnapshot["place"].toString()),
        //                 venueId==thisEvent!.eventVenue!.venueId?Text("Selected",style: TextStyle(color: muave,fontWeight: FontWeight.bold),):const Text(""),
        //               ],
        //             ),
        //             trailing: ElevatedButton(onPressed: (){
        //               if(thisEvent!=null && thisEvent.eventVenue!=null){
        //                 provider.assignVenue(eventIndex, venueId,documentSnapshot["price_per_plate"]);
        //               }
        //               else{
        //               }
        //             }, child: const Text("Select")),
        //           ),
        //         ),
        //       );
        //     }
        // ),
      }),


    );
  }
}
