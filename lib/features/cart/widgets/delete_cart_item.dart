import 'package:flutter/material.dart';
import 'package:stepOut/app/core/dimensions.dart';

import '../../../app/core/styles.dart';
import '../../../app/core/svg_images.dart';
import '../../../app/core/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_images.dart';

class DeleteCartItem extends StatelessWidget {
  const DeleteCartItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Styles.WHITE_COLOR,
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.center,
        children: [
          customContainerSvgIcon(
              imageName: SvgImages.delete,
              padding: 10,
              width: 40,
              height: 40,
              radius: 100,
              color: Styles.PRIMARY_COLOR),
          SizedBox(
            width: 8.w,
          ),
          Text(getTranslated("delete"),
              style:
              AppTextStyles.medium.copyWith(
                color: Styles.PRIMARY_COLOR,
                fontSize: 14,
              )),
        ],
      ),
    );
  }
}
