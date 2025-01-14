import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:event_planner_app/components.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthenticationService {
  late FirebaseAuth auth;
  AuthenticationService(){
    auth = FirebaseAuth.instance;
    auth.authStateChanges().listen((user){

    });
  }
  Future<void> loginWithEmailAndPassword(BuildContext context,String email,String password)async{
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context).pushReplacementNamed("/event");
    }on FirebaseAuthException{
      alertMessages(context: context, message: "Please Check connection or enter the correct credentials");
    }
  }
  Future<void> createUserWithEmailAndPassword(BuildContext context,String email,String password)async{
    try{
      await auth.createUserWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException{
      alertMessages(context: context, message: "Please Check connection or enter the correct credentials");
    }
  }

}