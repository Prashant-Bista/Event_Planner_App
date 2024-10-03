import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components.dart';
import '../Events/event.dart';
import 'package:event_planner_app/business_logic.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
class BudgetTrack extends ConsumerWidget {
  final int eventIndex;

  const BudgetTrack({super.key, required this.eventIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double deviceHeight = MediaQuery
        .of(context)
        .size
        .height;
    double deviceWidth = MediaQuery
        .of(context)
        .size
        .width ;
    final provider = ref.watch(stateProvider);
    TextEditingController titleController = TextEditingController();
    TextEditingController expensecontroller=TextEditingController();
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex); // Update thisEvent on change
    return Scaffold(
      backgroundColor: light_dusty_rose,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: muave,
        title: FrenchCannon(
          text: "Budgeting",
          color: Colors.white,
          weight: FontWeight.bold,
        ),
        elevation: 20.0,
        shadowColor: Colors.grey,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ValueListenableBuilder(
            valueListenable: eventBox.listenable(),
            builder: (context, Box<Event> box, _) {
              if (thisEvent!.eventBudget.budget == 0 &&
                  thisEvent!.eventExpenses.isEmpty) {
                return FrenchCannon(
                  text: "No Budget or Expense added yet",
                  size: 35.0,
                  color: Color.fromRGBO(11, 13, 23, 1),
                );
              } else if (thisEvent!.eventBudget.budget != 0 &&
                  thisEvent!.eventExpenses.isEmpty) {
                return                     Container(
                  height: 50,
                  width: deviceWidth,
                  color: dusty_rose,
                  child: Center(child: FrenchCannon(
                    text: "Budget: ${thisEvent.eventBudget.budget
                        .toString()}",
                    size: 20.0,
                    weight: FontWeight.bold,color: Colors.green,)),
                );
              } else if (thisEvent!.eventBudget.budget == 0 &&
                  thisEvent!.eventExpenses.isNotEmpty) {
                return Column(
                  children: [
                    FrenchCannon(
                      text: "No Budget added yet",
                      size: 35.0,
                      color: Color.fromRGBO(11, 13, 23, 1),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: light_dusty_rose,
                          border: Border.all(color: Colors.black, width: 2)),
                      height: 450, // Specify a height
                      child: ListView.builder(
                        shrinkWrap: false,
                        itemCount: thisEvent!.eventExpenses.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              SizedBox(height: 15.0),
                              Container(
                                decoration: BoxDecoration(
                                    color: dusty_rose,
                                    borderRadius: BorderRadius.circular(25)
                                ),
                                child: ListTile(
                                  leading: Column(
                                    children: [
                                      FrenchCannon(
                                        text:
                                        "Expense: ${thisEvent!.eventExpenses[index]
                                            .expenses}",
                                        size: 15.0,
                                        color: Colors.redAccent,
                                        weight: FontWeight.bold,
                                      ),
                                      FrenchCannon(
                                        text:
                                        "For: ${thisEvent!.eventExpenses[index]
                                            .purpose}",
                                        size: 15.0,
                                        color: Colors.redAccent,
                                        weight: FontWeight.bold,
                                      )
                                    ],
                                  ),
                                  trailing: RemoveButton(onPressed: (){
                                    provider.deleteExpense(eventIndex, index);
                                  },),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    )                  ],
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 30,
                      width: deviceWidth,
                      color: dusty_rose,
                      child: Center(child: FrenchCannon(
                        text: "Budget: ${thisEvent.eventBudget.budget
                            .toString()}",
                        size: 15.0,
                        weight: FontWeight.bold,color: Colors.green,)),
                    ),
                    Container(
                        width: deviceWidth,
                        height: 60,
                        color: dusty_rose,
                        child: Center(child: FrenchCannon(
                          text: "Budget left(Vendors included): ${provider
                              .calcBudgetLeft(eventIndex).toString()}",
                          size: 15.0,
                          weight: FontWeight.bold,color: Colors.orange,))),
                    Container(
                      decoration: BoxDecoration(
                          color: light_dusty_rose,
                          border: Border.all(color: Colors.black, width: 2)),
                      height: 450, // Specify a height
                      child: ListView.builder(
                        shrinkWrap: false,
                        itemCount: thisEvent!.eventExpenses.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              SizedBox(height: 15.0),
                              Container(
                                decoration: BoxDecoration(
                                    color: dusty_rose,
                                    borderRadius: BorderRadius.circular(25)
                                ),
                                child: ListTile(
                                  leading: Column(
                                    children: [
                                      FrenchCannon(
                                        text:
                                        "Expense: ${thisEvent!.eventExpenses[index]
                                            .expenses}",
                                        size: 15.0,
                                        color: Colors.redAccent,
                                        weight: FontWeight.bold,
                                      ),
                                      FrenchCannon(
                                        text:
                                        "For: ${thisEvent!.eventExpenses[index]
                                            .purpose}",
                                        size: 15.0,
                                        color: Colors.redAccent,
                                        weight: FontWeight.bold,
                                      )
                                    ],
                                  ),
                                  trailing: RemoveButton(onPressed: (){
                                    provider.deleteExpense(eventIndex, index);
                                  },),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            },
          ),
          SizedBox(height: 10,),
          Container(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: dusty_rose,
                  onPressed: () {
                    showDialog(context: context, builder: (BuildContext context){
                      return AlertDialog(
                        title: SizedBox(
                          width: 250,
                          child: Column(
                            children: [
                              TextField(
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                controller: expensecontroller,
                                focusNode: FocusNode(),
                                decoration: InputDecoration(
                                    hintText:  "Expense",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(3),
                                        borderSide: const BorderSide(style: BorderStyle.solid,width: 1)
                                    )
                                ),
                              ),
                    SizedBox(height: 20,),
                    TextField(
                    controller: titleController,
                    focusNode: FocusNode(),
                    decoration: InputDecoration(
                    hintText:  "Purpose",
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                    borderSide: const BorderSide(style: BorderStyle.solid,width: 1)
                    )
                    ),
                    ),
                            ],
                          ),
                        ),
                        content: ElevatedButton(child: const FrenchCannon(text:"Add"),onPressed: (){
                            provider.addExpense(double.parse(expensecontroller.text), eventIndex,titleController.text);
                        }
                        ));
                    });
                  },
                  child: Text("Add Expenses"),
                ),

                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: dusty_rose,
                  onPressed: () {
                    CommonAlert(context, eventIndex, "Budget", provider);
                  },
                  child: Text("Add Budget"),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomBar(eventIndex: eventIndex,),
    );
  }
}