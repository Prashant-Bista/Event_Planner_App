import 'package:event_planner_app/pages/Budget/budget_track.dart';
import 'package:event_planner_app/pages/Events/event_page.dart';
import 'package:event_planner_app/pages/Guests/add_guests.dart';
import 'package:event_planner_app/pages/Todo/todo_view.dart';
import 'package:event_planner_app/pages/Login/login.dart';
import 'package:event_planner_app/pages/home_page.dart';
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
      final int args = int.parse(settings.arguments.toString());
      return MaterialPageRoute(builder: (_)=>TodoView(eventIndex: args,));
    }
    if (settings.name=='/guests'){
      final int args = int.parse(settings.arguments.toString());
      return MaterialPageRoute(builder: (_)=>AddGuests(eventIndex: args));
    }
    if (settings.name=='/event'){
      return MaterialPageRoute(builder: (_)=>EventPage());
    }
    if (settings.name=='/home'){
      final int args = int.parse(settings.arguments.toString());
      return MaterialPageRoute(builder: (_)=>HomePage(eventIndex:args ));
    }
    if (settings.name=='/budget'){
      final int args = int.parse(settings.arguments.toString());
      return MaterialPageRoute(builder: (_)=>BudgetTrack(eventIndex:args ));
    }
  }
}