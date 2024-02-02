import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/components/loading_dialog.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import '../../../../app/core/app_core.dart';
import '../../../../app/core/app_event.dart';
import '../../../../app/core/app_notification.dart';
import '../../../../app/core/app_state.dart';
import '../../../../app/core/styles.dart';
import '../../../../data/error/failures.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../main_blocs/user_bloc.dart';
import '../../../navigation/routes.dart';
import '../repo/profile_repo.dart';

class DeleteProfileBloc extends Bloc<AppEvent, AppState> {
  final ProfileRepo repo;

  DeleteProfileBloc({required this.repo}) : super(Start()) {
    on<Delete>(onDelete);
  }

  Future<void> onDelete(Delete event, Emitter<AppState> emit) async {
    try {
      loadingDialog();
      emit(Loading());
      Either<ServerFailure, Response> response = await repo.deleteAcc();
      CustomNavigator.pop();
      response.fold((fail) {
        AppCore.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(fail),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        emit(Error());
      }, (success) {
        UserBloc.instance.add(Delete());
        CustomNavigator.push(Routes.splash, clean: true);
        emit(Done());
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
}
