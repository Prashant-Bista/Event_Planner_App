import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../components.dart';
import '../Events/event.dart';
import 'package:event_planner_app/business_logic.dart';
import 'package:hive_flutter/adapters.dart';
class BudgetTrack extends ConsumerWidget {
  final int eventIndex;
  const BudgetTrack({super.key, required this.eventIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const FrenchCannon(
          text: "Budgeting",
          color: Colors.white,
          weight: FontWeight.bold,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ValueListenableBuilder(
            valueListenable: eventBox.listenable(),
            builder: (context, Box<Event> box, _) {
              if (thisEvent!.eventBudget.budget == 0 &&
                  thisEvent.eventExpenses.isEmpty) {
                return const FrenchCannon(
                  text: "No Budget or Expense added yet",
                  size: 35.0,
                  color: Color.fromRGBO(11, 13, 23, 1),
                );
              } else if (thisEvent.eventBudget.budget != 0 &&
                  thisEvent.eventExpenses.isEmpty) {
                return Container(
                  height: 100,
                  width: deviceWidth,
                  color: dustyRose,
                  child: Center(child: Column(
                    children: [
                      FrenchCannon(
                        text: "Budget:  Rs. ${thisEvent.eventBudget.budget
                            .toString()}",
                        size: 20.0,
                        weight: FontWeight.bold,color: Colors.green,),
                    PredictionRow(provider, eventIndex),
                    ],
                  )),
                );
              } else if (thisEvent.eventBudget.budget == 0 &&
                  thisEvent.eventExpenses.isNotEmpty) {
                return Column(
                  children: [
                    const FrenchCannon(
                      text: "No Budget added yet",
                      size: 35.0,
                      color: Color.fromRGBO(11, 13, 23, 1),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: lightDustyRose,
                          border: Border.all(color: Colors.black, width: 2)),
                      height: 450, // Specify a height
                      child: ListView.builder(
                        shrinkWrap: false,
                        itemCount: thisEvent.eventExpenses.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              const SizedBox(height: 15.0),
                              Container(
                                decoration: BoxDecoration(
                                    color: dustyRose,
                                    borderRadius: BorderRadius.circular(25)
                                ),
                                child: ListTile(
                                  leading: Column(
                                    children: [
                                      FrenchCannon(
                                        text:
                                        "Expense: Rs. ${thisEvent.eventExpenses[index]
                                            .expenses}",
                                        size: 15.0,
                                        color: Colors.redAccent,
                                        weight: FontWeight.bold,
                                      ),
                                      FrenchCannon(
                                        text:
                                        "For: ${thisEvent.eventExpenses[index]
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 5,left: 5),
                      height: 50,
                      width: deviceWidth,
                      color: dustyRose,
                      child: RichText(
                        textAlign: TextAlign.start,
                          text: TextSpan(children: [
                        TextSpan(text: "Budget: Rs. ${thisEvent.eventBudget.budget.toString()}\n\n",style: const TextStyle(fontFamily: "FrenchCannon",color: Colors.green,fontSize: 15.0,),),
                        TextSpan(text: "Budget left(Vendors included): ${provider
                            .calcBudgetLeft(eventIndex).toString()}\n\n",style: const TextStyle(fontFamily: "FrenchCannon",color: Colors.orange,fontSize: 15.0)),
                      ]))),
              PredictionRow(provider, eventIndex),
                    const SizedBox(height: 10,),

                    Container(
                      decoration: BoxDecoration(
                          color: lightDustyRose,
                          border: Border.all(color: Colors.black, width: 2)),
                      height: 450, // Specify a height
                      child: ListView.builder(
                        shrinkWrap: false,
                        itemCount: thisEvent.eventExpenses.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              const SizedBox(height: 15.0),
                              Container(
                                decoration: BoxDecoration(
                                    color: dustyRose,
                                    borderRadius: BorderRadius.circular(25)
                                ),
                                child: ListTile(
                                  leading: Column(
                                    children: [
                                      FrenchCannon(
                                        text:
                                        "Expense: Rs. ${thisEvent.eventExpenses[index]
                                            .expenses}",
                                        size: 15.0,
                                        color: Colors.redAccent,
                                        weight: FontWeight.bold,
                                      ),
                                      FrenchCannon(
                                        text:
                                        "For: ${thisEvent.eventExpenses[index]
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
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: lightDustyRose,
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
                    const SizedBox(height: 20,),
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
                            Navigator.of(context).pop();
                        }
                        ));
                    });
                  },
                  child: const Text("Add Expenses"),
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: lightDustyRose,
                  onPressed: () {
                    commonAlert(context, eventIndex, "Budget", provider);
                  },
                  child: const Text("Add Budget"),
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