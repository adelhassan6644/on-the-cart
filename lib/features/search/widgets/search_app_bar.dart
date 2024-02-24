import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/app_state.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/core/svg_images.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/custom_button.dart';
import 'package:stepOut/components/custom_images.dart';
import 'package:stepOut/components/custom_text_form_field.dart';
import 'package:stepOut/navigation/custom_navigation.dart';

import '../../../app/core/app_core.dart';
import '../../../app/core/app_event.dart';
import '../../../app/core/app_notification.dart';
import '../../../app/core/styles.dart';
import '../../../components/back_icon.dart';
import '../../../navigation/routes.dart';
import '../bloc/search_bloc.dart';

class SearchAppBar extends StatefulWidget {
  const SearchAppBar({super.key});

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, AppState>(
      builder: (context, state) {
        return SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              Dimensions.PADDING_SIZE_DEFAULT.w,
              0,
              Dimensions.PADDING_SIZE_DEFAULT.w,
              Dimensions.PADDING_SIZE_DEFAULT.h,
            ),
            child: Row(
              children: [
                const FilteredBackIcon(),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL.w),
                    child: CustomTextField(
                      hint: getTranslated("search_for_what_you_want"),
                      controller: context.read<SearchBloc>().searchTEC,
                      prefixIcon:
                          customImageIconSVG(imageName: SvgImages.search),
                      onChanged: (v) {
                        if (timer != null) if (timer!.isActive) timer!.cancel();
                        timer = Timer(const Duration(milliseconds: 100), () {
                          context.read<SearchBloc>().add(Click());
                        });
                      },
                      onSubmit: (v) {
                        context.read<SearchBloc>().add(Click());
                      },
                    ),
                  ),
                ),
                CustomButton(
                  height: 50,
                  width: 100,
                  text: getTranslated("search"),
                  onTap: () {
                    if (context
                        .read<SearchBloc>()
                        .searchTEC
                        .text
                        .trim()
                        .isEmpty) {
                      AppCore.showSnackBar(
                          notification: AppNotification(
                        message: getTranslated("search_for_what_you_want"),
                        backgroundColor: Styles.IN_ACTIVE,
                        borderColor: Styles.RED_COLOR,
                      ));
                    } else {
                      CustomNavigator.push(Routes.searchResult,
                          arguments:
                              context.read<SearchBloc>().searchTEC.text.trim());
                    }
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
