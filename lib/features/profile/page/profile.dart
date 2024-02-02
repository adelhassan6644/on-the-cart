import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/app_state.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/animated_widget.dart';
import 'package:stepOut/components/custom_app_bar.dart';
import 'package:stepOut/components/custom_button.dart';
import 'package:stepOut/components/custom_images.dart';
import 'package:stepOut/components/custom_loading.dart';
import 'package:stepOut/features/profile/bloc/profile_bloc.dart';
import 'package:stepOut/features/profile/repo/profile_repo.dart';
import 'package:stepOut/main_widgets/profile_image_widget.dart';
import '../../../app/core/app_event.dart';
import '../../../app/core/images.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/svg_images.dart';
import '../../../app/core/text_styles.dart';
import '../../../components/custom_bottom_sheet.dart';
import '../../../data/config/di.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../../more/widgets/more_button.dart';
import '../bloc/delete_profile_bloc.dart';
import '../widgets/profile_body.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(repo: sl<ProfileRepo>()),
      // create: (context) => ProfileBloc(repo: sl<ProfileRepo>())..add(Get()),
      child: Scaffold(
        appBar: CustomAppBar(
          title: getTranslated("profile"),
        ),
        body: BlocBuilder<ProfileBloc, AppState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(child: CustomLoading());
            }
            if (state is Done) {
              return Column(
                children: [
                  Expanded(
                      child: ListAnimator(
                    data: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                        ),
                        child: Center(
                          child: const ProfileImageWidget(
                            withEdit: true,
                            radius: 60,
                          ),
                        ),
                      ),
                      const ProfileBody(),
                      SizedBox(height: 24.h),
                      // MoreButton(
                      //   title: getTranslated("change_password"),
                      //   icon: SvgImages.lockIcon,
                      //   onTap: () =>
                      //       CustomNavigator.push(Routes.CHANGE_PASSWORD),
                      // ),
                      // MoreButton(
                      //   title: getTranslated("remove_acc"),
                      //   icon: SvgImages.trash,
                      //   withBottomBorder: true,
                      //   onTap: () => CustomBottomSheet.show(
                      //     height: 450,
                      //     list: Padding(
                      //       padding: EdgeInsets.symmetric(horizontal: 24.w),
                      //       child: Column(
                      //         children: [
                      //           Text(
                      //             getTranslated("are_you_sure_remove_account"),
                      //             textAlign: TextAlign.center,
                      //             style: AppTextStyles.semiBold.copyWith(
                      //                 fontSize: 16, color: Styles.TITLE),
                      //           ),
                      //           SizedBox(height: 16.h),
                      //           customImageIcon(
                      //               imageName: Images.removeAcc,
                      //               height: 200,
                      //               width: 200),
                      //         ],
                      //       ),
                      //     ),
                      //     label: getTranslated("remove_acc"),
                      //     child: Row(
                      //       children: [
                      //         BlocProvider(
                      //           create: (context) =>
                      //               DeleteProfileBloc(repo: sl<ProfileRepo>()),
                      //           child: Expanded(
                      //               child: CustomButton(
                      //                   onTap: () => context
                      //                       .read<DeleteProfileBloc>()
                      //                       .add(Delete()),
                      //                   text: getTranslated("remove"))),
                      //         ),
                      //         SizedBox(width: 16.w),
                      //         Expanded(
                      //             child: CustomButton(
                      //                 textColor: Styles.PRIMARY_COLOR,
                      //                 onTap: () => CustomNavigator.pop(),
                      //                 backgroundColor:
                      //                     Styles.PRIMARY_COLOR.withOpacity(0.2),
                      //                 text: getTranslated("cancel"))),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ))
                ],
              );
            }
            return Column(
              children: [
                Expanded(
                    child: ListAnimator(
                  data: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                      ),
                      child: const Center(
                        child: ProfileImageWidget(
                          withEdit: true,
                          radius: 60,
                        ),
                      ),
                    ),
                    const ProfileBody(),
                  ],
                ))
              ],
            );
          },
        ),
      ),
    );
  }
}
