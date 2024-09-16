import 'package:event_planner_app/pages/Guests/add_guests.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../../components.dart';
import 'budget.dart';
class BudgetTrack extends StatefulWidget {
  final int eventIndex;
  const BudgetTrack({super.key, required this.eventIndex});

  @override
  State<BudgetTrack> createState() => _BudgetTrackState();
}

class _BudgetTrackState extends State<BudgetTrack> {
  // Box<Budget> budget = Hive.box<Budget>('budget');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white ,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: Manrope(text:"Guest Manaement", color: Colors.white,),
        elevation: 20.0,
        shadowColor: Colors.grey,
      ),
      body: null

    );
  }
}
