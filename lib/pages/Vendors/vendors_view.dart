import 'package:event_planner_app/business_logic.dart';
import 'package:event_planner_app/components.dart';
import 'package:event_planner_app/pages/Todo/tasks.dart';
import 'package:event_planner_app/pages/Vendors/vendors.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../Events/event.dart';

class VendorsView extends ConsumerWidget {
  final int eventIndex;
  const VendorsView({super.key, required this.eventIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(stateProvider);
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
   bool isInvited=false;


    bool booking = false;
    return Scaffold(
      backgroundColor: dusty_rose,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: muave,
        title: const FrenchCannon(
          text: "Vendors",
          color: Colors.white,
        ),
        elevation: 20.0,
      ),
      body: ValueListenableBuilder(
        valueListenable: eventBox.listenable(), // Listen to the eventBox
        builder: (context, Box<Event> box, _) {
          thisEvent = box.getAt(eventIndex); // Update thisEvent on change

          if (thisEvent!.eventVendors.isEmpty) {
            return const Center(
              child: FrenchCannon(
                text: "No Vendors added yet",
                size: 25.0,
                color: Color.fromRGBO(11, 13, 23, 1),
              ),
            );
          } else {
            return ListView.builder(
                itemCount: thisEvent!.eventVendors.length,
                itemBuilder: (context, index) {
                  Vendors vendor = box.getAt(eventIndex)!.eventVendors[index];
                  return GestureDetector(
                    onTap: (){
                      showDialog(context: context, builder: (context){
                        return GuestAlert(eventIndex: eventIndex,isVendor: true,isUpdate: true,itemIndex: index,);
                      });

                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)
                        ),
                        tileColor: light_dusty_rose,
                        // trailing: ,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 20,),
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FrenchCannon(text: 'Vendor:',size: 13.0,),
                                FrenchCannon(text: 'Contact:',size: 13.0),
                                FrenchCannon(text: 'Price:',size: 13.0),
                                FrenchCannon(text: 'Booked:',size: 13.0),


                              ],
                            ),
                            const SizedBox(width: 20,),

                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FrenchCannon(text: vendor.name,size: 13.0),
                                FrenchCannon(text: vendor.contact,size: 13.0),
                                FrenchCannon(text: vendor.price.toString(),size: 13.0),
                                StatefulBuilder(builder: (context,setState){
                                  return Checkbox(
                                    value: thisEvent!.eventVendors[index].isBooked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isInvited = value!;
                                        provider.updateVendors(eventIndex, index, thisEvent!.eventVendors[index].name!, thisEvent!.eventVendors[index].price!, isInvited!, thisEvent!.eventVendors[index].contact!);
                                      });
                                    },
                                  );

                                })

                              ],
                            ),
                          ],
                        ),
                        trailing: RemoveButton(onPressed: (){}),
                      ),
                    ),
                  );
                });
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(11, 13, 23, 1),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          showDialog(context: context, builder: (BuildContext context){
            return GuestAlert(eventIndex: eventIndex, isUpdate: false, itemIndex: 0, isVendor: true);
            //   StatefulBuilder(builder: (context,setState){
            //  return AlertDialog(
            //     title: SizedBox(
            //       width: 250,
            //       child: Column(
            //         children: [
            //           TextField(
            //             controller: titleController,
            //             focusNode: FocusNode(),
            //             decoration: InputDecoration(
            //                 hintText:  "Vendor Type",
            //                 border: OutlineInputBorder(
            //                     borderRadius: BorderRadius.circular(3),
            //                     borderSide: const BorderSide(style: BorderStyle.solid,width: 1)
            //                 )
            //             ),
            //           ),
            //           SizedBox(height: 10,),
            //           TextField(
            //             controller: contactController,
            //             focusNode: FocusNode(),
            //             decoration: InputDecoration(
            //                 hintText:  "Vendor's Contact",
            //                 border: OutlineInputBorder(
            //                     borderRadius: BorderRadius.circular(3),
            //                     borderSide: const BorderSide(style: BorderStyle.solid,width: 1)
            //                 )
            //             ),
            //           ),
            //           SizedBox(height: 10,),
            //           TextField(
            //             controller: priceController,
            //             focusNode: FocusNode(),
            //             decoration: InputDecoration(
            //                 hintText:  "Vendor's Price",
            //                 border: OutlineInputBorder(
            //                     borderRadius: BorderRadius.circular(3),
            //                     borderSide: const BorderSide(style: BorderStyle.solid,width: 1)
            //                 )
            //             ),
            //           ),
            //           ListTile(
            //             title: FrenchCannon(text: "Booked"),
            //             trailing: Checkbox(
            //               value: booking,
            //               onChanged: (bool? value) {
            //                 setState((){
            //                   booking = value!;
            //
            //                 });
            //               },
            //             ),
            //           )
            //         ],
            //       ),
            //     ),
            //     content: ElevatedButton(onPressed: (){
            //       Navigator.pop(context);
            //     }, child: const FrenchCannon(text:"Add")),
            //   );
            // }) ;
          });        },
      ),
      bottomNavigationBar: BottomBar(eventIndex: eventIndex),
    );
  }
}
