import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import 'package:stepOut/navigation/routes.dart';
import '../../../app/core/app_event.dart';
import '../../../app/core/app_state.dart';
import '../../../helpers/permissions.dart';
import '../repo/splash_repo.dart';

class SplashBloc extends Bloc<AppEvent, AppState> {
  final SplashRepo repo;
  SplashBloc({required this.repo}) : super(Start()) {
    on<Click>(onClick);
  }

  Future<void> onClick(AppEvent event, Emitter<AppState> emit) async {
    Future.delayed(const Duration(milliseconds: 1800), () async {
      // SettingBloc.instance.add(Get());
      if (!repo.isLogin) {
        await repo.guestMode();
      }

      ///Ask Notification Permission
      await PermissionHandler.checkNotificationsPermission();

      if (repo.isFirstTime) {
        CustomNavigator.push(Routes.onBoarding, clean: true);
      }
      // else if (!repo.isLogin) {
      //   CustomNavigator.push(Routes.LOGIN, clean: true);
      // }
      else {
        CustomNavigator.push(Routes.dashboard, clean: true, arguments: 0);
      }
      repo.setFirstTime();
    });
  }
}
