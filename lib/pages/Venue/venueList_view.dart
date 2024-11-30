import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planner_app/business_logic.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components.dart';
import '../Events/event.dart';

class VenueView extends ConsumerWidget {
  final int eventIndex;
   VenueView({super.key,required this.eventIndex});
  Widget build(BuildContext context,WidgetRef ref) {

    final provider = ref.watch(stateProvider);
    Box<Event> eventBox = Hive.box('event');
    return Scaffold(
      appBar: AppBar(
        title: const FrenchCannon(text:"Venues", color: Colors.white, weight: FontWeight.bold),
      ),
      body: ValueListenableBuilder(
        valueListenable: eventBox.listenable(),
        builder:(context,Box<Event> eventBox, _){
          Event? thisEvent = eventBox.getAt(eventIndex);
          int? documentIndex;
          if(thisEvent!=null && thisEvent.eventVenue!=null){
            documentIndex= thisEvent.eventVenue!.selectedDocumentIndex;
          }
          return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("Venues").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
                        return Padding(
                          padding: EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
                          child: SizedBox(
                            height: 200,
                            child: ListTile(
                              tileColor: light_dusty_rose,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              onTap: () {
                                Navigator.of(context).pushNamed('/singlevenue', arguments: documentSnapshot);
                              },
                              leading: Image.network(documentSnapshot["image_url"], fit: BoxFit.fitHeight),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BulletoKilla(text: documentSnapshot["name"], color: Colors.black, size: 15.0),
                                  SizedBox(height: 10),
                                  Text("Location:", style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text(documentSnapshot["location"]),
                                  documentIndex==index?Text("Selected"):Text(""),
                                ],
                              ),
                              trailing: ElevatedButton(onPressed: (){
                                if(thisEvent!=null && thisEvent.eventVenue!=null){
                                  provider.assignVenue(eventIndex, index,documentSnapshot["price_per_plate"]);
                                  print("selectedIndex: ${thisEvent!.eventVenue!.selectedDocumentIndex}");
                                }
                                else{
                                  print("Nullgiven");
                                }
                              }, child: Text("Select")),
                            ),
                          ),
                        );
                      }
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }
          );
        },

      ),
    );
  }
}