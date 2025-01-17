
import 'package:event_planner_app/pages/Budget/budget.dart';
import 'package:event_planner_app/pages/Events/event.dart';
import 'package:event_planner_app/pages/Guests/guests.dart';
import 'package:event_planner_app/pages/Vendors/vendors.dart';
import 'package:event_planner_app/pages/Venue/venue_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:event_planner_app/business_logic.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

Color lightPurple= const Color(0xff45267ff);
TextEditingController valueController =TextEditingController();
Color mainColor = const Color.fromRGBO(11, 14, 28, 1);
Color muave = const Color.fromRGBO(199, 124, 124, 1.0);
Color dustyRose = const Color.fromRGBO(242, 202, 198, 1.0);
Color darkDustyRose = const Color.fromRGBO(244, 175, 168, 1.0);

Color lightDustyRose = const Color.fromRGBO(242, 223, 223, 1.0);

Color softBlueGrey = const Color.fromRGBO(206, 230, 242, 1);

class FrenchCannon extends StatelessWidget {
  final text;
  final size;
  final weight;
  final color;
  const FrenchCannon({super.key, @required this.text,  this.size, this.weight,  this.color});

  @override
  Widget build(BuildContext context) {
    return   Text(text,style: TextStyle(fontFamily: "FrenchCannon",fontSize: size,color: color,fontWeight: weight))
    ;
  }
}

class EventTile extends ConsumerWidget {
  final int index;
  final bool isHome;
  final int eventIndex;
  final VoidCallback onPressed;
  final bool isUpdate;
  final bool isSchedule;
  const EventTile({super.key,required this.index, required this.eventIndex,required this.isHome,required this.onPressed,required this.isUpdate,required this.isSchedule});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final provider=ref.watch(stateProvider);
    Box<Event> eventBox = Hive.box('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    return
     ListTile(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25)
      ),
      tileColor: lightDustyRose,
      // trailing: ,
      title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [ isSchedule
      ? FrenchCannon(text: thisEvent!.eventSchedule[index].title)
             :         BulletoKilla(text: thisEvent!.eventName,size: 25.0,),
    FrenchCannon(
    text: isSchedule && index < thisEvent.eventSchedule.length
    ? "Time remaining: ${provider.timeRemaining(thisEvent.eventSchedule[index].completeWithin)}"
        : "On :   ${thisEvent.eventDate!.year}/${thisEvent.eventDate!.month}/${thisEvent.eventDate!.day}        At ${thisEvent.eventDate!.hour}:${thisEvent.eventDate!.minute < 10 ? "0${thisEvent.eventDate!.minute}" : thisEvent.eventDate!.minute}",
    size: 13.0,)]
      ),
      trailing: isHome?null:RemoveButton(onPressed: (){
       if (isSchedule){
         provider.removeSchedule(index, eventIndex);
       }
       else{
provider.removeEvent(eventIndex);

       }}),
      )
         ;
      }
  }


class BulletoKilla extends StatelessWidget {
  final text;
  final color;
  final size;
  const BulletoKilla({super.key, @required this.text,  this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return   Text(text,style: TextStyle(fontFamily: "Bulletto Killa",fontSize: size),maxLines: 2,)
    ;
  }
}



class InputField extends StatefulWidget {
  final double width;
  final  onSaved;
  final prefixIcon;
  final bool isObscure;
  final String hinttext;
  final validator;
  final focusNode;
  const InputField({super.key, required this.width, required this.onSaved, required this.prefixIcon, required this.isObscure, required this.hinttext, required this.validator, this.focusNode});

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
    return SizedBox(
      width: widget.width,
      child: TextFormField(
        focusNode: widget.focusNode,
        obscureText: isInvisible,
        onSaved: widget.onSaved,
        validator: widget.validator,
        decoration: InputDecoration(
          fillColor: Colors.grey,
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
      color: lightDustyRose,
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


void commonAlert(BuildContext context,int eventIndex,String title,final provider){
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
          provider.addBudget(eventIndex,double.parse(titleController.text));
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
          text: "Budget:  Rs. $value",
          size: 20.0,
          color: Colors.black,
          weight: FontWeight.bold,
        ),
    );
  }
}

class BottomBar extends StatelessWidget {
  final int eventIndex;
  const BottomBar({super.key, required this.eventIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      onTap: (index) {
        if (index==0){
          Navigator.of(context).popAndPushNamed('/home',arguments: eventIndex);
        }
        else if (index==1){
          Navigator.of(context).popAndPushNamed('/event',arguments:eventIndex );
        }else if (index==2){
          Navigator.of(context).popAndPushNamed('/budget',arguments:eventIndex);
        }else if (index==3){
          Navigator.of(context).popAndPushNamed('/guests',arguments:eventIndex);
        }

      },
      iconSize: 24.0,
      elevation: 20,
      backgroundColor: softBlueGrey,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home,color: mainColor,size: 24,),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.celebration,color: mainColor,size: 24,),
          label: "Events",
          backgroundColor: mainColor,
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.money_dollar_circle_fill,color: mainColor,size: 24,),
          label: 'Budgets',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people,color: mainColor,size: 24,),
          label: 'Guests',
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
class GuestAlert extends ConsumerWidget {
  final int eventIndex;
  final bool isUpdate;
  final int? itemIndex;
  final bool isVendor;
  const GuestAlert ( {super.key, required this.eventIndex,required this.isUpdate,required this.itemIndex,required this.isVendor,});
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final provider = ref.watch(stateProvider);
    Box<Event> eventBox = Hive.box("event");
    TextEditingController nameController = TextEditingController();
    TextEditingController contactController = TextEditingController();
    TextEditingController membersController = TextEditingController();
    bool isInvited = false;

    return StatefulBuilder(
      builder: (context, setState) {
        late Vendors currentVendor;
        late Guests currentGuest;
        if(isUpdate) {
          if (isVendor) {
             currentVendor = eventBox.getAt(eventIndex)!
                .eventVendors[itemIndex!];
            nameController.text = currentVendor.name!;
            contactController.text = currentVendor.contact!;
            membersController.text = currentVendor.price.toString();
            isInvited = currentVendor.isBooked!;
          }
          else{
             currentGuest=eventBox.getAt(eventIndex)!.eventGuests[itemIndex!];
            nameController.text= currentGuest.guestName;
            contactController.text= currentGuest.contact;
            membersController.text= currentGuest.membersNo.toString();
            isInvited = currentGuest.invited;
          }
        }
        return AlertDialog(
          title: SizedBox(
            width: 250,
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: isVendor?"Vendor's Type":"Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                      borderSide: const BorderSide(
                          style: BorderStyle.solid, width: 1),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: contactController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: "Contact No",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                      borderSide: const BorderSide(
                          style: BorderStyle.solid, width: 1),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: membersController,
                  decoration: InputDecoration(
                    hintText: isVendor?"Price":"No of Members",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                      borderSide: const BorderSide(
                          style: BorderStyle.solid, width: 1),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                  ),
                  tileColor: dustyRose,
                  trailing: Checkbox(
                    value: isInvited,
                    onChanged: (bool? value) {
                        setState((){
        isInvited = value!;
        if (isUpdate){
        if (isVendor){
          provider.updateVendors(
              eventIndex, itemIndex!, currentVendor.name!,
              currentVendor.price!, isInvited,
              currentVendor.contact!);
        }
        else
        provider.updateGuest(
        eventIndex, itemIndex!, currentGuest.guestName,
        currentGuest.membersNo, isInvited,
        currentGuest.contact);
        }
                        }
        );}
                     ),
                  title: const Text("Invited"),
                ),
              ],
            ),
          ),
          content: ElevatedButton(
              onPressed: () {
                if (isUpdate) {
                  if (isVendor) {
                    provider.updateVendors(
                        eventIndex, itemIndex!, nameController.text,
                        int.parse(membersController.text), isInvited,
                        contactController.text);
                  }
                  else
                    provider.updateGuest(
                        eventIndex, itemIndex!, nameController.text,
                        int.parse(membersController.text), isInvited,
                        contactController.text);
                }
                else {
                  if (isVendor) {

                    provider.addVendors(eventIndex, nameController.text, contactController.text, isInvited, int.parse(membersController.text));
                  }
                    else
                  provider.addGuest(eventIndex, nameController.text,
                      int.parse(membersController.text), isInvited,
                      contactController.text);
                  Navigator.pop(context);
                }
              },
              child: isUpdate ? const Text("Update") : const Text("Add")
          ),
        );
      },
    );
  }
  }
class CommonFilledWindow extends ConsumerWidget {
  final Event thisEvent;
  final int eventIndex;
  final bool isGuest;
  const CommonFilledWindow({super.key, required this.thisEvent, required this.isGuest,required this.eventIndex,});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final provider = ref.watch(stateProvider);
    double widthDevice = MediaQuery.of(context).size.width;
    bool? isInvited;
    return  Column(
      children: [Container(
        alignment: Alignment.center,
        height:50,
        width: widthDevice,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
        ),
        child: isGuest?FrenchCannon(text: "Total Guests: ${thisEvent.guestsCount}"):FrenchCannon(text: "Total Vendors: ${thisEvent.vendorsCount}"),
      ),
        Container(
          height: 550,
          width: widthDevice/1.05,
          decoration: BoxDecoration(
              border: Border.all(style: BorderStyle.solid,color: darkDustyRose,width: 2),
              borderRadius: BorderRadius.circular(5)
          ),
          child: ListView.builder(
            itemCount: isGuest?thisEvent.eventGuests.length:thisEvent.eventVendors.length,
            itemBuilder: (context, index) {
              late Guests guest;
              late Vendors vendor;
              if (isGuest)
                guest= thisEvent.eventGuests[index];
              else
                 vendor = thisEvent.eventVendors[index];

              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: GestureDetector(
                    onTap: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          if (isGuest)
                          return GuestAlert(isUpdate: true, eventIndex: eventIndex,itemIndex: index,isVendor: false,);
                          else
                            return GuestAlert(eventIndex: eventIndex, isUpdate: true, itemIndex: index, isVendor: true);
                        },
                      );
                    },
                    child:    Container(
                      height: 110,
                      decoration: BoxDecoration(
                        color: lightDustyRose,
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child:      ListTile(
                        trailing: RemoveButton(onPressed: (){
                          if (isGuest){
                            provider.removeGuest(eventIndex, index);
                          }
                          else{
                            provider.removeVendor(eventIndex, index);
                          }
                        },),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 20,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FrenchCannon(text: isGuest?'Name:':"Vendor",size: 13.0,),
                                const FrenchCannon(text: 'Contact:',size: 13.0),
                                FrenchCannon(text: isGuest?'No of Members:':"Price",size: 13.0),
                                FrenchCannon(text: isGuest?'Invitation:':"Booked",size: 13.0),
                              ],
                            ),
                            const SizedBox(width: 20,),

                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FrenchCannon(text: isGuest?guest.guestName:vendor.name,size: 13.0),
                                FrenchCannon(text: isGuest?guest.contact:vendor.contact,size: 13.0),
                                FrenchCannon(text: isGuest?'${guest.membersNo}':'${vendor.price}',size: 13.0),
                                StatefulBuilder(builder: (context,setState){
                                  return Checkbox(
                                    value: isGuest?thisEvent.eventGuests[index].invited:thisEvent.eventVendors[index].isBooked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isInvited = value!;
                                        if (isGuest)
                                          provider.updateGuest(eventIndex, index, thisEvent.eventGuests[index].guestName, thisEvent.eventGuests[index].membersNo, isInvited!, thisEvent.eventGuests[index].contact);
                                        else
                                          provider.updateVendors(eventIndex, index, thisEvent.eventVendors[index].name!, thisEvent.eventVendors[index].price!, isInvited!, thisEvent.eventVendors[index].contact!);

                                      });
                                    },
                                  );

                                })


                              ],
                            ),
                          ],
                        ),
                      )  ,
                    )
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class EventAlert extends ConsumerWidget {
  final int? eventIndex;
  final bool isSchedule;
  final bool isUpdate;
  final int? itemIndex;
  const EventAlert ( {super.key, this.eventIndex,required this.isUpdate,required this.isSchedule, this.itemIndex});
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final provider = ref.watch(stateProvider);
    double deviceWidth=MediaQuery.of(context).size.width;
    Box<Event> eventBox= Hive.box("event");
    Event? thisEvent;
    if(eventIndex!=null){
      thisEvent = eventBox.getAt(eventIndex!);
    }
    TextEditingController nameController = TextEditingController();
    DateTime? picked;
    if(isUpdate) {
      if (isSchedule) {
        nameController.text = thisEvent!.eventSchedule[itemIndex!].title;
        picked = thisEvent.eventSchedule[itemIndex!].completeWithin;
      }
    }
    return StatefulBuilder(
      builder: (BuildContext context,StateSetter setState){
        return AlertDialog(
          title: SizedBox(
            width: 500,
            child: Column(
              children: [
                TextField(

                  textAlign: TextAlign.center,
                  focusNode: FocusNode(),

                  controller: nameController,
                  decoration: InputDecoration(
                      hintStyle: const TextStyle(fontSize: 13,fontFamily: "FrenchCannon"),
                      hintText:  isSchedule?"Task":"Name of Event",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                          borderSide: BorderSide(style: BorderStyle.solid,width: 1,color: lightPurple)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                          borderSide: BorderSide(style: BorderStyle.solid,width: 1,color: lightPurple)
                      )
                  ),
                ),
                const SizedBox(height: 10,),
                FrenchCannon(text: isSchedule?"Deadline: ":"Date Time",size: 13.0,weight: FontWeight.bold,),
                const SizedBox(height: 10,),

                SizedBox(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Container(
                          width: deviceWidth/2.1,
                          decoration:BoxDecoration(
                              border: Border.all(width: 1,color: lightPurple)
                          ),child: Center(child: FrenchCannon(size:13.0,text: picked==null?"Not selected": DateFormat('yyyy/MM/dd/hh:mm a').format(picked!),))),
                      IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.date_range,color:Color(0xff45267ff),size: 25,),
                          onPressed: () async{

                              final DateTime? selectedDate =  await showDatePicker(context: context, firstDate: DateTime(2000,1,1), lastDate: DateTime(2100,1,1),initialDate: DateTime.now(),);
                              if (selectedDate==null){
                                return;
                              }
                              final TimeOfDay? selectedTime =  await showTimePicker(context: context, initialTime: TimeOfDay.now() );
                              if (selectedTime==null){
                                return;
                              }
                              setState(() {
                                picked =DateTime(selectedDate.year,selectedDate.month,selectedDate.day,selectedTime.hour,selectedTime.minute);
                              });
                            }
                      ),
                    ],
                  ),
                )


              ],
            ),
          ),
          content: ElevatedButton(onPressed: (){
            if(isUpdate){
              if (isSchedule){
                provider.updateSchedule(itemIndex!, eventIndex!, nameController.text, picked);
                provider.sortSchedule(eventIndex!);
              }
            }
            else{
              if (isSchedule){
                provider.addSchedule( eventIndex!, nameController.text, picked);
                provider.sortSchedule(eventIndex!);
              }
              else{
                eventBox.add(Event(eventBudget:Budget(budget: 0, isSet: false), eventExpenses: [], eventGuests: [], eventTasks: [], eventName: nameController.text, eventDate: picked, eventVendors: [], vendorsCount: 0, guestsCount: 0,eventSchedule: [],eventVenue: Venue(selectedDocumentIndex: null,venueCost: 0),predictedBudget: null));
              }
            }
            Navigator.pop(context);
          }, child: isUpdate?const FrenchCannon(text: "Update"): const FrenchCannon(text: "Add")),
        );},
    );
  }
  }
void alertMessages({required BuildContext context,required String message}){
   showDialog(context: context, builder: (_)=>AlertDialog(
     title: const Text("Error"),
     content: Text(message),
     actions: [TextButton(onPressed: (){Navigator.of(context).pop();}, child: const Text("Ok"))],
   ));
}
Widget PredictionRow(var provider,int eventIndex){
  Box<Event> eventBox = Hive.box<Event>('event');
  Event? thisEvent =eventBox.getAt(eventIndex);
  return Row(
    children: [Text("Predicted Budget:  Rs. ",style: TextStyle(color:mainColor,fontFamily: "FrenchCannon")),thisEvent!.predictedBudget==0?const SizedBox(width: 100,):FrenchCannon(text: thisEvent.predictedBudget.toString()),IconButton(onPressed: (){
      provider.predictBudget(eventIndex);

    }, icon: const Icon(Icons.refresh))],
  );
}



