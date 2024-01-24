import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/app_state.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/core/extensions.dart';
import 'package:stepOut/components/shimmer/custom_shimmer.dart';
import 'package:stepOut/main_blocs/user_bloc.dart';

import '../../../app/core/images.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/text_styles.dart';
import '../../../main_widgets/profile_image_widget.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, AppState>(
      builder: (context, state) {
        if (state is Loading) {
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              ///Profile Date
              Container(
                margin: EdgeInsets.only(
                    top: 0,
                    bottom: 40,
                    right: Dimensions.PADDING_SIZE_DEFAULT.w,
                    left: Dimensions.PADDING_SIZE_DEFAULT.w),
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                  vertical: Dimensions.PADDING_SIZE_DEFAULT.w,
                ),
                height: 120,
                width: context.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        spreadRadius: 4,
                        blurRadius: 5)
                  ],
                  image: const DecorationImage(
                    image: ExactAssetImage(Images.authBG),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    const Expanded(child: SizedBox()),
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

              ///Profile Image
              const Center(
                child: ProfileImageWidget(
                  withEdit: false,
                  radius: 40,
                ),
              ),
            ],
          );
        }
        if (state is Done) {
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              ///Profile Date
              Container(
                margin: EdgeInsets.only(
                    top: 40,
                    bottom: 40,
                    right: Dimensions.PADDING_SIZE_DEFAULT.w,
                    left: Dimensions.PADDING_SIZE_DEFAULT.w),
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                  vertical: Dimensions.PADDING_SIZE_DEFAULT.w,
                ),
                height: 120,
                width: context.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        spreadRadius: 4,
                        blurRadius: 5)
                  ],
                  image: const DecorationImage(
                    image: ExactAssetImage(Images.authBG),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    const Expanded(child: SizedBox()),
                    Text(
                      UserBloc.instance.isLogin
                          ? UserBloc.instance.user?.name ?? ""
                          : "Guest",
                      style: AppTextStyles.bold.copyWith(
                          color: Styles.SPLASH_BACKGROUND_COLOR,
                          fontSize: 16,
                          height: 1),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      UserBloc.instance.isLogin
                          ? UserBloc.instance.user?.email ?? ""
                          : "guest@stepOut.com",
                      style: AppTextStyles.regular.copyWith(
                          color: Styles.SPLASH_BACKGROUND_COLOR, fontSize: 12),
                    ),
                  ],
                ),
              ),

              ///Profile Image
              const Center(
                child: ProfileImageWidget(
                  withEdit: false,
                  radius: 40,
                ),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
