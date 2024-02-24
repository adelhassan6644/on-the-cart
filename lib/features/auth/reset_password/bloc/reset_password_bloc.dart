import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import '../../../../app/core/app_core.dart';
import '../../../../app/core/app_event.dart';
import '../../../../app/core/app_notification.dart';
import '../../../../app/core/app_state.dart';
import '../../../../app/core/images.dart';
import '../../../../app/core/styles.dart';
import '../../../../components/confirmation_dialog.dart';
import '../../../../components/custom_simple_dialog.dart';
import '../../../../data/error/failures.dart';
import '../../../../navigation/custom_navigation.dart';
import '../../../../navigation/routes.dart';
import '../repo/reset_password_repo.dart';

class ResetPasswordBloc extends Bloc<AppEvent, AppState> {
  final ResetPasswordRepo repo;
  ResetPasswordBloc({required this.repo}) : super(Start()) {
    on<Click>(_resetPassword);
  }

  TextEditingController currentPasswordTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();
  TextEditingController confirmPasswordTEC = TextEditingController();

  clear() {
    passwordTEC.clear();
    confirmPasswordTEC.clear();
  }

  _resetPassword(AppEvent event, Emitter emit) async {
    try {
      emit(Loading());
      Map<String, dynamic> data = {
        "email": event.arguments as String,
        "newPassword": passwordTEC.text.trim(),
      };

      Either<ServerFailure, Response> response = await repo.resetPassword(data);

      response.fold((fail) {
        AppCore.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.red));
        emit(Error());
      }, (success) {
        Future.delayed(
          Duration.zero,
          () => CustomSimpleDialog.parentSimpleDialog(
            canDismiss: false,
            icon: Images.success,
            customListWidget: ConfirmationDialog(
              title: getTranslated(
                "your_password_reset_successfully",
              ),
              description: getTranslated("your_password_reset_description"),
              withOneButton: true,
              txtBtn: getTranslated("login"),
              onContinue: () => CustomNavigator.push(Routes.login, clean: true),
            ),
          ),
        );
        // CustomNavigator.push(Routes.login, clean: true);
        clear();

        // AppCore.showSnackBar(
        //     notification: AppNotification(
        //         message: getTranslated("your_password_reset_successfully"),
        //         backgroundColor: Styles.ACTIVE,
        //         borderColor: Styles.ACTIVE,
        //         isFloating: true));
        emit(Done());
      });
    } catch (e) {
      AppCore.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Styles.RED_COLOR,
              iconName: "fill-close-circle"));
      emit(Error());
    }
  }
}
