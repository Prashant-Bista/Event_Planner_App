import 'package:event_planner_app/business_logic.dart';
import 'package:event_planner_app/components.dart';
import 'package:event_planner_app/pages/Todo/tasks.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../Events/event.dart';

class TodoView extends ConsumerWidget {
  final int eventIndex;
  const TodoView({super.key, required this.eventIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(stateProvider);
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    TextEditingController titleController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: Manrope(
          text: "Todo",
          color: Colors.white,
        ),
        elevation: 20.0,
        shadowColor: Colors.grey,
      ),
      body: ValueListenableBuilder(
        valueListenable: eventBox.listenable(), // Listen to the eventBox
        builder: (context, Box<Event> box, _) {
          thisEvent = box.getAt(eventIndex); // Update thisEvent on change

          if (thisEvent!.eventTasks.isEmpty) {
            return Center(
              child: Manrope(
                text: "No Tasks added yet",
                size: 35.0,
                color: Color.fromRGBO(11, 13, 23, 1),
              ),
            );
          } else {
            return ListView.builder(
                itemCount: thisEvent!.eventTasks.length,
                itemBuilder: (context, index) {
                  Tasks task = thisEvent!.eventTasks[index];
                  return ListTile(
                      title: Text(
                        task.title,
                        style: GoogleFonts.manrope(
                            fontSize: 30,
                            decoration: task.isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      ),
                      leading: Checkbox(
                        value: task.isDone,
                        onChanged: (bool? value) =>
                            provider.taskCompletion(value!, eventIndex, index),
                      ),
                      trailing: IconButton(
                          icon: Icon(
                            Icons.dangerous_outlined,
                            color: Colors.red,
                            size: 20,
                          ),
                          onPressed:(){
                            provider.taskDelete(eventIndex, index);
                          } ));
                });
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(11, 13, 23, 1),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
CommonAlert(context, eventIndex, "Task", provider);
        },
      ),
    );
  }
}
