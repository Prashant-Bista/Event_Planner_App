import 'package:event_planner_app/pages/components.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    double widthDevice = MediaQuery.of(context).size.width;
    double heightDevice = MediaQuery.of(context).size.height;
    String _email;
    String _password;
    bool remember=false;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 75,
              child: Image.asset('assets/images/EventAppCircle.png',filterQuality: FilterQuality.high,),

            ),
            SizedBox(height: 20,),
            Manrope(text: "Welcome!",size: 32.0,weight: FontWeight.bold,),
            SizedBox(height: 20,),
            Form(child: Container(

              child: Column(
                children: [

                  InputField(width: widthDevice/1.5, onSaved: (value){}, prefixIcon: Icon(Icons.email,color: Colors.black,), isObscure: false, hinttext: "Enter your Email", validator: (value){
                    if (value.toString().length<1){
                      return "Email is required";
                    }
                    else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.toString())) {
                      return "Please enter a valid email address";
                    }
                    else
                      return null;
                  }),
                  SizedBox(height: 20,),
                  InputField(width: widthDevice/1.5, onSaved: (value){
                    _password=value.toString();
                  }, prefixIcon: Icon(Icons.password,color: Colors.black,), isObscure: true, hinttext: "Enter your Password", validator: (value) {
                  if (value == null || value.isEmpty) {
                  return "Password cannot be empty";
                  } else if (value.length < 8) {
                  return "Password length should be >= 8";
                  } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
                  return "Please enter at least one uppercase letter [A-Z]";
                  } else if (!RegExp(r'\d').hasMatch(value)) {
                  return "Please enter at least one digit";
                  } else if (!RegExp(r'[!@#$%^&*()_+{}\[\]:;"\<>,.?~\\/-]').hasMatch(value)) {
                  return "Please enter at least one special character";
                  }
                  return null;
                },),
               SizedBox(height: 20,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   TextButton(onPressed: (){}, child:Manrope(text: "Forgot Password",color: Colors.blue,),
                   ),
                   SizedBox(width: widthDevice/6,)
                 ],
               ),
               MaterialButton(
                 minWidth: widthDevice/1.5,
                 height: 50,
                 padding: EdgeInsets.all(20),
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(10),
                   ),
                   color: Colors.black,
                   child:Manrope(text: "Sign In", size: 32,color: Colors.white,)
                   ,
                   onPressed: (){}),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: widthDevice/6,),
                  Checkbox(
                    checkColor: Colors.grey,
                  value: remember,
                  onChanged: (bool? value) {
               setState() {
            remember = value!;
                };}),
                    SizedBox(width: 10.0),
                    Manrope(text: "Remember me on this device",)
                  ],
                ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 2,
                        color: Colors.black,
                        width: widthDevice/4.0,
                      ),
                      Text('  OR  '),
                      Container(
                        height: 2,
                        color: Colors.black,
                        width: widthDevice/4.0,
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Container(child: SignInButton(buttonType: ButtonType.google, onPressed: (){},),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                      border: Border.all(width: 2,color: Colors.black)
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Manrope(text: "Don't have an account",)

                      
                    ],
                  )
                  

                    ],


              ),
            ))
          ],
        ),
      ),
    );
  }
}
