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
import '../../../../navigation/custom_navigation.dart';
import '../../../../navigation/routes.dart';
import '../../verification/model/verification_model.dart';

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
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                  vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        getTranslated("forget_password_header"),
                        textAlign: TextAlign.start,
                        style: AppTextStyles.semiBold.copyWith(
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    getTranslated("forget_password_description"),
                    textAlign: TextAlign.start,
                    style: AppTextStyles.semiBold.copyWith(
                      fontSize: 14,
                    ),
                  ),
                  ListAnimator(
                    data: [
                      SizedBox(
                        height: Dimensions.PADDING_SIZE_DEFAULT.h,
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                controller:
                                    context.read<ForgetPasswordBloc>().mailTEC,
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
                                      if (_formKey.currentState!.validate()) {
                                        CustomNavigator.push(Routes.VERIFICATION,
                                            replace: true,
                                            arguments:
                                            VerificationModel(context
                                                .read<ForgetPasswordBloc>()
                                                .mailTEC
                                                .text, fromRegister: false));

                                        // context
                                        //     .read<ForgetPasswordBloc>()
                                        //     .add(Click());
                                      }
                                    },
                                    isLoading: state is Loading),
                              ),
                            ],
                          )),
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
