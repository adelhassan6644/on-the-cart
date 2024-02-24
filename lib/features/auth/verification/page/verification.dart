import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/app_state.dart';
import 'package:stepOut/features/auth/verification/bloc/verification_bloc.dart';
import 'package:stepOut/features/auth/verification/model/verification_model.dart';

import '../../../../app/core/app_event.dart';
import '../../../../app/core/dimensions.dart';
import '../../../../app/core/styles.dart';
import '../../../../app/core/text_styles.dart';
import '../../../../app/core/validation.dart';
import '../../../../app/localization/language_constant.dart';
import '../../../../components/animated_widget.dart';
import '../../../../components/count_down.dart';
import '../../../../components/custom_app_bar.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/custom_pin_code_field.dart';
import '../../../../data/config/di.dart';
import '../repo/verification_repo.dart';

class Verification extends StatefulWidget {
  const Verification({Key? key, required this.model}) : super(key: key);
  final VerificationModel model;

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerificationBloc(repo: sl<VerificationRepo>()),
      child: BlocBuilder<VerificationBloc, AppState>(
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
                        getTranslated("verify_header"),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.semiBold.copyWith(
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        getTranslated("verify_description"),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.medium.copyWith(
                          color: Styles.DETAILS_COLOR,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.PADDING_SIZE_DEFAULT.h,
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Dimensions.PADDING_SIZE_LARGE.w),
                                    child: CustomPinCodeField(
                                        validation: Validations.code,
                                        controller: context
                                            .read<VerificationBloc>()
                                            .codeTEC,
                                        onChanged: (v) {}),
                                  )),
                              SizedBox(
                                height: 8.h,
                              ),
                              CountDown(
                                onCount: () => context
                                    .read<VerificationBloc>()
                                    .add(Resend(arguments: widget.model)),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 16.h,
                                ),
                                child: CustomButton(
                                    text: getTranslated("submit"),
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<VerificationBloc>().add(
                                            Click(arguments: widget.model));
                                      }
                                    },
                                    isLoading: state is Loading),
                              ),
                            ],
                          )),
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
