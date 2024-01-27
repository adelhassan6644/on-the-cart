import 'package:flutter/material.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/core/text_styles.dart';
import 'package:stepOut/features/language/bloc/language_bloc.dart';

import '../app/core/styles.dart';
import '../data/config/di.dart';

class DiscountWidget extends StatelessWidget {
  const DiscountWidget({super.key, this.discount});
  final String? discount;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.w),
      decoration: BoxDecoration(
        color: Styles.PRIMARY_COLOR,
        borderRadius: BorderRadius.only(
          topRight: sl<LanguageBloc>().isLtr
              ? const Radius.circular(0)
              : const Radius.circular(4),
          bottomRight: sl<LanguageBloc>().isLtr
              ? const Radius.circular(0)
              : const Radius.circular(4),
          topLeft: sl<LanguageBloc>().isLtr
              ? const Radius.circular(4)
              : const Radius.circular(0),
          bottomLeft: sl<LanguageBloc>().isLtr
              ? const Radius.circular(4)
              : const Radius.circular(0),
        ),
      ),
      child: Text(
        "- ${discount ?? "10"} %",
        textAlign: TextAlign.center,
        style: AppTextStyles.medium
            .copyWith(fontSize: 14, color: Styles.WHITE_COLOR),
      ),
    );
  }
}
