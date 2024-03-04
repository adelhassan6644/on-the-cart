import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/core/svg_images.dart';
import 'package:stepOut/app/core/validation.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/custom_button.dart';
import 'package:stepOut/features/send_feedback/repo/send_feedback_repo.dart';
import '../../../app/core/app_event.dart';
import '../../../app/core/app_state.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../data/config/di.dart';
import '../bloc/send_feedback_bloc.dart';

class SendFeedbackView extends StatelessWidget {
  const SendFeedbackView({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SendFeedbackBloc(repo: sl<SendFeedbackRepo>()),
      child: BlocBuilder<SendFeedbackBloc, AppState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StreamBuilder<int>(
                  stream: context.read<SendFeedbackBloc>().rattingStream,
                  builder: (context, snapShot) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        5,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: GestureDetector(
                            onTap: () => context
                                .read<SendFeedbackBloc>()
                                .updateRatting((index)),
                            child: customImageIconSVG(
                                width: 30,
                                height: 30,
                                imageName: (snapShot.data ?? -1) < index
                                    ? SvgImages.emptyStar
                                    : SvgImages.fillStar),
                          ),
                        ),
                      ),
                    );
                  }),
              SizedBox(height: 24.w),
              Form(
                key: context.read<SendFeedbackBloc>().globalKey,
                child: CustomTextField(
                  hint: getTranslated("enter_your_feedback"),
                  label: getTranslated("your_feedback"),
                  minLines: 5,
                  maxLines: 5,
                  controller: context.read<SendFeedbackBloc>().commentTEC,
                  validate: Validations.field,
                ),
              ),
              SizedBox(height: 24.h),
              CustomButton(
                isLoading: state is Loading,
                text: getTranslated("submit"),
                onTap: () =>
                    context.read<SendFeedbackBloc>().add(Click(arguments: id)),
              )
            ],
          );
        },
      ),
    );
  }
}
