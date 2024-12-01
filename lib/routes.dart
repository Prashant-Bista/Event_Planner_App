import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planner_app/pages/Budget/budget_track.dart';
import 'package:event_planner_app/pages/Events/event_page.dart';
import 'package:event_planner_app/pages/Guests/add_guests.dart';
import 'package:event_planner_app/pages/Schedule/schedule_view.dart';
import 'package:event_planner_app/pages/Todo/todo_view.dart';
import 'package:event_planner_app/pages/Login/login.dart';
import 'package:event_planner_app/pages/Vendors/vendors_view.dart';
import 'package:event_planner_app/pages/Venue/single_venue_view.dart';
import 'package:event_planner_app/pages/Venue/venueList_view.dart';
import 'package:event_planner_app/pages/contact.dart';
import 'package:event_planner_app/pages/home_page.dart';
import 'package:event_planner_app/pages/splash.dart';
import 'package:flutter/material.dart';

class Routes{
  static Route<dynamic>? routeGenerator (RouteSettings settings){
    if (settings.name=='/splash'){
      return MaterialPageRoute(builder: (context)=>const Splash());
    }
    if (settings.name=='/login'){
      return MaterialPageRoute(builder: (_)=>const Login());
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
      return MaterialPageRoute(builder: (_)=> EventPage());
    }
    if (settings.name=='/home'){
      final int args = int.parse(settings.arguments.toString());
      return MaterialPageRoute(builder: (_)=>HomePage(eventIndex:args ));
    }
    if (settings.name=='/budget'){
      final int args = int.parse(settings.arguments.toString());
      return MaterialPageRoute(builder: (_)=>BudgetTrack(eventIndex:args ));
    }
    if (settings.name=='/vendors'){
      final int args = int.parse(settings.arguments.toString());
      return MaterialPageRoute(builder: (_)=>VendorsView(eventIndex: args));
    }
    if (settings.name=='/schedule'){
      final int args = int.parse(settings.arguments.toString());
      return MaterialPageRoute(builder: (_)=>ScheduleView(eventIndex: args));
    }
    if (settings.name=='/venue'){
      final int args = int.parse(settings.arguments.toString());
      return MaterialPageRoute(builder: (_)=>VenueView(eventIndex: args,));
    }
    if (settings.name=='/singlevenue'){
      final DocumentSnapshot args = settings.arguments as DocumentSnapshot;
      return MaterialPageRoute(builder: (_)=>SingleVenueView(document: args));
    }
    return null;
  }
}