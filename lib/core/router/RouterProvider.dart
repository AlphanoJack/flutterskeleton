import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeleton/service/firebase_auth/FirebaseAuthProvider.dart';
import 'package:skeleton/utils/ResponsiveLayoutBuilder.dart';
import 'package:skeleton/utils/splash/SplashScreen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final getUser = ref.read(authRepositoryProvider);


  return GoRouter(
  initialLocation: getUser.getCurrentUser() == null ? '/splash' : '/',
    routes: [
      GoRoute(
        path: '/splash',
        name: SplashScreen.name,
        builder: (context, state) => ResponsiveLayoutBuilder(
          context,
          const SplashScreen(),
        ),
      )
    ]
  );
});
