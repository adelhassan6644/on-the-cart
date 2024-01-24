import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/app_state.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/core/extensions.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/animated_widget.dart';
import 'package:stepOut/components/custom_button.dart';
import '../../../app/core/svg_images.dart';
import '../../../app/core/text_styles.dart';
import '../../language/bloc/language_bloc.dart';
import '../widgets/more_options.dart';
import '../widgets/profile_card.dart';

class More extends StatelessWidget {
  const More({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, AppState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(

            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(
                  getTranslated( "welcome"
                   ,context: context),
                  maxLines: 1,
                  style: AppTextStyles.medium.copyWith(
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis,
                      color: Colors.black

                  )),
              Text(
                  getTranslated( "login_header"
                   ,context: context),
                  maxLines: 1,
                  style: AppTextStyles.medium.copyWith(
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                    color: Colors.black
                     )),
            ],),
            actions: [
              SizedBox(
                  width: 150.w,
                  child: CustomButton(
                      svgIcon: SvgImages.login, text: getTranslated("login"))),
              SizedBox(
                width: 5,
              )
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: ListAnimator(
                  customPadding: EdgeInsets.only(
                      top: (Dimensions.PADDING_SIZE_DEFAULT.h +
                          context.toPadding)),
                  data: const [
                    ProfileCard(),
                    MoreOptions(),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
