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
import '../../../main_page/bloc/dashboard_bloc.dart';
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
            ///Orders
            Visibility(
              visible: !UserBloc.instance.isLogin,
              child: MoreButton(
                title: getTranslated("orders_history"),
                icon: SvgImages.orders,
                onTap: () => CustomNavigator.push(Routes.orders),
              ),
            ),

            ///Favourites
            Visibility(
              visible: !UserBloc.instance.isLogin,
              child: MoreButton(
                title: getTranslated("wishlist"),
                icon: SvgImages.favorite,
                onTap: () => DashboardBloc.instance.updateSelectIndex(2),
              ),
            ),

            ///Notifications
            Visibility(
              visible: !UserBloc.instance.isLogin,
              child: MoreButton(
                title: getTranslated("notifications"),
                icon: SvgImages.notification,
                onTap: () => CustomNavigator.push(Routes.notifications),
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
                    widget: const LanguageBottomSheet(),
                    label: getTranslated("select_language"),
                    onConfirm: () {
                      CustomNavigator.pop();
                      LanguageBloc.instance.add(Update());
                    });
              },
            ),
          ],
        );
      },
    );
  }
}
