import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/app_state.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/core/validation.dart';
import 'package:flutter/material.dart';
import 'package:stepOut/components/custom_app_bar.dart';
import 'package:stepOut/features/edit_profile/repo/profile_repo.dart';
import '../../../app/core/app_event.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../data/config/di.dart';
import '../bloc/edit_profile_bloc.dart';
import '../../../main_widgets/profile_image_widget.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode nameNode = FocusNode();
  final FocusNode mailNode = FocusNode();
  final FocusNode phoneNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EditProfileBloc(repo: sl<ProfileRepo>())..add(Init()),
      child: BlocBuilder<EditProfileBloc, AppState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar(
              title: getTranslated("edit_profile"),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  StreamBuilder<File?>(
                      stream:
                          context.read<EditProfileBloc>().profileImageStream,
                      builder: (context, snapshot) {
                        return ProfileImageWidget(
                          onGet: context
                              .read<EditProfileBloc>()
                              .updateProfileImage,
                          imageFile: snapshot.hasData ? snapshot.data! : null,
                          withEdit: true,
                        );
                      }),
                  BlocBuilder<EditProfileBloc, AppState>(
                    builder: (context, state) {
                      return Expanded(
                        child: ListAnimator(
                          customPadding: EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                            vertical: Dimensions.PADDING_SIZE_DEFAULT.h,
                          ),
                          data: [
                            Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    ///Name
                                    CustomTextField(
                                      controller: context
                                          .read<EditProfileBloc>()
                                          .nameTEC,
                                      keyboardAction: TextInputAction.next,
                                      label: getTranslated("name"),
                                      hint: getTranslated("enter_your_name"),
                                      withLabel: true,
                                      focusNode: nameNode,
                                      inputType: TextInputType.name,
                                      validate: Validations.name,
                                    ),

                                    ///Phone
                                    CustomTextField(
                                      controller: context
                                          .read<EditProfileBloc>()
                                          .phoneTEC,
                                      keyboardAction: TextInputAction.next,
                                      label: getTranslated("phone"),
                                      hint: getTranslated("enter_your_phone"),
                                      withLabel: true,
                                      focusNode: phoneNode,
                                      inputType: TextInputType.phone,
                                      validate: Validations.phone,
                                    ),

                                    ///Mail
                                    CustomTextField(
                                      controller: context
                                          .read<EditProfileBloc>()
                                          .mailTEC,
                                      keyboardAction: TextInputAction.done,
                                      label: getTranslated("mail"),
                                      hint: getTranslated("enter_your_mail"),
                                      withLabel: true,
                                      isEnabled: false,
                                      focusNode: mailNode,
                                      inputType: TextInputType.emailAddress,
                                      validate: Validations.mail,
                                    ),

                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 24.h,
                                      ),
                                      child: CustomButton(
                                          text: getTranslated("save"),
                                          onTap: () {
                                            context
                                                .read<EditProfileBloc>()
                                                .add(Click());
                                          },
                                          isLoading: state is Loading),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      );
                    },
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
