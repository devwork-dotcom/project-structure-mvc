import 'package:get/get.dart';
import 'package:project_structure/core/services/auth_service.dart';
import 'package:project_structure/features/profile/presentation/screens/profile_screen.dart';
import '../../home/presentaion/screens/home_screen.dart';

class NavBarController extends GetxController {
  var selectedIndex = 0.obs;

  int get currentIndex => selectedIndex.value;

  List screens = [
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    ProfileScreen(),
  ];

  @override
  void onInit() {
    super.onInit();
    AuthService.init();
  }

  void changeIndex(int index) {
    if (selectedIndex.value == index) {
      return;
    }

    selectedIndex.value = index;
  }

  void backToHome() {
    changeIndex(0);
  }
}
