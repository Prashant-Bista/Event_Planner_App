import 'package:event_planner_app/components.dart';
import 'package:flutter/material.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    double widthDevice = MediaQuery.of(context).size.width;
    double heightDevice = MediaQuery.of(context).size.height;
    String email;
    String password;
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
            const SizedBox(height: 20.0,),
            const FrenchCannon(text: "Welcome!",size: 32.0,weight: FontWeight.bold,),
            const SizedBox(height: 20.0,),
            Form(child: Container(

              child: Column(
                children: [

                  InputField(width: widthDevice/1.5, onSaved: (value){}, prefixIcon: const Icon(Icons.email,color: Colors.black,), isObscure: false, hinttext: "Enter your Email", validator: (value){
                    if (value.toString().isEmpty){
                      return "Email is required";
                    }
                    else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.toString())) {
                      return "Please enter a valid email address";
                    }
                    else
                      return null;
                  }),
                  const SizedBox(height: 20,),
                  InputField(width: widthDevice/1.5, onSaved: (value){
                    password=value.toString();
                  }, prefixIcon: const Icon(Icons.password,color: Colors.black,), isObscure: true, hinttext: "Enter your Password", validator: (value) {
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
               const SizedBox(height: 20.0,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   TextButton(onPressed: (){}, child:const FrenchCannon(text: "Forgot Password",color: Colors.blue,),
                   ),
                   SizedBox(width: widthDevice/6.0,)
                 ],
               ),
               MaterialButton(
                 minWidth: widthDevice/1.5,
                 height: 50.0,
                 padding: const EdgeInsets.all(20.0),
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(10.0),
                   ),
                   color: Colors.black,
                   child:const FrenchCannon(text: "Sign In", size: 23.0,color: Colors.white,)
                   ,
                   onPressed: (){
                   Navigator.of(context).pushNamed('/event');

                   }),
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
                }}),
                     SizedBox(width: 10.0),
                     FrenchCannon(text: "Remember me on this device",color:Colors.white, size: 12.0,)
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
                      const Text('  OR  '),
                      Container(
                        height: 2,
                        color: Colors.black,
                        width: widthDevice/4.0,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Container(decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                      border: Border.all(width: 2,color: Colors.black)
                    ),child: SignInButton(buttonType: ButtonType.google, onPressed: (){},),
                  ),
                  const SizedBox(height: 10,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FrenchCannon(text: "Don't have an account",)
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
