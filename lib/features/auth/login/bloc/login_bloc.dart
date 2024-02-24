import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stepOut/features/auth/verification/model/verification_model.dart';

import '../../../../app/core/app_core.dart';
import '../../../../app/core/app_event.dart';
import '../../../../app/core/app_notification.dart';
import '../../../../app/core/app_state.dart';
import '../../../../app/core/styles.dart';
import '../../../../app/localization/language_constant.dart';
import '../../../../data/error/failures.dart';
import '../../../../navigation/custom_navigation.dart';
import '../../../../navigation/routes.dart';
import '../repo/login_repo.dart';

class LoginBloc extends Bloc<AppEvent, AppState> {
  final rememberMe = BehaviorSubject<bool?>();

  final LoginRepo repo;
  LoginBloc({required this.repo}) : super(Start()) {
    updateRememberMe(false);
    on<Click>(onClick);
    on<Remember>(onRemember);
  }

  TextEditingController mailTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();

  Function(bool?) get updateRememberMe => rememberMe.sink.add;

  Stream<bool?> get rememberMeStream => rememberMe.stream.asBroadcastStream();

  clear() {
    mailTEC.clear();
    passwordTEC.clear();
    updateRememberMe(null);
  }

  @override
  Future<void> close() {
    updateRememberMe(false);
    return super.close();
  }

  Future<void> onClick(Click event, Emitter<AppState> emit) async {
    try {
      emit(Loading());
      Map<String, dynamic> data = {
        "email": mailTEC.text.trim(),
        "password": passwordTEC.text.trim(),
      };

      Either<ServerFailure, Response> response = await repo.logIn(data);

      response.fold((fail) {
        AppCore.showSnackBar(
            notification: AppNotification(
                message: getTranslated("invalid_credentials"),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        emit(Error());
      }, (success) {
        ///To Remember
        if (rememberMe.value == true) {
          repo.saveCredentials(data);
        } else {
          repo.forgetCredentials();
        }

        if (success.data['data']["email_verified_at"] != null) {
          CustomNavigator.push(Routes.dashboard, clean: true);
          AppCore.showSnackBar(
            notification: AppNotification(
              message: getTranslated("logged_in_successfully"),
              backgroundColor: Styles.ACTIVE,
              borderColor: Styles.ACTIVE,
            ),
          );
        } else {
          CustomNavigator.push(Routes.verification,
              arguments: VerificationModel(mailTEC.text.trim()));
          AppCore.showSnackBar(
            notification: AppNotification(
              message: success.data?["message"] ?? "",
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Styles.RED_COLOR,
            ),
          );
        }
        clear();
        emit(Done());
      });
    } catch (e) {
      AppCore.showSnackBar(
        notification: AppNotification(
          message: e.toString(),
          backgroundColor: Styles.IN_ACTIVE,
          borderColor: Styles.RED_COLOR,
        ),
      );
      emit(Error());
    }
  }

  Future<void> onRemember(Remember event, Emitter<AppState> emit) async {
    Map<String, dynamic>? data = repo.getCredentials();
    if (data != null) {
      passwordTEC.text = data["password"];
      mailTEC.text = data["email"];
      updateRememberMe(data["email"] != "" && data["email"] != null);
      emit(Done());
    }
  }
}
