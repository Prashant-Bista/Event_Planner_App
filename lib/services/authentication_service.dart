import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:event_planner_app/components.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  Future<String?> createUserWithEmailAndPassword(BuildContext context,String email,String password)async{
    try{
      UserCredential credential= await auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user!.uid;
    }catch(e){
      alertMessages(context: context, message:e.toString());
    }
  }
  // Future<void>signinWithGoogleWeb(BuildContext context)async{
  //   final GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
  //   auth.signInWithPopup(googleAuthProvider);
  // }
  // Future<void> signInWithGoogleMobile(BuildContext context)async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //     final GoogleSignInAuthentication? googleAtuth = await googleUser
  //         ?.authentication;
  //     final credentails = GoogleAuthProvider.credential(
  //         accessToken: googleAtuth?.accessToken, idToken: googleAtuth?.idToken);
  //     auth.signInWithCredential(credentails);
  //   } catch (e) {
  //     alertMessages(context: context, message: e.toString());
  //   }
  // }
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
