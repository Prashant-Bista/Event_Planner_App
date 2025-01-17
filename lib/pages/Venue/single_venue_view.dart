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
          const SizedBox(height: 50,),
          Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 20,
            spacing: 50,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [const FrenchCannon(text: "Location:",), Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FrenchCannon(text: document["place"],size: 20.0),
                    IconButton(onPressed: (){}, icon: Icon(Icons.location_on,size: 30,))
                  ],
                ),
                const Text("-----------------------------------------")],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [const FrenchCannon(text: "Contact"), FrenchCannon(text: document["contact"],size: 20.0),const Text("----------------------------------")],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [const FrenchCannon(text: "Capacity(people)"), FrenchCannon(text: document["capacity"].toString(),size: 20.0),
                  const Text("----------------------------------")],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [const FrenchCannon(text: "Price Per Plate"), FrenchCannon(text: document["price_per_plate"].toString(),size: 20.0),
                  const Text("----------------------------------")],
              ),
              SizedBox(
                width: 150,
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const FrenchCannon(text: "Connect",),
                    Row(mainAxisAlignment:MainAxisAlignment.center,children: [IconButton(icon: Image.asset("assets/images/whatsapp.png",width: 25,height: 25,),onPressed: (){
                      provider.whatsappConnect(document["contact"], context);
                    },),
                      IconButton(onPressed: (){
                        provider.dialerConnect(document["contact"], context);
                      }, icon: const Icon(Icons.call,size: 25,)),
                    ],),
                    const Text("----------------------------------"),

                  ],

                ),
              ),


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
