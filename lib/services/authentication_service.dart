import 'package:event_planner_app/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:event_planner_app/components.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../pages/login.dart';

class AuthenticationService {
  late FirebaseAuth auth;
  late DatabaseService _db;
  AuthenticationService(){
    auth = FirebaseAuth.instance;
    _db = DatabaseService();
    auth.authStateChanges().listen((user){
      if(auth.currentUser!=null){
          print("id ${auth.currentUser!.uid}");
      print("email ${auth.currentUser!.email}");

      _db.eventRefresh();
      }
    });
  }
  Future<void> loginWithEmailAndPassword(BuildContext context,String email,String password)async{
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password);
      _db.eventRefresh();
      Navigator.of(context).pushReplacementNamed("/event");
    }on FirebaseAuthException{
      alertMessages(context: context, message: "Please Check connection or enter the correct credentials");
    }
  }
  Future<String?> createUserWithEmailAndPassword(BuildContext context,String email,String password)async{
    try{
      UserCredential credential= await auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user!.uid;
    }catch(e){
      alertMessages(context: context, message:e.toString());
    }
  }

    Future<void> signOut(BuildContext context) async {
    showDialog(context: context, builder: (_){
      return AlertDialog(
        title: Text("Logout"),
        content: Text("Are you sure?"),
        actions: [ElevatedButton(child:Text("Yes") ,onPressed:()async{
          if (auth.currentUser!=null){
            await auth.signOut();
          }
          Navigator.of(context).pushReplacementNamed("/login");
        } ,)],
      );
    });

      Navigator.pushReplacementNamed(context, '/login');
    }
  }
