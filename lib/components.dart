import 'package:event_planner_app/pages/Guests/guests.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';


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

  const GuestList({super.key, required this.contact, required this.memberNo, required this.name, required this.isInvited});

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
          onTap: (){
            GuestAlert(context);
          },
          child:    Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            height: 110,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Color.fromRGBO(11, 13, 23, 1,),width: 1.5),
            ),
            child:      Row(
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
                    Manrope(text: '${name}'),
                    Manrope(text: '${contact}'),
                    Manrope(text: '${memberNo}'),
                    Manrope(text: isInvited?'Invited':"Not Invited"),

                  ],
                ),
              ],
            )  ,
          )
      );




  }
}

void GuestAlert(BuildContext context){
  Box<Guests> guest= Hive.box<Guests>('guests');
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController membersController = TextEditingController();
  TextEditingController inviteController = TextEditingController();
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: SizedBox(
          width: 250,
          child: Column(
            children: [
              TextField(
                controller: nameController,
                focusNode: FocusNode(),
                decoration: InputDecoration(
                    hintText:  "Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(style: BorderStyle.solid,width: 1)
                    )
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: contactController,
                focusNode: FocusNode(),
                decoration: InputDecoration(
                    hintText:  "Contact No",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(style: BorderStyle.solid,width: 1)
                    )
                ),
              ),
              SizedBox(height: 20,),

              TextField(
                controller: membersController,
                focusNode: FocusNode(),
                decoration: InputDecoration(
                    hintText:  "No of Members",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(style: BorderStyle.solid,width: 1)
                    )
                ),
              ),
              SizedBox(height: 20,),

              TextField(
                controller: inviteController,
                focusNode: FocusNode(),
                decoration: InputDecoration(
                    hintText:  "Invitation",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(style: BorderStyle.solid,width: 1)
                    )
                ),
              ),
              SizedBox(height: 20,),

            ],
          ),
        ),

        content: ElevatedButton(onPressed: (){
          if (nameController.text in guest)
        }, child: Manrope(text: "Add")),
      );
    });
  }

