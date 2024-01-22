import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/app_state.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/core/extensions.dart';
import 'package:stepOut/components/animated_widget.dart';
import '../../../../app/core/app_event.dart';
import '../../../../app/core/styles.dart';
import '../../../../app/core/text_styles.dart';
import '../../../../app/core/validation.dart';
import '../../../../app/localization/language_constant.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/custom_text_form_field.dart';
import '../../../../navigation/custom_navigation.dart';
import '../../../../navigation/routes.dart';
import '../bloc/login_bloc.dart';

class LoginBodyWidget extends StatefulWidget {
  const LoginBodyWidget({super.key});

  @override
  State<LoginBodyWidget> createState() => _LoginBodyWidgetState();
}

class _LoginBodyWidgetState extends State<LoginBodyWidget> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, AppState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(top: context.toPadding + 160.h),
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
              vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
          decoration: const BoxDecoration(
              color: Styles.WHITE_COLOR,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          child: BlocBuilder<LoginBloc, AppState>(
            builder: (context, state) {
              return ListAnimator(
                data: [
                  SizedBox(
                    height: Dimensions.PADDING_SIZE_DEFAULT.h,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          ///Mail
                          CustomTextField(
                            controller: context.read<LoginBloc>().mailTEC,
                            focusNode: emailNode,
                            label: getTranslated("mail"),
                            hint: getTranslated("enter_your_mail"),
                            withLabel: true,
                            inputType: TextInputType.emailAddress,
                            validate: Validations.mail,
                          ),

                          ///Password
                          CustomTextField(
                            controller: context.read<LoginBloc>().passwordTEC,
                            keyboardAction: TextInputAction.done,
                            label: getTranslated("password"),
                            hint: getTranslated("enter_your_password"),
                            withLabel: true,
                            focusNode: passwordNode,
                            inputType: TextInputType.visiblePassword,
                            validate: Validations.password,
                            isPassword: true,
                          ),

                          ///Forget Password && Remember me
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL.h,
                                horizontal:
                                    Dimensions.PADDING_SIZE_EXTRA_SMALL.w),
                            child: Row(
                              children: [
                                StreamBuilder<bool?>(
                                  stream: context
                                      .read<LoginBloc>()
                                      .rememberMeStream,
                                  builder: (_, snapshot) {
                                    return _RememberMe(
                                      check: snapshot.data ?? false,
                                      onChange: (v) => context
                                          .read<LoginBloc>()
                                          .updateRememberMe(v),
                                    );
                                  },
                                ),
                                InkWell(
                                  onTap: () {
                                    context.read<LoginBloc>().clear();
                                    CustomNavigator.push(
                                        Routes.FORGET_PASSWORD);
                                  },
                                  child: Text(
                                    getTranslated("forget_password"),
                                    style: AppTextStyles.medium.copyWith(
                                      color: Styles.HEADER,
                                      fontSize: 12,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Styles.HEADER,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 24.h,
                            ),
                            child: CustomButton(
                                text: getTranslated("login"),
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<LoginBloc>().add(Click());
                                  }
                                },
                                isLoading: state is Loading),
                          ),
                        ],
                      )),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class _RememberMe extends StatelessWidget {
  const _RememberMe({
    Key? key,
    this.check = false,
    required this.onChange,
  }) : super(key: key);
  final bool check;
  final Function(bool) onChange;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            onTap: () => onChange(!check),
            child: Container(
              width: 18.w,
              height: 18.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: check ? Styles.PRIMARY_COLOR : Styles.WHITE_COLOR,
                  border: Border.all(
                      color:
                          check ? Styles.PRIMARY_COLOR : Styles.DETAILS_COLOR,
                      width: 1)),
              child: check
                  ? const Icon(
                      Icons.check,
                      color: Styles.WHITE_COLOR,
                      size: 14,
                    )
                  : null,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              getTranslated("remember_me"),
              maxLines: 1,
              style: AppTextStyles.medium.copyWith(
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis,
                  color: check ? Styles.PRIMARY_COLOR : Styles.DETAILS_COLOR),
            ),
          ),
        ],
      ),
    );
  }
}
