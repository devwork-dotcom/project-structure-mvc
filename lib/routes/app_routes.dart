import 'package:get/get.dart';
import 'package:project_structure/features/authentication/presentation/screens/email_verify_screen.dart';
import 'package:project_structure/features/home/presentaion/screens/home_screen.dart';
import '../features/authentication/presentation/screens/login_screen.dart';
import '../features/authentication/presentation/screens/sing_up_screen.dart';

import '../features/nav_bar/presentation/screens/nav_bar.dart';
import '../features/profile/presentation/screens/change_password_screen.dart';
import '../features/profile/presentation/screens/personal_information_screen.dart';
import '../features/splash_screen/presentation/screens/splash_screen.dart';

class AppRoute {
  // Auth Section
  static String init = "/";
  static String loginScreen = "/loginScreen";
  static String signUpScreen = "/signUpScreen";

  static String homeScreen = "/homeScreen";

  static String emailVerifyScreen = "/emailVerifyScreen";
  static String changePasswordScreen = "/resetPasswordScreen";
  static String personalInformationScreen = "/verifyCodeScreen";
  static String resetPasswordScreen = "/resetPasswordScreen";
  static String verifyCodeScreen = "/verifyCodeScreen";

  static String navBar = "/navBar";

  static List<GetPage> routes = [
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: signUpScreen, page: () => SignUpScreen()),

    GetPage(name: homeScreen, page: () => HomeScreen()),

    // Added by Shahriar
    GetPage(name: init, page: () => SplashScreen()),
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: signUpScreen, page: () => SignUpScreen()),
    GetPage(name: emailVerifyScreen, page: () => EmailVerifyScreen()),
    GetPage(name: changePasswordScreen, page: () => ChangePasswordScreen()),
    GetPage(
      name: personalInformationScreen,
      page: () => PersonalInformationScreen(),
    ),
    GetPage(name: navBar, page: () => NavBar()),
  ];
}
