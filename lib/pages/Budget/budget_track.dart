import 'package:event_planner_app/pages/Guests/add_guests.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../../components.dart';
import '../Events/event.dart';
import 'budget.dart';
class BudgetTrack extends StatefulWidget {
  final int eventIndex;
  const BudgetTrack({super.key, required this.eventIndex});

  @override
  State<BudgetTrack> createState() => _BudgetTrackState();
}

class _BudgetTrackState extends State<BudgetTrack> {
  Box<Budget> budgetBox = Hive.box<Budget>('budget');
  Box<Event> eventBox = Hive.box<Event>('event');


  @override
  Widget build(BuildContext context) {
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
              Event? thisEvent = box.getAt(widget.eventIndex); // Update thisEvent on change

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
          )        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [SizedBox(width:120,child: MaterialButton(shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),color:lightPurple,onPressed: (){},child: Text("Add Expenses"),)),
        SizedBox(height: 20,),
        SizedBox(width:120,child: MaterialButton(shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),color:lightPurple,onPressed: (){},child: Text("Add Budget"),))
        ],
      ),

    );
  }
}
