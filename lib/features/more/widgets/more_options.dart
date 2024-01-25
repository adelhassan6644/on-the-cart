import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/app_state.dart';
import 'package:stepOut/features/more/widgets/turn_button.dart';
import 'package:stepOut/features/notifications/bloc/notifications_bloc.dart';
import '../../../app/core/app_event.dart';
import '../../../app/core/svg_images.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_bottom_sheet.dart';
import '../../../main_blocs/user_bloc.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../../language/bloc/language_bloc.dart';
import '../../language/page/language_bottom_sheet.dart';
import '../../notifications/bloc/turn_notification_bloc.dart';
import 'more_button.dart';

class MoreOptions extends StatelessWidget {
  const MoreOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, AppState>(
      builder: (context, state) {
        return Column(
          children: [
            ///Profile
            Visibility(
              visible: UserBloc.instance.isLogin,
              child: MoreButton(
                title: getTranslated("profile"),
                icon: SvgImages.userIcon,
                onTap: () => CustomNavigator.push(Routes.PROFILE),
              ),
            ),

            ///Orders
            Visibility(
              visible: !UserBloc.instance.isLogin,
              child: MoreButton(
                title: getTranslated("orders_history"),
                icon: SvgImages.orders,
                onTap: () => CustomNavigator.push(Routes.PROFILE),
              ),
            ),

            ///Favourites
            Visibility(
              visible: !UserBloc.instance.isLogin,
              child: MoreButton(
                title: getTranslated("favorite"),
                icon: SvgImages.favorite,
                onTap: () => CustomNavigator.push(Routes.PROFILE),
              ),
            ),

            ///Notifications
            Visibility(
              visible: !UserBloc.instance.isLogin,
              child: MoreButton(
                title: getTranslated("notifications"),
                icon: SvgImages.notification,
                onTap: () => CustomNavigator.push(Routes.NOTIFICATIONS),
              ),
            ),

            ///Turn Notification
            BlocBuilder<TurnNotificationsBloc, AppState>(
              builder: (context, state) {
                return Visibility(
                  visible: NotificationsBloc.instance.isLogin,
                  child: TurnButton(
                    title: getTranslated("notifications", context: context),
                    icon: SvgImages.notification,
                    onTap: () => TurnNotificationsBloc.instance.add(Turn()),
                    bing: TurnNotificationsBloc.instance.isTurnOn,
                    isLoading: state is Loading,
                  ),
                );
              },
            ),

            ///Language
            MoreButton(
              title: getTranslated("language", context: context),
              icon: SvgImages.language,
              onTap: () {
                LanguageBloc.instance.add(Init());
                CustomBottomSheet.show(
                    height: 450,
                    list: const LanguageBottomSheet(),
                    label: getTranslated("select_language"),
                    onConfirm: () {
                      CustomNavigator.pop();
                      LanguageBloc.instance.add(Update());
                    });
              },
            ),

            // ///Contact with us
            // MoreButton(
            //   title: getTranslated("contact_with_us", context: context),
            //   icon: SvgImages.contactWithUs,
            //   // onTap: () => CustomNavigator.push(Routes.CONTACT_WITH_US),
            // ),

            ///Terms and Conditions
            MoreButton(
              title: getTranslated("terms_conditions", context: context),
              icon: SvgImages.terms,
              onTap: () => CustomNavigator.push(Routes.TERMS),
            ),

            ///About US
            MoreButton(
              title: getTranslated("more_about_us", context: context),
              icon: SvgImages.infoSquare,
              onTap: () => CustomNavigator.push(Routes.ABOUT_US),
            ),

          ],
        );
      },
    );
  }
}
