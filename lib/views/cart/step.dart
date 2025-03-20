
  import 'package:flutter/material.dart';
import 'package:picknow/views/widgets/customtext.dart';

import '../../core/costants/theme/appcolors.dart';

List<Step> getsteps(int currentstep) => [
        Step(
          state: currentstep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentstep >= 0,
          stepStyle: StepStyle(
            color: currentstep > 0 || currentstep >= 0
                ? AppColors.greenColor
                : AppColors.greenColor,
            connectorColor:
                currentstep > 0 ? AppColors.greenColor : AppColors.grey,
          ),
          title: CustomText(
            text: "Cart",
            size: 0.028,
            color: currentstep >= 0 ? AppColors.greenColor! : AppColors.grey,
            weight: FontWeight.bold,
          ),
          content: Container(),
        ),
        Step(
          state: currentstep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentstep >= 1,
          stepStyle: StepStyle(
              color: currentstep > 1 || currentstep >= 1
                  ? AppColors.greenColor
                  : AppColors.grey,
              connectorColor:
                  currentstep > 1 ? AppColors.greenColor : AppColors.grey),
          title: CustomText(
            text: "Address",
            size: 0.028,
            color: currentstep >= 1 ? AppColors.greenColor! : AppColors.grey,
            weight: FontWeight.bold,
          ),
          content: Container(),
        ),
        Step(
          state: currentstep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentstep >= 2,
          stepStyle: StepStyle(
            color: currentstep == 2 || currentstep >= 2
                ? AppColors.greenColor
                : AppColors.grey,
          ),
          title: CustomText(
            text: "Payment",
            size: 0.028,
            color: currentstep >= 2 ? AppColors.greenColor! : AppColors.grey,
            weight: FontWeight.bold,
          ),
          content: Container(),
        ),
      ];