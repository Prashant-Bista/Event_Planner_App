import 'package:event_planner_app/pages/Budget/budget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: muave,
        title: const Manrope(text:"Events", color: Colors.white,weight: FontWeight.bold,),
        elevation: 20.0,
        shadowColor: Colors.grey,
      ),
      body: ValueListenableBuilder(valueListenable: event.listenable(), builder: (context,Box box,widget){
        if(box.isEmpty){
          return const Center(child: Manrope(text: "No Events yet",size: 30.0,));
        }
        else{
          return ListView.builder(itemCount:box.length,itemBuilder: (context,index){
            Event event = box.getAt(index);
            DateTime? eventDate = event.eventDate;
            return GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed('/home',arguments: index);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1,color: Colors.black)
                ),
                child: ListTile(
                  trailing: IconButton(onPressed: (){
                    box.deleteAt(index);
                  }, icon: const Icon(Icons.dangerous,color: Colors.red,)),
                  tileColor: dusty_rose,
                  // trailing: ,
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Manrope(text: event.eventName,size: 35.0,weight: FontWeight.bold,),
                    const SizedBox(height: 10,),
                    Manrope(text: "Scheduled on :   ${eventDate!.year}/ ${eventDate.month}/ ${eventDate.day}        At ${eventDate.hour}:${eventDate.minute<10?"0${eventDate.minute}":eventDate.minute}")
                    ]
                  ),
                ),
              ),
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
                      const Manrope(text: "Date Time: ",size: 15.0,weight: FontWeight.bold,),
                      SizedBox(
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Container(
                              width: deveiceWidth/2.1,
                                decoration:BoxDecoration(
                              border: Border.all(width: 1,color: lightPurple)
                            ),child: Center(child: Manrope(size:15.0,text: picked==null?"Not selected": DateFormat('yyyy/MM/dd/hh:mm a').format(picked!),))),
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
                  event.add(Event(eventBudget: Budget(budget: 0,isSet: false), eventExpenses: [], eventGuests: [], eventTasks: [], eventName: nameController.text, eventDate: picked));
                  Navigator.pop(context);
                }, child: const Manrope(text: "Add")),
              );},
            );
          });

      }, child: const Icon(Icons.add),),
    );
  }
}
