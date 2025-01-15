import 'package:event_planner_app/services/authentication_service.dart';
import 'package:flutter/material.dart';

import '../components.dart';

class Register extends StatefulWidget {

  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> registerkey = GlobalKey<FormState>();
  AuthenticationService _auth = new AuthenticationService();
  late String password;
  late String email;
  @override
  Widget build(BuildContext context) {
    double _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text("Register"),),
      body: Form(
        child: Column(
          children: [InputField(
            width: _deviceWidth*0.8,
            onSaved: (value){
              email= value;
            },
            prefixIcon: Icon(Icons.email),
            isObscure: false,
            suffixIcon: null,
            validator: null,
            focusNode: null,
            hinttext: "Enter a Valid Email",

          ),
            SizedBox(height: 20,),
            InputField(
              width: _deviceWidth*0.8,
              onSaved: (value){
                email= value;
              },
              prefixIcon: Icon(Icons.email),
              isObscure: false,
              suffixIcon: null,
              validator: null,
              focusNode: null,
              hinttext: "Enter a Valid Email",

            ),
            SizedBox(height: 20,),
            MaterialButton(
                minWidth: _deviceWidth/1.5,
                height: 50.0,
                padding: const EdgeInsets.only( bottom: 10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.black,
                child:const FrenchCannon(text: "Sign In", size: 23.0,color: Colors.white,),
                onPressed: (){
                  if(registerkey.currentState!.validate()){
                    registerkey.currentState!.save();
                    _auth.createUserWithEmailAndPassword(context, email, password);

                  }
                  // }
                })
          ],      ),
      ),
    );
  }
}
