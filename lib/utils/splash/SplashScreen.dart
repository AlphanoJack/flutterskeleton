import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  static const String name = 'SplashScreen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Map<String, dynamic> _splashConfig = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> _loadSplashConfig() async {
    final String configString =
        await rootBundle.loadString('assets/splash/splash.json');
    setState(() {
      _splashConfig = json.decode(configString);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
