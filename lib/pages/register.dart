import 'package:event_planner_app/services/authentication_service.dart';
import 'package:event_planner_app/services/database_service.dart';
import 'package:flutter/material.dart';

import '../components.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> registerkey = GlobalKey<FormState>();
  AuthenticationService _auth =  AuthenticationService();
  DatabaseService _db = DatabaseService();
  late String? uid;
  late String password;
  late String email;
  late String name;
  late String contact;
  @override
  Widget build(BuildContext context) {
    double _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: FrenchCannon(text: "Register"),
      ),
      body: Form(
        key: registerkey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InputField(
                width: _deviceWidth * 0.8,
                onSaved: (value) {
                  name = value;
                },
                prefixIcon: null,
                isObscure: false,
                validator: null,
                focusNode: null,
                hinttext: "Full name",
              ),
              SizedBox(height: 20,),
              InputField(
                width: _deviceWidth * 0.8,
                onSaved: (value) {
                  contact = value;
                },
                prefixIcon: null,
                isObscure: false,
                validator: (value){
                  if(!RegExp(r'^\+[1-9]\d{1,14}$',).hasMatch(value)){
                    return "Enter a valid Phone Number with country code";
                  }
                  return null;
                },
                focusNode: null,
                hinttext: "Phone Number",
              ),
              SizedBox(
                height: 20,
              ),
              InputField(
                width: _deviceWidth * 0.8,
                onSaved: (value) {
                  email = value;
                },
                prefixIcon: Icon(Icons.email),
                isObscure: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email cannot be empty";
                  } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return "Please enter a valid email address";
                  }
                  return null;
                },
                focusNode: null,
                hinttext: "Email",

              ),
              SizedBox(
                height: 20,
              ),

              InputField(
                width: _deviceWidth * 0.8,
                onSaved: (value) {
                  password = value;
                },
                prefixIcon: Icon(Icons.password),
                isObscure: true,
                focusNode: null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password cannot be empty";
                  } else if (value.length < 8) {
                    return "Password length should be >= 8";
                  } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
                    return "Please enter at least one uppercase letter [A-Z]";
                  } else if (!RegExp(r'\d').hasMatch(value)) {
                    return "Please enter at least one digit";
                  } else if (!RegExp(r'[!@#$%^&*()_+{}\[\]:;"\<>,.?~\\/-]')
                      .hasMatch(value)) {
                    return "Please enter at least one special character";
                  }
                  return null;
                },
                hinttext: "Password",
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                  minWidth: _deviceWidth / 1.5,
                  height: 50.0,
                  padding: const EdgeInsets.only(bottom: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: muave,
                  child: const FrenchCannon(
                    text: "Sign Up",
                    size: 23.0,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    if (registerkey.currentState!.validate()) {
                      registerkey.currentState!.save();
                      uid= await _auth.createUserWithEmailAndPassword(
                          context, email, password);
                      _db.createuser(context, uid!, name, email, contact);
                      Navigator.of(context).pushReplacementNamed("/login");
                    }
                    // }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
