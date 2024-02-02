import 'package:flutter/material.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/core/styles.dart';
import 'package:stepOut/app/core/svg_images.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/custom_images.dart';
import 'package:stepOut/components/custom_text_form_field.dart';
import 'package:stepOut/navigation/custom_navigation.dart';

import '../../../navigation/routes.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
      child: Row(
        children: [
          Expanded(
              child: CustomTextField(
            isEnabled: false,
            onTap: () {},
            hint: getTranslated("search"),
            inputType: TextInputType.text,
          )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: customContainerSvgIcon(
                onTap: () => CustomNavigator.push(Routes.notifications),
                width: 60,
                height: 60,
                radius: 100,
                backGround: Styles.WHITE_COLOR,
                imageName: SvgImages.notification),
          ),
          customContainerSvgIcon(
              onTap: () => CustomNavigator.push(Routes.profile),
              backGround: Styles.WHITE_COLOR,
              withShadow: true,
              width: 60,
              height: 60,
              radius: 100,
              imageName: SvgImages.profileIcon)
        ],
      ),
    );
  }
}
