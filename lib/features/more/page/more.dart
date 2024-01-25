import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/app_state.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/core/styles.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/animated_widget.dart';
import 'package:stepOut/components/custom_button.dart';
import '../../../app/core/svg_images.dart';
import '../../../app/core/text_styles.dart';
import '../../language/bloc/language_bloc.dart';
import '../widgets/more_options.dart';
import '../widgets/profile_card.dart';

class More extends StatelessWidget {
  const More({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<LanguageBloc, AppState>(
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                    vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(getTranslated("welcome", context: context),
                              maxLines: 1,
                              style: AppTextStyles.medium.copyWith(
                                  fontSize: 18,
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.black)),
                          Text(getTranslated("more_header", context: context),
                              maxLines: 2,
                              style: AppTextStyles.medium.copyWith(
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                  color: Styles.DETAILS_COLOR)),
                        ],
                      ),
                    ),
                    CustomButton(
                        svgIcon: SvgImages.login,
                        width: 170.w,
                        text: getTranslated("login", context: context))
                  ],
                ),
              ),
              const Expanded(
                child: ListAnimator(
                  data: [
                    ProfileCard(),
                    MoreOptions(),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
