import 'dart:io';

import 'package:event_planner_app/pages/Todo/tasks.dart';
import 'package:flutter/material.dart';
import 'package:event_planner_app/routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async{
  GoogleFonts.config.allowRuntimeFetching=false;
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationCacheDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(TasksAdapter());
  await Hive.openBox<Tasks>('todo');
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
      initialRoute: '/splash',
      onGenerateRoute: (settings)=>Routes.routeGenerator(settings),
    );
  }
}


