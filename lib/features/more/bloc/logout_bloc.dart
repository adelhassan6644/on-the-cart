import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/features/notifications/model/notifications_model.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import '../../../../app/core/app_event.dart';
import '../../../../app/core/app_state.dart';
import '../../../data/config/di.dart';
import '../../../navigation/routes.dart';
import '../../profile/repo/profile_repo.dart';

class LogoutBloc extends Bloc<AppEvent, AppState> {
  final ProfileRepo repo;

  static LogoutBloc get instance => sl<LogoutBloc>();

  LogoutBloc({required this.repo}) : super(Start()) {
    on<Add>(onAdd);
  }

  bool get isLogin => repo.isLogin;

  NotificationsModel? model;

  Future<void> onAdd(Add event, Emitter<AppState> emit) async {
    emit(Loading());
    await repo.clearCache();
    CustomNavigator.push(Routes.SPLASH, clean: true);
    emit(Done());
  }
}
