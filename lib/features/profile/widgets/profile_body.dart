import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/app_state.dart';
import 'package:stepOut/components/custom_images.dart';
import 'package:stepOut/main_blocs/user_bloc.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import 'package:stepOut/navigation/routes.dart';

import '../../../app/core/dimensions.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/svg_images.dart';
import '../../../app/core/text_styles.dart';
import '../../../app/localization/language_constant.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, AppState>(
      builder: (context, state) {
        return Container(
          margin:
              EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT.w),
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
              vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
          decoration: const BoxDecoration(
              color: Styles.WHITE_COLOR,
              border: Border(
                  top: BorderSide(color: Styles.BORDER_COLOR),
                  bottom: BorderSide(color: Styles.BORDER_COLOR))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  customImageIconSVG(
                      imageName: SvgImages.userIcon, width: 24, height: 24),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      getTranslated("personal_information"),
                      style: AppTextStyles.medium.copyWith(
                          color: Styles.PRIMARY_COLOR,
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  const SizedBox(width: 16),
                  customImageIconSVG(
                      imageName: SvgImages.edit,
                      onTap: () => CustomNavigator.push(Routes.EDIT_PROFILE)),
                ],
              ),
              SizedBox(height: 12.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///Name
                    Text(
                      getTranslated("name"),
                      style: AppTextStyles.regular
                          .copyWith(fontSize: 14, color: Styles.HINT_COLOR),
                    ),
                    Text(
                      UserBloc.instance.user?.name ?? "",
                      style: AppTextStyles.medium
                          .copyWith(fontSize: 14, color: Styles.TITLE),
                    ),
                    Divider(
                      color: Styles.BORDER_COLOR,
                      height: 24.h,
                    ),

                    ///Phone
                    Text(
                      getTranslated("phone"),
                      style: AppTextStyles.regular
                          .copyWith(fontSize: 14, color: Styles.HINT_COLOR),
                    ),
                    Text(
                      UserBloc.instance.user?.phone ?? "",
                      style: AppTextStyles.medium
                          .copyWith(fontSize: 14, color: Styles.TITLE),
                    ),
                    Divider(
                      color: Styles.BORDER_COLOR,
                      height: 24.h,
                    ),

                    ///Mail
                    Text(
                      getTranslated("mail"),
                      style: AppTextStyles.regular
                          .copyWith(fontSize: 14, color: Styles.HINT_COLOR),
                    ),
                    Text(
                      UserBloc.instance.user?.email ?? "",
                      style: AppTextStyles.medium
                          .copyWith(fontSize: 14, color: Styles.TITLE),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
