import 'package:get/get.dart';

import '../Screens/signin_screen.dart';
import '../Screens/signup_screen.dart';

class Routes {
  static GetPage signIn = GetPage(name: "/SignInScreen", page: () => SignInScreen());
  static GetPage signUp =
      GetPage(name: '/SignUpScreen', page: () => SignUpScreen());
}
