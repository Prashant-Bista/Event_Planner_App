
import 'package:event_planner_app/pages/Events/event.dart';
import 'package:event_planner_app/pages/Guests/guests.dart';
import 'package:event_planner_app/pages/Todo/tasks.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

Color lightPurple= Color(0xFF45267FF);

Color mainColor = Color.fromRGBO(11, 14, 28, 1);
class Manrope extends StatelessWidget {
  final text;
  final size;
  final weight;
  final color;
  const Manrope({super.key, @required this.text,  this.size, this.weight,  this.color});

  @override
  Widget build(BuildContext context) {
    return   Text(text,style: GoogleFonts.manrope(fontSize: size,fontWeight: weight,color: color),)
    ;
  }
}


class InputField extends StatefulWidget {
  final double width;
  final  onSaved;
  final prefixIcon;
  final bool isObscure;
  final SuffixIcon;
  final String hinttext;
  final validator;

  const InputField({super.key, required this.width, @required this.onSaved, @required this.prefixIcon, required this.isObscure, this.SuffixIcon, required this.hinttext, @required this.validator});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late bool isInvisible;
  @override
  void initState() {
    // TODO: implement initState
    if (widget.isObscure==true){
      isInvisible=true;
    }
    else
      isInvisible = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return               SizedBox(
      width: widget.width,
      child: TextFormField(
        obscureText: isInvisible,
        onSaved: widget.onSaved,
        validator: widget.validator,
        decoration: InputDecoration(
            hintText: widget.hinttext,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.isObscure?IconButton(onPressed: (){
              setState(() {
                isInvisible=!isInvisible;
              });
            }, icon: Icon(Icons.remove_red_eye,color: Colors.black,)):null,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(10)
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(15)
            ),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(10)
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(15)
            )

        ),
      ),
    );

  }
}

class GuestList extends StatelessWidget {
  final String contact;
  final String memberNo;
  final String name;
  final bool isInvited;
  final int index;
  final int eventIndex;
  const GuestList({super.key, required this.contact, required this.memberNo, required this.name, required this.isInvited, required this.index, required this.eventIndex});

  @override
  Widget build(BuildContext context) {
    Box<Event> eventBox = Hive.box<Event>('event');
    return GestureDetector(
          onTap: (){
            // GuestAlert(context,eventIndex);
          },
          child:    Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Color.fromRGBO(11, 13, 23, 1,),width: 1.5),
            ),
            child:      ListTile(
              trailing: IconButton(onPressed: (){
                Event? thisEvent = eventBox.getAt(eventIndex);
                thisEvent!.eventGuests.removeAt(index);
                eventBox.putAt(eventIndex, thisEvent);
              }, icon: Icon(Icons.dangerous,color: Colors.red,)),
              title: Row(
                children: [
                  SizedBox(width: 20,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Manrope(text: 'Name:'),
                      Manrope(text: 'Contact:'),
                      Manrope(text: 'No of Members:'),
                      Manrope(text: 'Invitation:'),
                    ],
                  ),
                  SizedBox(width: 20,),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Manrope(text: '$name'),
                      Manrope(text: '$contact'),
                      Manrope(text: '$memberNo'),
                      Manrope(text: isInvited?'Invited':"Not Invited"),

                    ],
                  ),
                ],
              ),
            )  ,
          )
      );




  }
}

void GuestAlert(BuildContext context, int eventIndex) {
  Box<Event> eventBox = Hive.box<Event>("event");
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController membersController = TextEditingController();
  Event? thisEvent = eventBox.getAt(eventIndex);
  bool isInvited = false;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: SizedBox(
              width: 250,
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(style: BorderStyle.solid, width: 1),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: contactController,
                    decoration: InputDecoration(
                      hintText: "Contact No",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(style: BorderStyle.solid, width: 1),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: membersController,
                    decoration: InputDecoration(
                      hintText: "No of Members",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(style: BorderStyle.solid, width: 1),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    tileColor: Colors.purple,
                    trailing: Checkbox(
                      value: isInvited,
                      onChanged: (bool? value) {
                        setState(() {
                          isInvited = value!;
                        });
                      },
                    ),
                    title: Text("Invited"),
                  ),
                ],
              ),
            ),
            content: ElevatedButton(
              onPressed: () {
                thisEvent!.eventGuests.add(
                  Guests(
                    guestName: nameController.text,
                    membersNo: int.parse(membersController.text),
                    invited: isInvited,
                    contact: contactController.text,
                  ),
                );

                eventBox.putAt(eventIndex, thisEvent!);

                Navigator.pop(context);
              },
              child: Text("Add"),
            ),
          );
        },
      );
    },
  );
}

class HomeTile extends StatefulWidget {
  final double width;
  final VoidCallback perform;
  final double height;
  final tileIcon;
  final tileName;
  const HomeTile({super.key, required this.width, required this.height, @required this.tileIcon, @required this.tileName, required this.perform});

  @override
  State<HomeTile> createState() => _HomeTileState();
}

class _HomeTileState extends State<HomeTile> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(onPressed: widget.perform,
      minWidth: widget.width,
      height:widget.height ,
      elevation: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      color: Colors.deepPurple,
      child: Container(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(widget.tileIcon ,color: mainColor,size: 40,),
          Manrope(text: widget.tileName,color: mainColor,size: 20.0,)
        ],
      )),
      splashColor: Colors.lightBlueAccent);
  }
}

class TaskList extends StatefulWidget {
  final String title;
  final int taskIndex;
  final int eventIndex;
  final bool isDone;

  const TaskList({super.key, required this.title, required this.taskIndex, required this.isDone, required this.eventIndex});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  Box<Event> eventBox= Hive.box<Event>('event');
  Box<Event> guestBox= Hive.box<Event>('guests');
  Event? thisEvent;
  @override
  void initState() {
    thisEvent = eventBox.getAt(widget.eventIndex);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title:Text(widget.title,style: GoogleFonts.manrope(fontSize: 30,decoration: widget.isDone?TextDecoration.lineThrough:TextDecoration.none),),
      leading: Checkbox(value: widget.isDone, onChanged: (bool? value){
        // Tasks thistask =thisEvent!.eventTasks.elementAt(widget.taskIndex);
        // thistask
      },
      ),
      trailing: IconButton(icon: Icon(Icons.dangerous_outlined,color: Colors.red,size: 20,),onPressed: (){
      },),
    );;
  }
}


