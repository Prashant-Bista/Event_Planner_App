import 'package:event_planner_app/components.dart';
import 'package:event_planner_app/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

class Login extends StatefulWidget {

  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final AuthenticationService _auth= AuthenticationService();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
   bool guestLogin=false;
  late double widthDevice;
  late String email;
  late String password;
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    widthDevice= MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            Form(
                key:loginFormKey,
                child: Column(
                  children: [
                    InputField(
                        focusNode:emailFocusNode,
                        width: widthDevice/1.5,
                        onSaved: (value){
                      email=value;
                    }, prefixIcon: const Icon(Icons.email,color: Colors.black,), isObscure: false, hinttext: "Enter your Email", validator: null,),
                    const SizedBox(height: 20,),
                    InputField(
                      focusNode: passwordFocusNode,
                      width: widthDevice/1.5, onSaved: (value){
                      password=value;
                    }, prefixIcon: const Icon(Icons.password,color: Colors.black,), isObscure: true, hinttext: "Enter your Password", validator: null,),
                    const SizedBox(height: 20.0,),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     // ),
                    //     SizedBox(width: widthDevice/6.0,)
                    //   ],
                    // ),
                    MaterialButton(
                        minWidth: widthDevice/1.5,
                        height: 50.0,
                        padding: const EdgeInsets.only( bottom: 10.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.black,
                        child:const FrenchCannon(text: "Sign In", size: 23.0,color: Colors.white,),
                        onPressed: (){
                          if(loginFormKey.currentState!.validate()){
                            loginFormKey.currentState!.save();
                            _auth.loginWithEmailAndPassword(context, email, password);

                          }
                          // }
                        }),
                    const SizedBox(
                      height: 20.0,
                    ),

                    MaterialButton(
                        minWidth: widthDevice*0.50,
                        height: 30.0,
                        padding: const EdgeInsets.only( bottom: 10.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: Colors.deepPurple,
                        child:const FrenchCannon(text: "Guest Login ", size: 20.0,color: Colors.white,),
                        onPressed: (){
                          guestLogin = true;
                          Navigator.of(context).popAndPushNamed('/event');
                          // }
                        }),
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
                    SignInButton(buttonType: ButtonType.google, onPressed: (){
                    },),
                    const SizedBox(height: 10,),
                    InkWell(child: const FrenchCannon(text: "Create an Account",),onTap:()=>Navigator.of(context).pushNamed("/register")),

                  ],
                ),)
          ],
        ),
      ),
    );
  }
}
