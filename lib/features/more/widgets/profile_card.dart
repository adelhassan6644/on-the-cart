import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/app_state.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/components/shimmer/custom_shimmer.dart';
import 'package:stepOut/main_blocs/user_bloc.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/svg_images.dart';
import '../../../app/core/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_button.dart';
import '../../../main_widgets/profile_image_widget.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
          vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
      child: BlocBuilder<UserBloc, AppState>(
        builder: (context, state) {
          if (state is Loading) {
            return Row(
              children: [
                ///Profile Image
                const ProfileImageWidget(
                  withEdit: false,
                  radius: 30,
                ),
                SizedBox(
                  width: 16.w,
                ),

                ///Profile Date
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomShimmerContainer(
                        width: 100,
                        height: 18,
                      ),
                      SizedBox(height: 4.h),
                      const CustomShimmerContainer(
                        width: 200,
                        height: 18,
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return !(UserBloc.instance.isLogin)
                ? Row(
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
                          onTap: () => CustomNavigator.push(Routes.login,
                              arguments: true),
                          svgIcon: SvgImages.login,
                          width: 170.w,
                          text: getTranslated("login", context: context))
                    ],
                  )
                : Row(
                    children: [
                      ///Profile Image
                      const ProfileImageWidget(
                        withEdit: false,
                        radius: 30,
                      ),

                      SizedBox(
                        width: 16.w,
                      ),

                      ///Profile Date
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              UserBloc.instance.isLogin
                                  ? UserBloc.instance.user?.name ?? ""
                                  : "Guest",
                              style: AppTextStyles.semiBold.copyWith(
                                color: Styles.HEADER,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              UserBloc.instance.isLogin
                                  ? UserBloc.instance.user?.email ?? ""
                                  : "guest@on-the-cart.com",
                              style: AppTextStyles.regular.copyWith(
                                  color: Styles.DETAILS_COLOR, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
          }
        },
      ),
    );
  }
}
