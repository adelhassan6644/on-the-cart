import 'package:flutter/material.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/core/text_styles.dart';
import 'package:stepOut/components/custom_network_image.dart';
import 'package:stepOut/features/categories/model/categories_model.dart';

import '../../../app/core/styles.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, this.category, this.height});
  final CategoryItem? category;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => CustomNavigator.push(Routes.items,
          arguments: category ?? CategoryItem()),
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        width: 100.w,
        decoration: BoxDecoration(
            color: Styles.WHITE_COLOR,
            border: Border.all(
              color: Styles.ACCENT_COLOR,
            ),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomNetworkImage.containerNewWorkImage(
                height: 70.h,
                width: 100.w,
                topEdges: true,
                image: category?.image ?? ""),
            Padding(
              padding: EdgeInsets.only(top: 6.h, bottom: 12.h),
              child: Text(
                category?.name ?? "title",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: AppTextStyles.medium
                    .copyWith(fontSize: 14, color: Styles.ACCENT_COLOR),
              ),
            )
          ],
        ),
      ),
    );
  }
}
