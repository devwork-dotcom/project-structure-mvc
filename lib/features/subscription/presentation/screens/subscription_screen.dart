import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:project_structure/core/common/widgets/custom_appbar_widget.dart';
import 'package:project_structure/core/common/widgets/custom_scaffold.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';
import 'package:project_structure/features/subscription/presentation/widgets/free_plan_card.dart';
import 'package:project_structure/features/subscription/presentation/widgets/premium_plan_card.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppbarWidget(text: "Subscription"),
      child: Column(
        children: [
          FreePlanCard(),

          PremiumPlanCard(onTapPremium: () {}),

          Gap(24.h),

          //ComparePlansCard(),
        ],
      ),
    );
  }
}
