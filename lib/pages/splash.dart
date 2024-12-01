import 'package:flutter/material.dart';
class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((_)=>Navigator.pushReplacementNamed(context,"/login"));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(11, 13, 26, 1),
      body: Center(child: Image.asset("assets/images/EventAppCircle.png",filterQuality: FilterQuality.high,fit: BoxFit.contain,alignment: Alignment.center,))
    );
  }
}
