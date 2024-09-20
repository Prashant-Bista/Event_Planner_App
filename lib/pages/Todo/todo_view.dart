import 'package:event_planner_app/components.dart';
import 'package:event_planner_app/pages/Todo/tasks.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../Events/event.dart';

class TodoView extends StatefulWidget {
  final int eventIndex;
  const TodoView({super.key, required this.eventIndex});

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  TextEditingController titleController = TextEditingController();
  Box<Tasks> todoBox = Hive.box<Tasks>('todo');
  Box<Event> eventBox = Hive.box<Event>('event');
  late Event? thisEvent;


  int itemcount=0;
  @override
  void initState() {
    // TODO: implement initState
     thisEvent = eventBox.getAt(widget.eventIndex);
     itemcount= eventBox.getAt(widget.eventIndex)!.eventTasks.length;

     super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white ,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: Manrope(text:"Todo", color: Colors.white,),
        elevation: 20.0,
        shadowColor: Colors.grey,
      ),
      body: ValueListenableBuilder(
        valueListenable:eventBox.listenable(), // Listen to the eventBox
        builder: (context, Box<Event> box, _) {
          thisEvent = box.getAt(widget.eventIndex); // Update thisEvent on change

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
                  title:Text(task.title,style: GoogleFonts.manrope(fontSize: 30,decoration: task.isDone?TextDecoration.lineThrough:TextDecoration.none),),
                  leading: Checkbox(value: task.isDone, onChanged: (bool? value){
                    List<Tasks>? updated= thisEvent!.eventTasks;
                    updated[index]= Tasks(title: thisEvent!.eventTasks[index].title, isDone: value!);
                    eventBox.putAt(index, Event(eventBudget: thisEvent!.eventBudget,eventDate: thisEvent!.eventDate,eventExpenses: thisEvent!.eventExpenses,eventGuests: thisEvent!.eventGuests,eventName: thisEvent!.eventName,eventTasks: updated));
                    },

                  ),
                  trailing: IconButton(icon: Icon(Icons.dangerous_outlined,color: Colors.red,size: 20,),onPressed: (){
                    thisEvent!.eventTasks.removeAt(index);
                    eventBox.putAt(widget.eventIndex, thisEvent!);
                  },),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(11, 13, 23, 1),
        child: Icon(Icons.add,color:Colors.white,),
        onPressed: (){
setState(() {
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
        thisEvent!.eventTasks.add(Tasks(title: titleController.text, isDone: false));
        eventBox.putAt(widget.eventIndex, thisEvent!);
        Navigator.pop(context);
        titleController.text='';
      }, child: Manrope(text: "Add")),
    );
  });
});
      },),
    );
  }
}
