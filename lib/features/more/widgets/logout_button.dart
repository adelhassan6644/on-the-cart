import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stepOut/app/core/app_state.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import 'package:stepOut/navigation/routes.dart';
import '../../../app/core/app_event.dart';
import '../../../app/core/dimensions.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/svg_images.dart';
import '../../../app/core/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_images.dart';
import '../bloc/logout_bloc.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogoutBloc, AppState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            if (LogoutBloc.instance.isLogin) {
              LogoutBloc.instance.add(Add());
            } else {
              CustomNavigator.push(Routes.LOGIN, arguments: true);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: Dimensions.PADDING_SIZE_SMALL.h,
                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
            decoration: const BoxDecoration(
                border: Border(
              top: BorderSide(
                color: Styles.BORDER_COLOR,
              ),
            )),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                customImageIconSVG(
                    imageName: SvgImages.logout,
                    height: 20,
                    width: 20,
                    color: LogoutBloc.instance.isLogin
                        ? Styles.ERORR_COLOR
                        : Styles.ACTIVE),
                const SizedBox(
                  width: 16,
                ),
                state is Loading
                    ? const SpinKitThreeBounce(
                        color: Styles.ERORR_COLOR,
                        size: 25,
                      )
                    : Expanded(
                        child: Text(
                            getTranslated(LogoutBloc.instance.isLogin
                                ? "logout"
                                : "login",context: context),
                            maxLines: 1,
                            style: AppTextStyles.medium.copyWith(
                                fontSize: 18,
                                overflow: TextOverflow.ellipsis,
                                color: LogoutBloc.instance.isLogin
                                    ? Styles.ERORR_COLOR
                                    : Styles.ACTIVE)),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
