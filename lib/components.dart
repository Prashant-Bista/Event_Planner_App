
import 'package:event_planner_app/pages/Budget/budget.dart';
import 'package:event_planner_app/pages/Events/event.dart';
import 'package:event_planner_app/pages/Guests/guests.dart';
import 'package:event_planner_app/pages/Todo/tasks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:event_planner_app/business_logic.dart';

Color lightPurple= const Color(0xff45267ff);
TextEditingController valueController =TextEditingController();
Color mainColor = const Color.fromRGBO(11, 14, 28, 1);
Color muave = const Color.fromRGBO(199, 124, 124, 1.0);
Color dusty_rose = const Color.fromRGBO(242, 202, 198, 1.0);
Color dark_dusty_rose = const Color.fromRGBO(244, 175, 168, 1.0);

Color light_dusty_rose = const Color.fromRGBO(242, 223, 223, 1.0);

Color soft_blue_grey = const Color.fromRGBO(206, 230, 242, 1);
// class FrenchCannon extends StatelessWidget {
//   final text;
//   final size;
//   final weight;
//   final color;
//   const FrenchCannon({super.key, @required this.text,  this.size, this.weight,  this.color});
//
//   @override
//   Widget build(BuildContext context) {
//     return   Text(text,style: GoogleFonts.FrenchCannon(fontSize: size,fontWeight: weight,color: color),)
//     ;
//   }
// }
class FrenchCannon extends StatelessWidget {
  final text;
  final size;
  final weight;
  final color;
  const FrenchCannon({super.key, @required this.text,  this.size, this.weight,  this.color});

  @override
  Widget build(BuildContext context) {
    return   Text(text,style: TextStyle(fontFamily: "FrenchCannon",fontSize: size,color: color),)
    ;
  }
}
class ScheduleFont extends StatelessWidget {
  final text;
  const ScheduleFont({super.key, @required this.text,});

  @override
  Widget build(BuildContext context) {
    return   Text(text,style: GoogleFonts.manrope(fontSize: 14),)
    ;
  }
}
class EventTile extends StatelessWidget {
  final Event thisEvent;
  const EventTile({super.key, required this.thisEvent});

  @override
  Widget build(BuildContext context) {
    return           ListTile(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25)
      ),
      tileColor: light_dusty_rose,
      // trailing: ,
      title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [BulletoKilla(text: thisEvent!.eventName,),
            ScheduleFont(text: "On :   ${thisEvent!.eventDate!.year}/${thisEvent!.eventDate!.month}/${thisEvent!.eventDate!.day}        At ${thisEvent!.eventDate!.hour}:${thisEvent!.eventDate!.minute<10?"0${thisEvent!.eventDate!.minute}":thisEvent!.eventDate!.minute}")
          ]
      ),
    );
  }
}

class BulletoKilla extends StatelessWidget {
  final text;
  final color;
  const BulletoKilla({super.key, @required this.text,  this.color});

  @override
  Widget build(BuildContext context) {
    return   Text(text,style: TextStyle(fontFamily: "Bulletto Killa",fontSize: 25))
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
    else {
      isInvisible = false;
    }
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
            }, icon: const Icon(Icons.remove_red_eye,color: Colors.black,)):null,
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1,color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(10)
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1,color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(15)
            ),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1,color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(10)
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
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
          },
          child:    Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: const Color.fromRGBO(11, 13, 23, 1,),width: 1.5),
            ),
            child:      ListTile(
              trailing: IconButton(onPressed: (){
                Event? thisEvent = eventBox.getAt(eventIndex);
                thisEvent!.eventGuests.removeAt(index);
                eventBox.putAt(eventIndex, thisEvent);
              }, icon: const Icon(Icons.dangerous,color: Colors.red,)),
              title: Row(
                children: [
                  const SizedBox(width: 20,),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FrenchCannon(text: 'Name:'),
                      FrenchCannon(text: 'Contact:'),
                      FrenchCannon(text: 'No of Members:'),
                      FrenchCannon(text: 'Invitation:'),
                    ],
                  ),
                  const SizedBox(width: 20,),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FrenchCannon(text: name),
                      FrenchCannon(text: contact),
                      FrenchCannon(text: memberNo),
                      FrenchCannon(text: isInvited?'Invited':"Not Invited"),

                    ],
                  ),
                ],
              ),
            )  ,
          )
      );




  }
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
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: light_dusty_rose,
      splashColor: Colors.lightBlueAccent,
      child: Container(
        padding: EdgeInsets.zero,
          height: 65,
          width: 65,
          child:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(widget.tileIcon ,color: mainColor,size: 25,),
          FrenchCannon(text: widget.tileName,color: mainColor,size: 13.0,)
        ],
      )));
  }
}


void CommonAlert(BuildContext context,int eventIndex,String title,final provider){
  TextEditingController titleController =TextEditingController();
  showDialog(context: context, builder: (BuildContext context){
    return AlertDialog(
      title: SizedBox(
        width: 250,
        child: TextField(
          controller: titleController,
          focusNode: FocusNode(),
          decoration: InputDecoration(
              hintText:  title,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: const BorderSide(style: BorderStyle.solid,width: 1)
              )
          ),
        ),
      ),
      content: ElevatedButton(onPressed: (){
        if (title=="Budget"){
          provider.AddBudget(eventIndex,double.parse(titleController.text));
        }
        else if (title == "Expense"){
          provider.addExpense(double.parse(titleController.text), eventIndex);

        }
        else if (title=="Task"){
          provider.addTask(eventIndex,titleController.text);
        }
        Navigator.pop(context);
      }, child: const FrenchCannon(text:"Add")),
    );
  });
}

class BudgetTile extends StatelessWidget {
  final double value;
  const BudgetTile({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      height: 75,
      child:  FrenchCannon(
          text: "Budget: $value",
          size: 20.0,
          color: Colors.black,
          weight: FontWeight.bold,
        ),
    );
  }
}

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      onTap: (index) {},
      iconSize: 24.0,
      elevation: 20,
      backgroundColor: soft_blue_grey,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.celebration,color: mainColor,size: 24,),
          label: "Events",
          backgroundColor: mainColor,
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.money_dollar,color: mainColor,size: 24,),
          label: 'Budgets',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.task,color: mainColor,size: 24,),
          label: "Tasks",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people,color: mainColor,size: 24,),
          label: 'Guests',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings,color: mainColor,size: 24,),
          label: 'Settings',
        ),
      ],
    );
  }
}
class RemoveButton extends StatelessWidget {
  final VoidCallback onPressed;
  const RemoveButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(icon: const Icon(Icons.dangerous,color: Colors.red,),onPressed: onPressed);
    }
  }

