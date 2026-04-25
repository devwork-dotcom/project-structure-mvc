import 'dart:developer';

import 'package:get/get.dart';
import 'package:project_structure/core/services/auth_service.dart';
import 'package:project_structure/core/services/network_caller.dart';
import 'package:project_structure/core/utils/constants/app_urls.dart';
import 'package:project_structure/core/utils/logging/logger.dart';
import 'package:project_structure/features/profile/model/faq_model.dart';
import 'package:project_structure/features/profile/model/privacy_policy_model.dart';
import 'package:project_structure/features/profile/model/terms_and_condition_model.dart';

class PrivacyController extends GetxController {
  final isPrivacyLoading = false.obs;
  final Rxn<PrivacyPolicyModel> privacyPolicyModel = Rxn<PrivacyPolicyModel>();

  final isTermsLoading = false.obs;
  final Rxn<TermConditionModel> termConditionModel = Rxn<TermConditionModel>();

  final isFaqLoading = false.obs;
  final Rxn<FaqModel> faqModel = Rxn<FaqModel>();

  @override
  void onInit() {
    super.onInit();
    getPrivacyPolicyData(showLoader: true);
    getTermsAndConditionData(showLoader: true);
    getFaqData(showLoader: true);
  }

  Future<void> getPrivacyPolicyData({bool showLoader = false}) async {
    if (showLoader) {
      isPrivacyLoading.value = true;
    }
    try {
      final response = await NetworkCaller().getRequest(
        AppUrls.getPrivacyAndPolicy,
        token: 'Bearer ${AuthService.token}',
      );

      if (response.isSuccess && response.responseData != null) {
        privacyPolicyModel.value = PrivacyPolicyModel.fromJson(
          response.responseData,
        );
      } else {
        log('Failed to fetch privacy policy: ${response.statusCode}');
        AppLoggerHelper.error(
          'Failed to fetch privacy policy: ${response.statusCode}',
        );
      }
    } catch (e) {
      log('Error fetching privacy policy data: $e');
      AppLoggerHelper.error(e.toString());
    } finally {
      if (showLoader) {
        isPrivacyLoading.value = false;
      }
    }
  }

  Future<void> getTermsAndConditionData({bool showLoader = false}) async {
    if (showLoader) {
      isTermsLoading.value = true;
    }
    try {
      final response = await NetworkCaller().getRequest(
        AppUrls.getTermsAndCondition,
        token: 'Bearer ${AuthService.token}',
      );

      if (response.isSuccess && response.responseData != null) {
        termConditionModel.value = TermConditionModel.fromJson(
          response.responseData,
        );
      } else {
        log('Failed to fetch terms: ${response.statusCode}');
        AppLoggerHelper.error('Failed to fetch terms: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching terms data: $e');
      AppLoggerHelper.error(e.toString());
    } finally {
      if (showLoader) {
        isTermsLoading.value = false;
      }
    }
  }

  Future<void> getFaqData({bool showLoader = false}) async {
    if (showLoader) {
      isFaqLoading.value = true;
    }
    try {
      final response = await NetworkCaller().getRequest(
        AppUrls.getFaq,
        token: 'Bearer ${AuthService.token}',
      );
      if (response.isSuccess) {
        faqModel.value = FaqModel.fromJson(response.responseData);
      } else {
        log('Failed to fetch faq: ${response.statusCode}');
        AppLoggerHelper.error('Failed to fetch faq: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching faq data: $e');
      AppLoggerHelper.error(e.toString());
    } finally {
      if (showLoader) {
        isFaqLoading.value = false;
      }
    }
  }
}
