import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skeleton/features/sign_up/pages/EmailInputPage.dart';
import 'package:skeleton/features/sign_up/pages/NameInputPage.dart';
import 'package:skeleton/features/sign_up/pages/NicknameInputPage.dart';
import 'package:skeleton/features/sign_up/pages/PasswordInputPage.dart';
import 'package:skeleton/features/sign_up/pages/SignUpConfirmPage.dart';
import 'package:skeleton/utils/AppStringsKorean.dart';

class SignUpScreen extends StatefulWidget {
  static const String name = 'SignUpScreen';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () => context.go('/mypage')),
          title: const Text(AppStrings.signUpAppBarTitle)),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          EmailInputPage(
              onNext: () => _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  )),
          PasswordInputPage(
              onNext: () => _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  )),
          NameInputPage(
              onNext: () => _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  )),
          NicknameInputPage(
              onNext: () => _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  )),
          const SignUpConfirmPage()
        ],
      ),
    );
  }
}
