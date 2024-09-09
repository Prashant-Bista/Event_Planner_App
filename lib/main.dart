import 'package:flutter/material.dart';
import 'package:event_planner_app/routes.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  GoogleFonts.config.allowRuntimeFetching=false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
      ),
      home: Scaffold(),
      initialRoute: '/login',
      onGenerateRoute: (settings)=>Routes.routeGenerator(settings),
    );
  }
}


