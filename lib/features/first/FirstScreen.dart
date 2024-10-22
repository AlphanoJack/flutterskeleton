import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  static const String name = 'FirstScreen';
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alert Screen'),
      ),
      body: Column(
        children: [
          Text("알람 표기 ")
        ],
      )
    );
  }
}
