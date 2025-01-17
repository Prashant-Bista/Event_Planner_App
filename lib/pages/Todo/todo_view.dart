import 'package:event_planner_app/business_logic.dart';
import 'package:event_planner_app/components.dart';
import 'package:event_planner_app/pages/Todo/tasks.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const FrenchCannon(
          text: "Todo",
          color: Colors.white,
          weight: FontWeight.bold,
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: eventBox.listenable(),
        builder: (context, Box<Event> box, _) {
          thisEvent = box.getAt(eventIndex);

          if (thisEvent!.eventTasks.isEmpty) {
            return const Center(
              child: FrenchCannon(
                text: "No Tasks added yet",
                size: 30.0,
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
                        style: TextStyle(
                          fontFamily: "FrenchCannon",
                            fontSize: 20,
                            decoration: task.isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      ),
                      leading: Checkbox(
                        value: task.isDone,
                        onChanged: (bool? value) =>
                            provider.taskCompletion(value!, eventIndex, index),
                      ),
                      trailing: RemoveButton(
                          onPressed:(){
                            provider.taskDelete(eventIndex, index);
                          } ));
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
commonAlert(context, eventIndex, "Task", provider);
        },
      ),
      bottomNavigationBar: BottomBar(eventIndex: eventIndex),
    );
  }
}
