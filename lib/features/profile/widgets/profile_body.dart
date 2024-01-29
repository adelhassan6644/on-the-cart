import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/app_state.dart';
import 'package:stepOut/components/custom_button.dart';
import 'package:stepOut/components/custom_images.dart';
import 'package:stepOut/main_blocs/user_bloc.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import 'package:stepOut/navigation/routes.dart';

import '../../../app/core/dimensions.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/svg_images.dart';
import '../../../app/core/text_styles.dart';
import '../../../app/core/validation.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_text_form_field.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, AppState>(
      builder: (context, state) {
        return Container(
          margin:
              EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT.w),
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
              vertical: Dimensions.PADDING_SIZE_DEFAULT.h),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              CustomTextField(
                controller: context.read<UserBloc>().nameTEC,

                label: getTranslated("name"),
                hint: getTranslated("enter_your_name"),
                inputType: TextInputType.name,
                validate: Validations.name,
              ),

              ///phone
              CustomTextField(
                controller: context.read<UserBloc>().phoneTEC,

                label: getTranslated("phone"),
                hint: getTranslated("enter_your_phone"),
                inputType: TextInputType.phone,
                validate: Validations.phone,
              ),

              ///Mail
              CustomTextField(
                controller: context.read<UserBloc>().mailTEC,

                label: getTranslated("mail"),
                hint: getTranslated("enter_your_mail"),
                inputType: TextInputType.emailAddress,
                validate: Validations.mail,
              ),

              CustomButton(text:getTranslated("save"), )



            ],
          ),
        );
      },
    );
  }
}
