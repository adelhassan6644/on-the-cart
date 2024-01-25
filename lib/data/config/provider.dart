import 'package:stepOut/data/config/di.dart' as di;
import 'package:flutter_bloc/src/bloc_provider.dart'
    show BlocProvider, BlocProviderSingleChildWidget;

import 'package:stepOut/main_blocs/user_bloc.dart';

import '../../app/core/app_event.dart';
import '../../features/home/bloc/home_ads_bloc.dart';
import '../../features/language/bloc/language_bloc.dart';
import '../../features/maps/bloc/map_bloc.dart';
import '../../features/more/bloc/logout_bloc.dart';
import '../../features/notifications/bloc/notifications_bloc.dart';
import '../../features/notifications/bloc/turn_notification_bloc.dart';
import '../../features/profile/bloc/profile_bloc.dart';
import '../../features/setting/bloc/setting_bloc.dart';

abstract class ProviderList {
  static List<BlocProviderSingleChildWidget> providers = [
    BlocProvider<LanguageBloc>(
        create: (_) => di.sl<LanguageBloc>()..add(Init())),
    BlocProvider<SettingBloc>(create: (_) => di.sl<SettingBloc>()),
    BlocProvider<LogoutBloc>(create: (_) => di.sl<LogoutBloc>()),
    BlocProvider<ProfileBloc>(create: (_) => di.sl<ProfileBloc>()),
    BlocProvider<UserBloc>(create: (_) => di.sl<UserBloc>()),
    BlocProvider<MapBloc>(create: (_) => di.sl<MapBloc>()),
    BlocProvider<NotificationsBloc>(create: (_) => di.sl<NotificationsBloc>()),
    BlocProvider<TurnNotificationsBloc>(
        create: (_) => di.sl<TurnNotificationsBloc>()),
    BlocProvider<HomeAdsBloc>(create: (_) => di.sl<HomeAdsBloc>()),
  ];
}
