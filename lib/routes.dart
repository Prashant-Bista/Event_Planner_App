import 'package:event_planner_app/pages/Guests/add_guests.dart';
import 'package:event_planner_app/pages/Todo/todo_view.dart';
import 'package:event_planner_app/pages/Login/login.dart';
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

    if (settings.name=='/todo'){
      return MaterialPageRoute(builder: (_)=>TodoView());
    }
    if (settings.name=='/guests'){
      return MaterialPageRoute(builder: (_)=>AddGuests());
    }
  }
}