import 'package:event_planner_app/components.dart';
import 'package:event_planner_app/pages/Todo/tasks.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  TextEditingController titleController = TextEditingController();
  Box<Tasks> todoBox = Hive.box('todo');
  int itemcount=0;
  @override
  void initState() {
    // TODO: implement initState
     itemcount= todoBox.length;
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
      body: ValueListenableBuilder(valueListenable: todoBox.listenable(), builder: (context,Box box, widget){
        if (box.isEmpty) {
          return Center(child: Manrope(text: "No tasks to do",size: 35.0,color: Color.fromRGBO(11, 13, 23, 1),));
        }
          else{
            return ListView.builder(itemCount:box.length,itemBuilder: (context,index){
              Tasks task = box.getAt(index);
              return ListTile(
                title:Text("${task.title}",style: GoogleFonts.manrope(fontSize: 30,decoration: task.isDone?TextDecoration.lineThrough:TextDecoration.none),),
                leading: Checkbox(value: task.isDone, onChanged: (bool? value){
                  box.putAt(index,Tasks(title: task.title,isDone: value!) ) ;
                },
                ),
                trailing: IconButton(icon: Icon(Icons.dangerous_outlined,color: Colors.red,size: 20,),onPressed: (){
                  box.deleteAt(index);
                },),
              );
            });

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
        todoBox.add(Tasks(title: titleController.text, isDone: false));
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
