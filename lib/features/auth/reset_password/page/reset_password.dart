import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/app_state.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/features/auth/reset_password/bloc/reset_password_bloc.dart';
import 'package:stepOut/features/auth/reset_password/repo/reset_password_repo.dart';

import '../../../../app/core/app_event.dart';
import '../../../../app/core/styles.dart';
import '../../../../app/core/text_styles.dart';
import '../../../../app/core/validation.dart';
import '../../../../app/localization/language_constant.dart';
import '../../../../components/animated_widget.dart';
import '../../../../components/custom_app_bar.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/custom_text_form_field.dart';
import '../../../../data/config/di.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key, required this.email});
  final String email;

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode passwordNode = FocusNode();
  final FocusNode confirmPasswordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordBloc(repo: sl<ResetPasswordRepo>()),
      child: BlocBuilder<ResetPasswordBloc, AppState>(
        builder: (context, state) {
          return Scaffold(
            appBar: const CustomAppBar(),
            body: Column(
              children: [
                Expanded(
                  child: ListAnimator(
                    customPadding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                        vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
                    data: [
                      Text(
                        getTranslated("reset_password_header"),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.semiBold.copyWith(
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        getTranslated("reset_password_description"),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.medium.copyWith(
                            fontSize: 14, color: Styles.DETAILS_COLOR),
                      ),
                      SizedBox(
                        height: Dimensions.PADDING_SIZE_DEFAULT.h,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            ///New Password
                            CustomTextField(
                              controller:
                                  context.read<ResetPasswordBloc>().passwordTEC,
                              label: getTranslated("new_password"),
                              hint: getTranslated("enter_new_password"),
                              focusNode: passwordNode,
                              inputType: TextInputType.visiblePassword,
                              validate: Validations.firstPassword,
                              isPassword: true,
                            ),

                            ///Confirm New Password
                            CustomTextField(
                              controller: context
                                  .read<ResetPasswordBloc>()
                                  .confirmPasswordTEC,
                              label: getTranslated("confirm_new_password"),
                              hint: getTranslated("enter_confirm_new_password"),
                              focusNode: confirmPasswordNode,
                              inputType: TextInputType.visiblePassword,
                              validate: (v) => Validations.confirmNewPassword(
                                  context
                                      .read<ResetPasswordBloc>()
                                      .passwordTEC
                                      .text
                                      .trim(),
                                  v),
                              isPassword: true,
                            ),

                            ///Confirm
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 16.h,
                              ),
                              child: CustomButton(
                                  text: getTranslated("submit"),
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      context
                                          .read<ResetPasswordBloc>()
                                          .add(Click(arguments: widget.email));
                                    }
                                  },
                                  isLoading: state is Loading),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
