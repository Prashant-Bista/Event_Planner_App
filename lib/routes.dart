import 'package:event_planner_app/pages/login.dart';
import 'package:event_planner_app/pages/splash.dart';
import 'package:flutter/material.dart';

class Routes{
  static Route<dynamic>? routeGenerator (RouteSettings settings){
    if (settings.name=='/splash'){
      return MaterialPageRoute(builder: (context)=>Splash());
    }
    if (settings.name=='/login'){
      return MaterialPageRoute(builder: (_)=>Login());
    }
  }
}