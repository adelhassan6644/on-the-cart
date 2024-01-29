import 'package:flutter/material.dart';
import 'package:stepOut/app/core/dimensions.dart';

import '../../../app/core/styles.dart';
import '../../../app/core/svg_images.dart';
import '../../../app/core/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import 'more_button.dart';

class AboutTheAppOption extends StatelessWidget {
  const AboutTheAppOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: 8.h, horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
          child: Text(
            getTranslated("about_the_app", context: context),
            style: AppTextStyles.semiBold
                .copyWith(color: Styles.DETAILS_COLOR, fontSize: 16),
          ),
        ),

        ///Terms and Conditions
        MoreButton(
          title: getTranslated("terms_conditions", context: context),
          icon: SvgImages.terms,
          withTopBorder: false,
          onTap: () => CustomNavigator.push(Routes.TERMS),
        ),

        ///About US
        MoreButton(
          title: getTranslated("more_about_us", context: context),
          icon: SvgImages.infoSquare,
          onTap: () => CustomNavigator.push(Routes.aboutUs),
        ),
      ],
    );
  }
}
