import 'package:event_planner_app/pages/Budget/budget.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

import '../../components.dart';
import 'event.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  TextEditingController nameController = TextEditingController();
  DateTime? picked;
  Box<Event> event = Hive.box<Event>('event');
  @override
  Widget build(BuildContext context) {
    double deveiceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: dusty_rose,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: muave,
        title: const FrenchCannon(text:"Events", color: Colors.white,weight: FontWeight.bold,),
        elevation: 20.0,
        shadowColor: Colors.grey,
      ),
      body: ValueListenableBuilder(valueListenable: event.listenable(), builder: (context,Box box,widget){
        if(box.isEmpty){
          return const Center(child: FrenchCannon(text: "No Events yet",size: 30.0,));
        }
        else{
          return ListView.builder(itemCount:box.length,itemBuilder: (context,index){
            Event event = box.getAt(index);
            DateTime? eventDate = event.eventDate;
            return Column(
              children: [
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushNamed('/home',arguments: index);
                  },
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)
                    ),
                    tileColor: light_dusty_rose,
                    // trailing: ,
                    title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [BulletoKilla(text: event!.eventName,),
                          FrenchCannon(text: "On :   ${event!.eventDate!.year}/${event!.eventDate!.month}/${event!.eventDate!.day}        At ${event!.eventDate!.hour}:${event!.eventDate!.minute<10?"0${event!.eventDate!.minute}":event!.eventDate!.minute}",size: 12.0,)
                        ]
                    ),
                    trailing: IconButton(icon: const Icon(Icons.dangerous,color: Colors.red,),onPressed: (){
                        box.deleteAt(index);
                      },),

                ),),
              ],
            );}
          );
        }
      }),
      floatingActionButton: FloatingActionButton(onPressed: (){

          picked=null;
          showDialog(context: context, builder: (BuildContext context){
            return StatefulBuilder(
              builder: (BuildContext context,StateSetter setState){
              return AlertDialog(
                title: SizedBox(
                  width: 500,
                  child: Column(
                    children: [
                      TextField(
                        textAlign: TextAlign.center,
                        focusNode: FocusNode(),
                        controller: nameController,
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(fontSize: 13),
                            hintText:  "Name of Event",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3),
                                borderSide: BorderSide(style: BorderStyle.solid,width: 1,color: lightPurple)
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3),
                                borderSide: BorderSide(style: BorderStyle.solid,width: 1,color: lightPurple)
                            )
                        ),
                      ),
                      const SizedBox(height: 10,),
                      const FrenchCannon(text: "Date Time: ",size: 13.0,weight: FontWeight.bold,),
                      const SizedBox(height: 10,),

                      SizedBox(
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Container(
                              width: deveiceWidth/2.1,
                                decoration:BoxDecoration(
                              border: Border.all(width: 1,color: lightPurple)
                            ),child: Center(child: FrenchCannon(size:13.0,text: picked==null?"Not selected": DateFormat('yyyy/MM/dd/hh:mm a').format(picked!),))),
                            IconButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.date_range,color:Color(0xff45267ff),size: 25,),
                                onPressed: () async{
                              final DateTime? selectedDate =  await showDatePicker(context: context, firstDate: DateTime(2000,1,1), lastDate: DateTime(2100,1,1),initialDate: DateTime.now(),);
                              if (selectedDate==null){
                                return;
                              }
                              final TimeOfDay? selectedTime =  await showTimePicker(context: context, initialTime: TimeOfDay.now() );
                              if (selectedTime==null){
                                return;
                              }
                              setState(() {
                                picked =DateTime(selectedDate.year,selectedDate.month,selectedDate.day,selectedTime.hour,selectedTime.minute);
                              });
                            }
                                        ),
                          ],
                        ),
                      )


                ],
                  ),
                ),
                content: ElevatedButton(onPressed: (){
                  event.add(Event(eventBudget: Budget(budget: 0,isSet: false), eventExpenses: [], eventGuests: [], eventTasks: [], eventName: nameController.text, eventDate: picked,eventVendors: [],vendorsCount: 0,guestsCount: 0));
                  Navigator.pop(context);
                }, child: const FrenchCannon(text: "Add")),
              );},
            );
          });

      }, child: const Icon(Icons.add),),
    );
  }
}
