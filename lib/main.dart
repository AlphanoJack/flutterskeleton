import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton/core/router/RouterProvider.dart';
import 'package:skeleton/core/theme/AppTheme.dart';
import 'package:skeleton/core/theme/providers/ThemeProvider.dart';
import 'package:skeleton/utils/Talker.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    // 날짜 형식 초기화
    WidgetsFlutterBinding.ensureInitialized();
    await initializeDateFormatting('en_US', null);

    // Firebase 초기화
    await Firebase.initializeApp();
    // 가로모드 사용 금지 필요시 활성화
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitDown,
    //   DeviceOrientation.portraitUp,
    // ]);

    runApp(const ProviderScope(child: MyApp()));
  }, (error, stackTrace) {
    talker.error('runZonedGuarded: Caught error: $error');
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}

class MyApp extends StatefulWidget {
  static const String name = 'MyApp';
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final themeMode = ref.watch(themeNotifierProvider);
        final router = ref.watch(routerProvider);

        return MaterialApp.router(
          routerConfig: router,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
        );
      },
    );
  }
}
