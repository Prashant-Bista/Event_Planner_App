import 'dart:io';

import 'package:event_planner_app/pages/Budget/budget.dart';
import 'package:event_planner_app/pages/Events/event.dart';
import 'package:event_planner_app/pages/Events/event_page.dart';
import 'package:event_planner_app/pages/Guests/guests.dart';
import 'package:event_planner_app/pages/Schedule/schedule.dart';
import 'package:event_planner_app/pages/Todo/tasks.dart';
import 'package:event_planner_app/pages/Vendors/vendors.dart';
import 'package:flutter/material.dart';
import 'package:event_planner_app/routes.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';

void main() async{
  // GoogleFonts.config.allowRuntimeFetching=false;
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationCacheDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(TasksAdapter());
  Hive.registerAdapter(GuestsAdapter());
  Hive.registerAdapter(BudgetAdapter());
  Hive.registerAdapter(EventAdapter());
  Hive.registerAdapter(ExpensesAdapter());
  Hive.registerAdapter(VendorsAdapter());
  Hive.registerAdapter(ScheduleAdapter());

  if (!Hive.isBoxOpen('todo')) {
    await Hive.openBox<Tasks>('todo');
  }
  print(directory.path);

  if (!Hive.isBoxOpen('guests')) {
    await Hive.openBox<Guests>('guests');
  }
  if (!Hive.isBoxOpen('budget')) {
    await Hive.openBox<Budget>('budget');
  }
  if (!Hive.isBoxOpen('event')) {
    Box<Event> box =await Hive.openBox<Event>('event');
  }
  if (!Hive.isBoxOpen('expense')) {
    await Hive.openBox<Expenses>('expense');
  }
  if (!Hive.isBoxOpen('vendors')) {
    await Hive.openBox<Vendors>('vendors');
  }
  if (!Hive.isBoxOpen('schedule')) {
    await Hive.openBox<Schedule>('schedule');
  }
  runApp(const ProviderScope(child: MyApp()) );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
      ),
      home: const EventPage(),
      initialRoute: '/splash',
      onGenerateRoute: (settings)=>Routes.routeGenerator(settings),
    );
  }
}


