import 'package:get/get.dart';
import 'package:project_structure/core/common/widgets/app_snackber.dart';
import 'package:project_structure/core/services/auth_service.dart';
import 'package:project_structure/core/services/network_caller.dart';
import 'package:project_structure/core/utils/constants/app_urls.dart';
import 'package:project_structure/core/utils/logging/logger.dart';
import 'package:project_structure/features/home/model/home_feature_model.dart';

class HomeController extends GetxController {
  // final RxBool isBibleLoading = false.obs;
  // final homeFeatureModel = Rxn<HomeFeatureModel>();
  // Future<void> fetchHomeFeature() async {
  //   try {
  //     isBibleLoading(true);
  //     final response = await NetworkCaller().getRequest(
  //       AppUrls.login,
  //       token: "Bearer ${AuthService.token}",
  //     );
  //     if (response.isSuccess) {
  //       homeFeatureModel.value = HomeFeatureModel.fromJson(
  //         response.responseData,
  //       );
  //       AppLoggerHelper.debug(response.responseData);
  //     }
  //   } catch (e) {
  //     AppLoggerHelper.error("Error : ${e.toString()}");
  //     AppSnackBar.error("Something went wrong. Try again later.");
  //   } finally {
  //     isBibleLoading(false);
  //   }
  // }
}
