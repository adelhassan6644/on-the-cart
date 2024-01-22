import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/core/extensions.dart';
import 'package:stepOut/components/custom_app_bar.dart';
import 'package:stepOut/components/custom_images.dart';
import '../../../../app/core/app_event.dart';
import '../../../../app/core/images.dart';
import '../../../../app/core/styles.dart';
import '../../../../app/core/svg_images.dart';
import '../../../../app/core/text_styles.dart';
import '../../../../app/localization/language_constant.dart';
import '../../../../data/config/di.dart';
import '../bloc/login_bloc.dart';
import '../repo/login_repo.dart';
import '../widgets/login_body_widget.dart';

class Login extends StatelessWidget {
  final bool fromMain;

  const Login({Key? key, required this.fromMain}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(repo: sl<LoginRepo>())..add(Remember()),
      child: Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: context.toPadding + 180.h,
              width: context.width,
              padding: EdgeInsets.only(
                  left: Dimensions.PADDING_SIZE_DEFAULT.w,
                  right: Dimensions.PADDING_SIZE_DEFAULT.w,
                  top: fromMain
                      ? context.toPadding
                      : (context.toPadding + Dimensions.PADDING_SIZE_DEFAULT.h),
                  bottom: Dimensions.PADDING_SIZE_DEFAULT.h),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage(Images.authBG),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (fromMain)
                    const CustomAppBar(
                      withHPadding: false,
                      withSafeArea: false,
                      backColor: Styles.WHITE_COLOR,
                    ),
                  const Expanded(child: SizedBox()),
                  Row(
                    children: [
                      Text(
                        getTranslated("login_header"),
                        textAlign: TextAlign.start,
                        style: AppTextStyles.semiBold
                            .copyWith(fontSize: 24, color: Styles.WHITE_COLOR),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      customImageIconSVG(imageName: SvgImages.checkHand)
                    ],
                  ),
                  Text(
                    getTranslated("login_description"),
                    textAlign: TextAlign.start,
                    style: AppTextStyles.medium
                        .copyWith(fontSize: 14, color: Styles.WHITE_COLOR),
                  ),
                  SizedBox(
                    height: Dimensions.PADDING_SIZE_EXTRA_SMALL.h,
                  ),
                ],
              ),
            ),
            const Column(
              children: [
                Expanded(child: LoginBodyWidget()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
