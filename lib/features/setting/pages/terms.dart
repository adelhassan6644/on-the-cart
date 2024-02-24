import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:stepOut/app/core/app_state.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/features/setting/model/setting_model.dart';
import '../../../app/core/dimensions.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_loading.dart';
import '../../../components/empty_widget.dart';
import '../bloc/setting_bloc.dart';

class Terms extends StatelessWidget {
  const Terms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getTranslated("terms_conditions"),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: BlocBuilder<SettingBloc, AppState>(
                builder: (context, state) {
                  if (state is Loading) {
                    return const CustomLoading();
                  }
                  if (state is Done) {
                    return ListAnimator(
                      customPadding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                      ),
                      data: [
                        SizedBox(
                          height: 16.h,
                        ),
                        HtmlWidget((state.model as SettingModel).data!.terms ??
                            "Terms"),
                        SizedBox(height: 16.h),
                      ],
                    );
                  }

                  if (state is Empty) {
                    return ListAnimator(
                      customPadding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                      ),
                      data: [
                        SizedBox(
                          height: 24.h,
                        ),
                        const EmptyState(),
                        SizedBox(height: 24.h),
                      ],
                    );
                  }
                  if (state is Error) {
                    return ListAnimator(
                      customPadding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                      ),
                      data: [
                        SizedBox(
                          height: 24.h,
                        ),
                        EmptyState(
                          txt: getTranslated("something_went_wrong"),
                        ),
                        SizedBox(height: 24.h),
                      ],
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
