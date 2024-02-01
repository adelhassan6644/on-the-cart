import 'package:flutter/material.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/components/custom_images.dart';

import '../../../app/core/styles.dart';
import '../../../app/core/text_styles.dart';

class OrderTab extends StatelessWidget {
  const OrderTab(
      {super.key,
      required this.icon,
      required this.title,
      this.isSelected = false,
      this.onTap});
  final String icon, title;
  final bool isSelected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          customImageIconSVG(
              imageName: icon,
              color: isSelected ? Styles.PRIMARY_COLOR : Styles.DISABLED),
          SizedBox(
            height: 4.h,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.semiBold.copyWith(
                fontSize: 14,
                color: isSelected ? Styles.PRIMARY_COLOR : Styles.DISABLED),
          )
        ],
      ),
    );
  }
}
