import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../app/core/app_core.dart';
import '../app/core/app_event.dart';
import '../app/core/app_notification.dart';
import '../app/core/app_state.dart';
import '../app/core/styles.dart';
import '../data/config/di.dart';
import '../data/error/api_error_handler.dart';
import '../data/error/failures.dart';
import '../main_models/user_model.dart';
import '../main_repos/user_repo.dart';

class UserBloc extends Bloc<AppEvent, AppState> {
  final UserRepo repo;

  static UserBloc get instance => sl<UserBloc>();

  UserBloc({required this.repo}) : super(Start()) {
    on<Click>(onClick);
    on<Delete>(onDelete);
  }

  bool get isLogin => repo.isLogIn;
  UserModel? user;

  onClick(Click event, Emitter<AppState> emit) async {
    try {
      emit(Loading());

      Either<ServerFailure, UserModel> response = repo.getUser();

      response.fold((fail) {
        AppCore.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(fail),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        emit(Error());
      }, (success) {
        user = success;
        emit(Done(model: user));
      });
    } catch (e) {
      AppCore.showSnackBar(
        notification: AppNotification(
          message: e.toString(),
          backgroundColor: Styles.IN_ACTIVE,
          borderColor: Styles.RED_COLOR,
          iconName: "fill-close-circle",
        ),
      );
      emit(Error());
    }
  }

  onDelete(Delete event, Emitter<AppState> emit) async {
    user = null;
    emit(Done());
  }
}
