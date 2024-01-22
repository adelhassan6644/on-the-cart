import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/app_state.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:stepOut/features/language/bloc/language_bloc.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/svg_images.dart';
import '../../../app/core/text_styles.dart';
import '../../../components/custom_images.dart';

class MoreButton extends StatelessWidget {
  const MoreButton(
      {required this.title,
      this.withBottomBorder = false,
      required this.icon,
      this.onTap,
      Key? key})
      : super(key: key);
  final String title, icon;
  final bool withBottomBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: Dimensions.PADDING_SIZE_SMALL.h,
            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
        decoration: BoxDecoration(
            border: Border(
          top: const BorderSide(
            color: Styles.BORDER_COLOR,
          ),
          bottom: BorderSide(
            color: withBottomBorder ? Styles.BORDER_COLOR : Colors.transparent,
          ),
        )),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            customImageIconSVG(
                imageName: icon, height: 24, width: 24, color: Styles.TITLE),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(title,
                    maxLines: 1,
                    style: AppTextStyles.medium.copyWith(
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                        color: Styles.TITLE)),
              ),
            ),
            BlocBuilder<LanguageBloc, AppState>(
              builder: (context, state) {
                return RotatedBox(
                  quarterTurns:
                      LanguageBloc.instance.selectLocale?.languageCode == "ar"
                          ? 2
                          : 0,
                  child: customImageIconSVG(
                      color: Styles.HINT_COLOR, imageName: SvgImages.backArrow),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
