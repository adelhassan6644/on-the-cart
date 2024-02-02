import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/app_state.dart';
import 'package:stepOut/app/core/dimensions.dart';
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
  final FocusNode nameNode = FocusNode();
  final FocusNode phoneNode = FocusNode();
  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();
  final FocusNode confirmPasswordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<RegisterBloc, AppState>(
        builder: (context, state) {
          return ListAnimator(
            customPadding: EdgeInsets.symmetric(
              vertical: Dimensions.PADDING_SIZE_DEFAULT.h,
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
            ),
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
                        controller: context.read<RegisterBloc>().nameTEC,
                        focusNode: nameNode,
                        nextFocus: phoneNode,
                        label: getTranslated("name"),
                        hint: getTranslated("enter_your_name"),
                        inputType: TextInputType.name,
                        validate: Validations.name,
                      ),

                      ///phone
                      CustomTextField(
                        controller: context.read<RegisterBloc>().phoneTEC,
                        focusNode: phoneNode,
                        nextFocus: emailNode,
                        label: getTranslated("phone"),
                        hint: getTranslated("enter_your_phone"),
                        inputType: TextInputType.phone,
                        validate: Validations.phone,
                      ),

                      ///Mail
                      CustomTextField(
                        controller: context.read<RegisterBloc>().mailTEC,
                        focusNode: emailNode,
                        nextFocus: passwordNode,
                        label: getTranslated("mail"),
                        hint: getTranslated("enter_your_mail"),
                        inputType: TextInputType.emailAddress,
                        validate: Validations.mail,
                      ),

                      ///Password
                      CustomTextField(
                        controller: context.read<RegisterBloc>().passwordTEC,
                        label: getTranslated("password"),
                        hint: getTranslated("enter_your_password"),
                        withLabel: true,
                        focusNode: passwordNode,
                        nextFocus: confirmPasswordNode,
                        inputType: TextInputType.visiblePassword,
                        validate: Validations.password,
                        isPassword: true,
                      ),

                      ///Confirm Password
                      CustomTextField(
                        controller:
                            context.read<RegisterBloc>().confirmPasswordTEC,
                        label: getTranslated("confirm_password"),
                        hint: getTranslated("enter_your_password"),
                        focusNode: confirmPasswordNode,
                        keyboardAction: TextInputAction.done,
                        inputType: TextInputType.visiblePassword,
                        validate: Validations.password,
                        isPassword: true,
                      ),

                      ///Agree to terms and conditions
                      StreamBuilder<bool?>(
                        stream: context.read<RegisterBloc>().rememberMeStream,
                        builder: (_, snapshot) {
                          return _AgreeToTerms(
                            check: snapshot.data ?? false,
                            onChange: (v) => context
                                .read<RegisterBloc>()
                                .updateRememberMe(v),
                          );
                        },
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
  }
}

class _AgreeToTerms extends StatelessWidget {
  const _AgreeToTerms({
    Key? key,
    this.check = false,
    required this.onChange,
  }) : super(key: key);
  final bool check;
  final Function(bool) onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.w, 12.h, 8.w, 8.h),
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
          SizedBox(width: 8.w),
          Text(
            getTranslated("i_agree_to"),
            style: AppTextStyles.regular
                .copyWith(fontSize: 14, color: Styles.DETAILS_COLOR),
          ),
          Expanded(
            child: InkWell(
              onTap: () => CustomNavigator.push(Routes.terms),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              child: Text(
                " ${getTranslated("terms_conditions")}",
                maxLines: 1,
                style: AppTextStyles.semiBold.copyWith(
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis,
                    decoration: TextDecoration.underline,
                    color: Styles.PRIMARY_COLOR),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
