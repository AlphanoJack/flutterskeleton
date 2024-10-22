import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeleton/features/calendar/CalendarScreen.dart';
import 'package:skeleton/features/calendar/widgets/CalendarWidget.dart';
import 'package:skeleton/features/first/FirstScreen.dart';
import 'package:skeleton/features/home/Home.dart';
import 'package:skeleton/features/log_in/LogInScreen.dart';
import 'package:skeleton/features/my_page/MyPageScreen.dart';
import 'package:skeleton/features/sign_up/SingUpScreen.dart';
import 'package:skeleton/service/firebase_auth/FirebaseAuthProvider.dart';
import 'package:skeleton/utils/ResponsiveLayoutBuilder.dart';
import 'package:skeleton/utils/splash/SplashScreen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final getUser = ref.read(authRepositoryProvider);

  return GoRouter(
      initialLocation: getUser.getCurrentUser() == null ? '/splash' : '/',
      redirect: (BuildContext context, GoRouterState state) {
        return null;
      },
      routes: [
        GoRoute(
          path: '/splash',
          name: SplashScreen.name,
          builder: (context, state) => ResponsiveLayoutBuilder(
            context,
            const SplashScreen(),
          ),
        ),
        GoRoute(
          path: '/signup',
          name: SignUpScreen.name,
          builder: (context, state) => ResponsiveLayoutBuilder(
            context,
            const SignUpScreen(),
          ),
        ),
        GoRoute(
          path: '/signin',
          name: LogInScreen.name,
          builder: (context, state) => ResponsiveLayoutBuilder(
            context,
            LogInScreen(),
          ),
        ),
        ShellRoute(
          builder: (context, state, child) {
            return ResponsiveLayoutBuilder(context, const HomeScreen());
          },
          routes: [
            GoRoute(
              path: '/',
              name: FirstScreen.name,
              builder: (context, state) => ResponsiveLayoutBuilder(
                context,
                const FirstScreen(),
              ),
            ),
            GoRoute(
              path: '/second',
              name: CalendarScreen.name,
              builder: (context, state) => ResponsiveLayoutBuilder(
                context,
                const CalendarScreen(),
              ),
            ),
            GoRoute(
              path: '/mypage',
              name: MyPageScreen.name,
              builder: (context, state) => ResponsiveLayoutBuilder(
                context,
                const MyPageScreen(),
              ),
            ),
          ],
        ),
      ]);
});
