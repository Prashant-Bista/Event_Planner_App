import 'package:event_planner_app/business_logic.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components.dart';
import '../Events/event.dart';

class BudgetTrack extends ConsumerWidget {
  final int eventIndex;
  const BudgetTrack({super.key, required this.eventIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double budgetWidth = deviceWidth/2;

    final provider = ref.watch(stateProvider);
    TextEditingController titleController = TextEditingController();
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex); // Update thisEvent on change
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: muave,
        title: const Manrope(
          text: "Budget Management",
          color: Colors.white,
          weight: FontWeight.bold,
        ),
        elevation: 20.0,
        shadowColor: Colors.grey,
      ),
      body: Column(
        children: [
          ValueListenableBuilder(
            valueListenable: eventBox.listenable(),
            builder: (context, Box<Event> box, _) {
              if (thisEvent!.eventBudget.budget == 0 &&
                  thisEvent.eventExpenses.isEmpty) {
                return const Manrope(
                  text: "No Budget or Expense added yet",
                  size: 35.0,
                  color: Color.fromRGBO(11, 13, 23, 1),
                );
              } else if (thisEvent.eventBudget.budget != 0 &&
                  thisEvent.eventExpenses.isEmpty) {
                return Column(
                  children: [
                    BudgetTile(value: thisEvent.eventBudget.budget),
                    const Manrope(
                      text: "No Expense added yet",
                      size: 20.0,
                      color: Colors.black,
                      weight: FontWeight.bold,
                    )
                  ],
                );
              } else if (thisEvent.eventBudget.budget == 0 &&
                  thisEvent.eventExpenses.isNotEmpty) {
                return Column(
                  children: [
                    const Manrope(
                      text: "No Budget added yet",
                      size: 35.0,
                      color: Color.fromRGBO(11, 13, 23, 1),
                    ),
                    SizedBox(
                      height: deviceHeight / 2, // Specify a height
                      child: ListView.builder(
                        itemCount: thisEvent.eventExpenses.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            tileColor: Colors.redAccent,
                            leading: Manrope(
                              text:
                                  "Expense: ${thisEvent.eventExpenses[index].expenses}",
                              size: 20.0,
                              color: Colors.black,
                              weight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    )
                  ],
                );
              } else {
                return SizedBox(
                  height: 600,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: budgetWidth,
                            color: Colors.greenAccent,
                            child: Center(child: Manrope(text: "Budget:\n ${thisEvent.eventBudget.budget.toString()}",size:deviceWidth/20,weight: FontWeight.bold,)),
                          ),
                          Container(
                            width: budgetWidth,
                            height: 50,
                              color: const Color.fromRGBO(128, 128,0, 1),
                              child: Center(child: Manrope(text: "Budget Remaining:\n ${provider.calcBudgetLeft(eventIndex).toString()}",size: 12.0,weight: FontWeight.bold,))),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                            border: Border.all(color: Colors.black, width: 2)),
                        height: 475, // Specify a height
                        child: ListView.builder(
                          shrinkWrap: false,
                          itemCount: thisEvent.eventExpenses.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Manrope(
                                text:
                                    "Expense: ${thisEvent.eventExpenses[index].expenses}",
                                size: 20.0,
                                color: Colors.black,
                                weight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      ),

                    ],

                  ),
                );
              }
            },
          ),
          SizedBox(
            height:100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: lightPurple,
                  onPressed: () {
                    CommonAlert(context, eventIndex, "Expense", provider);
                  },
                  child: const Text("Add Expenses"),
                ),
                 SizedBox(
                  height: 60,
                ),
                MaterialButton(
                  minWidth: 180,
                  height: 200,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: lightPurple,
                  onPressed: () {
                    CommonAlert(context, eventIndex, "Budget", provider);
                  },
                  child: const Text("Add/Update Budget"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
