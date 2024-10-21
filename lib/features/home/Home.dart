import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton/core/theme/AppColors.dart';
import 'package:skeleton/features/calendar/CalendarScreen.dart';
import 'package:skeleton/features/first/FirstScreen.dart';
import 'package:skeleton/features/my_page/MyPageScreen.dart';
import 'package:skeleton/service/firebase_auth/FirebaseAuthProvider.dart';
import 'package:skeleton/utils/AppStringsKorean.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);

final List<Widget> pages = [
  const FirstScreen(),
  CalendarScreen(),
  const MyPageScreen()
];

class HomeScreen extends ConsumerWidget {
  static const String name = 'HomeScreen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);
    final getUser = ref.read(authRepositoryProvider);

    return Scaffold(
      body: Center(
        child: pages[selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) async =>
            ref.read(selectedIndexProvider.notifier).state = index,
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: const IconThemeData(color: accentDarkColor),
        selectedItemColor: accentDarkColor,
        unselectedIconTheme: const IconThemeData(color: accentDarkColor2),
        unselectedItemColor: accentDarkColor2,
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.podcasts),
            label: AppStrings.firstScreenText,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: AppStrings.secondScreenText,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: AppStrings.myPageScreenText,
          )
        ],
      ),
    );
  }
}
