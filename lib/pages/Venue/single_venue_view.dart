import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planner_app/business_logic.dart';
import 'package:event_planner_app/components.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SingleVenueView extends ConsumerWidget {
  final DocumentSnapshot document;
  const SingleVenueView({super.key, required this.document});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(stateProvider);

    return Scaffold(
      appBar: AppBar(
        title: BulletoKilla(text: document["name"]),
      ),
      body: Column(
        children: [
          Image.network(document["image_url"]),
          SizedBox(height: 50,),
          Wrap(
            runSpacing: 20,
            spacing: 50,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [FrenchCannon(text: "Location:",), FrenchCannon(text: document["location"],size: 20.0),
                Text("----------------------------------")],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [FrenchCannon(text: "Contact"), FrenchCannon(text: document["contact"],size: 20.0),Text("----------------------------------")],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [FrenchCannon(text: "Capacity(people)"), FrenchCannon(text: document["capacity"].toString(),size: 20.0),
                  Text("----------------------------------")],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [FrenchCannon(text: "Price Per Plate"), FrenchCannon(text: document["price_per_plate"].toString(),size: 20.0),
                  Text("----------------------------------")],
              ),
              SizedBox(
                width: 150,
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FrenchCannon(text: "Connect",),
                    Row(mainAxisAlignment:MainAxisAlignment.center,children: [IconButton(icon: Image.asset("assets/images/whatsapp.png",width: 20,height: 20,),onPressed: (){
                      provider.whatsappConnect(document["contact"], context);
                    },),
                      IconButton(onPressed: (){
                        provider.dialerConnect(document["contact"], context);
                      }, icon: const Icon(Icons.call,size: 20,)),
                    ],),
                    Text("----------------------------------"),

                  ],

                ),
              ),
              SizedBox(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [FrenchCannon(text: "Select this Venue"),
                    Text("----------------------------------"),
                  ],
                ),
              )


            ],
          )
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //  children:[
          //     const Column(
          //       crossAxisAlignment: CrossAxisAlignment.end,
          //       children: [
          //         FrenchCannon(text: "Location:"),
          //         FrenchCannon(text: "Capacity(people):"),
          //         FrenchCannon(text: "Price per Plate:"),
          //         FrenchCannon(text: "Contact:"),
          //
          //       ],
          //     ),
          //      Column(
          //        crossAxisAlignment: CrossAxisAlignment.start,
          //        children: [
          //         FrenchCannon(text: document["location"]),
          //         FrenchCannon(text: document["capacity"].toString()),
          //         FrenchCannon(text: document["price_per_plate"].toString()),
          //          Row(
          //            crossAxisAlignment: CrossAxisAlignment.start,
          //            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //            children: [
          //              FrenchCannon(text: document["contact"]),

          //            ],
          //          )
          //
          //        ],
          //
          //                    ),],
          // ),
        ],
      ),
    );
  }
}