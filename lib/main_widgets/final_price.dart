import 'package:flutter/material.dart';

import '../app/core/styles.dart';
import '../app/core/text_styles.dart';
import '../app/localization/language_constant.dart';

class FinalPriceWidget extends StatelessWidget {
  const FinalPriceWidget(
      {super.key,
      this.fontSize,
      required this.price,
      required this.finalPrice,
      required this.isExistDiscount});
  final double price, finalPrice;
  final bool isExistDiscount;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "$finalPrice ${getTranslated("sar")}",
        style: AppTextStyles.medium.copyWith(
          fontSize: fontSize ?? 14,
          color: Styles.TITLE,
          overflow: TextOverflow.ellipsis,
        ),
        children: [
          if (isExistDiscount)
            TextSpan(
              text: "$price ${getTranslated("sar")}",
              style: AppTextStyles.regular.copyWith(
                fontSize: 12,
                color: Styles.HINT_COLOR,
                decoration: TextDecoration.lineThrough,
              ),
            ),
        ],
      ),
    );
  }
}
