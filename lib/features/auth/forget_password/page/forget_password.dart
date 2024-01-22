import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/core/extensions.dart';
import 'package:stepOut/components/custom_app_bar.dart';
import 'package:stepOut/features/auth/forget_password/bloc/forget_password_bloc.dart';
import 'package:stepOut/features/auth/forget_password/repo/forget_password_repo.dart';

import '../../../../app/core/app_event.dart';
import '../../../../app/core/app_state.dart';
import '../../../../app/core/images.dart';
import '../../../../app/core/styles.dart';
import '../../../../app/core/text_styles.dart';
import '../../../../app/core/validation.dart';
import '../../../../app/localization/language_constant.dart';
import '../../../../components/animated_widget.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/custom_text_form_field.dart';
import '../../../../data/config/di.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode emailNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordBloc(repo: sl<ForgetPasswordRepo>()),
      child: BlocBuilder<ForgetPasswordBloc, AppState>(
        builder: (context, state) {
          return SafeArea(
            top: false,
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
                        top: context.toPadding,
                        bottom: Dimensions.PADDING_SIZE_DEFAULT.h),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage(Images.authBG),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomAppBar(
                          withSafeArea: false,
                          withHPadding: false,
                          backColor: Styles.WHITE_COLOR,
                        ),
                        const Expanded(child: SizedBox()),
                        Row(
                          children: [
                            Text(
                              getTranslated("forget_password_header"),
                              textAlign: TextAlign.start,
                              style: AppTextStyles.semiBold.copyWith(
                                  fontSize: 24, color: Styles.WHITE_COLOR),
                            ),
                          ],
                        ),
                        Text(
                          getTranslated("forget_password_description"),
                          textAlign: TextAlign.start,
                          style: AppTextStyles.medium.copyWith(
                              fontSize: 14, color: Styles.WHITE_COLOR),
                        ),
                        SizedBox(
                          height: Dimensions.PADDING_SIZE_EXTRA_SMALL.h,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                            top: context.toPadding + 160.h,
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                              vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
                          decoration: const BoxDecoration(
                              color: Styles.WHITE_COLOR,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20))),
                          child: ListAnimator(
                            data: [
                              SizedBox(
                                height: Dimensions.PADDING_SIZE_DEFAULT.h,
                              ),
                              Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      CustomTextField(
                                        controller: context
                                            .read<ForgetPasswordBloc>()
                                            .mailTEC,
                                        label: getTranslated("mail"),
                                        hint: getTranslated("enter_your_mail"),
                                        withLabel: true,
                                        focusNode: emailNode,
                                        inputType: TextInputType.emailAddress,
                                        validate: Validations.mail,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 24.h,
                                        ),
                                        child: CustomButton(
                                            text: getTranslated("submit"),
                                            onTap: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                context
                                                    .read<ForgetPasswordBloc>()
                                                    .add(Click());
                                              }
                                            },
                                            isLoading: state is Loading),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
