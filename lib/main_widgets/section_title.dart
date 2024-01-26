import 'package:flutter/material.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/core/svg_images.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/custom_images.dart';
import '../app/core/styles.dart';
import '../app/core/text_styles.dart';
import '../components/shimmer/custom_shimmer.dart';
import '../data/config/di.dart';
import '../features/language/bloc/language_bloc.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    this.withView = false,
    this.mentionText,
    this.onViewTap,
  }) : super(key: key);
  final String title;
  final String? mentionText;
  final bool withView;
  final Function()? onViewTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: Dimensions.PADDING_SIZE_DEFAULT.w,
        bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL.w,
        left: Dimensions.PADDING_SIZE_DEFAULT.w,
        right: Dimensions.PADDING_SIZE_DEFAULT.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              child: Text(
            title,
            style: AppTextStyles.medium
                .copyWith(fontSize: 14, color: Styles.PRIMARY_COLOR),
          )),
          if (withView)
            InkWell(
              onTap: onViewTap,
              child: Row(
                children: [
                  Text(
                    "${getTranslated("view_all")}  ",
                    style: AppTextStyles.medium
                        .copyWith(fontSize: 12, color: Styles.PRIMARY_COLOR),
                  ),
                  RotatedBox(
                    quarterTurns: sl<LanguageBloc>().isLtr ? 2 : 0,
                    child: customImageIconSVG(
                        imageName: SvgImages.arrowRightIcon,
                        color: Styles.PRIMARY_COLOR),
                  )
                ],
              ),
            )
        ],
      ),
    );
  }
}

class SectionTitleShimmer extends StatelessWidget {
  const SectionTitleShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: Dimensions.PADDING_SIZE_DEFAULT.w,
        bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL.w,
        left: Dimensions.PADDING_SIZE_DEFAULT.w,
        right: Dimensions.PADDING_SIZE_DEFAULT.w,
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomShimmerText(
            width: 100,
          ),
          CustomShimmerText(
            width: 70,
          ),
        ],
      ),
    );
  }
}
