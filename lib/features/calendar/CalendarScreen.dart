import 'package:flutter/material.dart';
import 'package:skeleton/features/calendar/widgets/CalendarWidget.dart';

class CalendarScreen extends StatelessWidget {
  static const String name = 'CalendarScreen';
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const CalendarWidget(),
    );
  }
}
