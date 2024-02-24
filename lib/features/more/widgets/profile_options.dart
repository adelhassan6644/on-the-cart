import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/dimensions.dart';

import '../../../app/core/app_event.dart';
import '../../../app/core/app_state.dart';
import '../../../app/core/images.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/svg_images.dart';
import '../../../app/core/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_bottom_sheet.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_images.dart';
import '../../../data/config/di.dart';
import '../../../main_blocs/user_bloc.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../../profile/bloc/delete_profile_bloc.dart';
import '../../profile/repo/profile_repo.dart';
import 'more_button.dart';

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, AppState>(
      builder: (context, state) {
        return Visibility(
          visible: UserBloc.instance.isLogin,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 8.h,
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                child: Text(
                  getTranslated("settings", context: context),
                  style: AppTextStyles.semiBold
                      .copyWith(color: Styles.DETAILS_COLOR, fontSize: 16),
                ),
              ),

              ///Profile
              MoreButton(
                title: getTranslated("profile"),
                icon: SvgImages.userIcon,
                withTopBorder: false,
                onTap: () => CustomNavigator.push(Routes.editProfile),
              ),

              ///Address
              MoreButton(
                title: getTranslated("addresses"),
                icon: SvgImages.location,
                onTap: () => CustomNavigator.push(Routes.addresses),
              ),

              ///Change Password
              MoreButton(
                title: getTranslated("change_password"),
                icon: SvgImages.lockIcon,
                onTap: () => CustomNavigator.push(Routes.changePassword),
              ),

              ///Delete Account
              MoreButton(
                title: getTranslated("remove_acc"),
                icon: SvgImages.trash,
                onTap: () => CustomBottomSheet.show(
                  height: 450,
                  widget: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      children: [
                        Text(
                          getTranslated("are_you_sure_remove_account"),
                          textAlign: TextAlign.center,
                          style: AppTextStyles.semiBold
                              .copyWith(fontSize: 16, color: Styles.TITLE),
                        ),
                        SizedBox(height: 16.h),
                        customImageIcon(
                            imageName: Images.removeAcc,
                            height: 200,
                            width: 200),
                      ],
                    ),
                  ),
                  label: getTranslated("remove_acc"),
                  child: Row(
                    children: [
                      BlocProvider(
                        create: (context) =>
                            DeleteProfileBloc(repo: sl<ProfileRepo>()),
                        child: Expanded(
                            child: CustomButton(
                                onTap: () => context
                                    .read<DeleteProfileBloc>()
                                    .add(Delete()),
                                text: getTranslated("remove"))),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                          child: CustomButton(
                              textColor: Styles.PRIMARY_COLOR,
                              onTap: () => CustomNavigator.pop(),
                              backgroundColor:
                                  Styles.PRIMARY_COLOR.withOpacity(0.2),
                              text: getTranslated("cancel"))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
