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
import '../bloc/register_bloc.dart';

class RegisterBodyWidget extends StatefulWidget {
  const RegisterBodyWidget({super.key});

  @override
  State<RegisterBodyWidget> createState() => _RegisterBodyWidgetState();
}

class _RegisterBodyWidgetState extends State<RegisterBodyWidget> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, AppState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(top: context.toPadding),
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
              vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
          decoration: const BoxDecoration(
              color: Styles.WHITE_COLOR,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          child: BlocBuilder<RegisterBloc, AppState>(
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
                          ///name
                          CustomTextField(
                            controller: context.read<RegisterBloc>().mailTEC,
                            focusNode: emailNode,
                            label: getTranslated("name"),
                            hint: getTranslated("enter_your_name"),
                            withLabel: true,
                            inputType: TextInputType.emailAddress,
                            validate: Validations.mail,
                          ),
                          ///phone
                          CustomTextField(
                            controller: context.read<RegisterBloc>().mailTEC,
                            focusNode: emailNode,
                            label: getTranslated("phone"),
                            hint: getTranslated("enter_your_phone"),
                            withLabel: true,
                            inputType: TextInputType.emailAddress,
                            validate: Validations.mail,
                          ),
                          ///Mail
                          CustomTextField(
                            controller: context.read<RegisterBloc>().mailTEC,
                            focusNode: emailNode,
                            label: getTranslated("mail"),
                            hint: getTranslated("enter_your_mail"),
                            withLabel: true,
                            inputType: TextInputType.emailAddress,
                            validate: Validations.mail,
                          ),

                          ///Password
                          CustomTextField(
                            controller: context.read<RegisterBloc>().passwordTEC,
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
                                      .read<RegisterBloc>()
                                      .rememberMeStream,
                                  builder: (_, snapshot) {
                                    return _RememberMe(
                                      check: snapshot.data ?? false,
                                      onChange: (v) => context
                                          .read<RegisterBloc>()
                                          .updateRememberMe(v),
                                    );
                                  },
                                ),

                              ],
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 24.h,
                            ),
                            child: CustomButton(
                                text: getTranslated("signup"),
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<RegisterBloc>().add(Click());
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
