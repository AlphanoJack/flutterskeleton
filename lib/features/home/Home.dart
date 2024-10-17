import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton/core/theme/AppColors.dart';
import 'package:skeleton/features/first/FirstScreen.dart';
import 'package:skeleton/features/my_page/MyPageScreen.dart';
import 'package:skeleton/features/second/SecondScreen.dart';
import 'package:skeleton/utils/AppStringsKorean.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);

final List<Widget> pages = [
  const FirstScreen(),
  const SecondScreen(),
  const MyPageScreen()
];

class Home extends ConsumerWidget {
  static const String name = 'HomeScreen';
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);
    return Scaffold(
      body: Center(
        child: pages[selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
