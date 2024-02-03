import 'package:flutter/material.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/core/styles.dart';
import 'package:stepOut/app/core/svg_images.dart';
import 'package:stepOut/app/core/text_styles.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/custom_images.dart';
import 'package:stepOut/navigation/custom_navigation.dart';

import '../../../navigation/routes.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
        vertical: Dimensions.PADDING_SIZE_DEFAULT.h,
      ),
      child: Row(
        children: [
          Expanded(
              child: InkWell(
            onTap: () => CustomNavigator.push(Routes.search),
            child: Container(
              height: 55,
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100)),
              child: Row(
                children: [
                  customImageIconSVG(
                      imageName: SvgImages.search,
                      color: Styles.TITLE,
                      width: 20,
                      height: 20),
                  SizedBox(
                    width: 8.w,
                  ),
                  Expanded(
                    child: Text(
                      getTranslated("search"),
                      style: AppTextStyles.medium
                          .copyWith(fontSize: 14, color: Styles.TITLE),
                    ),
                  ),
                ],
              ),
            ),
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
