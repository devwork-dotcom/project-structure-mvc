import 'package:get/get.dart';

import '../../features/home/controllers/home_controller.dart';
import '../../features/nav_bar/controllers/nav_bar_controller.dart';
import '../../features/profile/controller/profile_controller.dart';


class ControllerBinder extends Bindings {
  @override
  void dependencies() {
     Get.lazyPut<NavBarController>( () => NavBarController(),fenix: true,);
     Get.lazyPut<HomeController>(() => HomeController(),fenix: true,);
    Get.lazyPut<ProfileController>(() => ProfileController(),fenix: true,);
  }
}
