import 'package:event_planner_app/business_logic.dart';
import 'package:event_planner_app/pages/Guests/add_guests.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components.dart';
import '../Events/event.dart';
import 'budget.dart';
class BudgetTrack extends ConsumerWidget {
  final int eventIndex;
  const BudgetTrack({super.key, required this.eventIndex});

  @override
  Widget build (BuildContext context,WidgetRef ref){
    final provider = ref.watch(stateProvider);
    TextEditingController titleController = TextEditingController();
  Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex); // Update thisEvent on change
    return Scaffold(
      backgroundColor:Colors.white ,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: Manrope(text:"Budget Manaement", color: Colors.white,),
        elevation: 20.0,
        shadowColor: Colors.grey,
      ),
      body: Column(
        children: [
          ValueListenableBuilder(
            valueListenable:eventBox.listenable(), // Listen to the eventBox
            builder: (context, Box<Event> box, _) {
              if (thisEvent!.eventBudget.budget==0) {
                return Center(
                  child: Manrope(
                    text: "No Budget added yet",
                    size: 35.0,
                    color: Color.fromRGBO(11, 13, 23, 1),
                  ),
                );
              } else {
                return Container(
                  child: Manrope(text: "Budget:${thisEvent!.eventBudget.budget} "),
                );
              }
            },
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [SizedBox(width:120,child: MaterialButton(shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),color:lightPurple,onPressed: (){

        },child: Text("Add Expenses"),)),
        SizedBox(height: 20,),
        SizedBox(width:150,child: MaterialButton(shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),color:lightPurple,onPressed: (){
          showDialog(context: context, builder: (BuildContext context){
            return AlertDialog(
              title: SizedBox(
                width: 250,
                child: TextField(
                  focusNode: FocusNode(),
                  controller: titleController,
                  decoration: InputDecoration(
                      hintText:  "Title",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                          borderSide: BorderSide(style: BorderStyle.solid,width: 1)
                      )
                  ),
                ),
              ),
              content: ElevatedButton(onPressed: (){
               provider.AddBudget(eventIndex,double.parse(titleController.text));
               Navigator.pop(context);
              }, child: Manrope(text:"Add")),
            );
          });
        },child: Text( "Add/Update Budget"),))
        ],
      ),
    );
  }
}
