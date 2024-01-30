import 'package:flutter/material.dart';
import 'package:stepOut/app/core/dimensions.dart';

import '../../../app/core/styles.dart';
import '../../../app/core/text_styles.dart';
import '../../../app/localization/language_constant.dart';

class ItemSizesWidget extends StatelessWidget {
  const ItemSizesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: Dimensions.PADDING_SIZE_DEFAULT.w,
              right: Dimensions.PADDING_SIZE_DEFAULT.w,
              top: 16.h,
              bottom: 6.h),
          child: Text(
            getTranslated("sizes"),
            style: AppTextStyles.medium
                .copyWith(fontSize: 16, color: Styles.DETAILS_COLOR),
          ),
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                width: Dimensions.PADDING_SIZE_DEFAULT.w,
              ),
              ...List.generate(
                8,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Styles.BORDER_COLOR)),
                  child: Text(
                    "M",
                    textAlign: TextAlign.start,
                    style: AppTextStyles.medium
                        .copyWith(fontSize: 14, color: Styles.DETAILS_COLOR),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
