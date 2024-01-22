import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/loading_dialog.dart';
import 'package:stepOut/features/notifications/model/notifications_model.dart';

import '../../../../app/core/app_core.dart';
import '../../../../app/core/app_event.dart';
import '../../../../app/core/app_notification.dart';
import '../../../../app/core/app_state.dart';
import '../../../../app/core/styles.dart';
import '../../../../data/error/failures.dart';
import '../../../data/config/di.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../navigation/custom_navigation.dart';
import '../repo/notifications_repo.dart';

class NotificationsBloc extends Bloc<AppEvent, AppState> {
  final NotificationsRepo repo;

  static NotificationsBloc get instance => sl<NotificationsBloc>();

  // bool goingDown = false;
  // scroll(controller) {
  //   controller.addListener(() {
  //     if (controller.position.userScrollDirection == ScrollDirection.forward) {
  //       goingDown = false;
  //       notifyListeners();
  //     } else {
  //       goingDown = true;
  //       notifyListeners();
  //     }
  //   });
  // }

  NotificationsBloc({required this.repo}) : super(Start()) {
    on<Get>(onGet);
    on<Read>(onRead);
  }

  bool get isLogin => repo.isLogin;

  NotificationsModel? model;

  Future<void> onGet(Get event, Emitter<AppState> emit) async {
    try {
      emit(Loading());
      Either<ServerFailure, Response> response = await repo.getNotifications();

      response.fold((fail) {
        AppCore.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(fail),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        emit(Error());
      }, (success) {
        model = NotificationsModel.fromJson(success.data["data"]);
        if (model?.data != null && model!.data!.isNotEmpty) {
          emit(Done(model: model));
        } else {
          emit(Empty());
        }
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

  Future<void> onRead(Read event, Emitter<AppState> emit) async {
    await repo.readNotification(event.arguments as String);
  }

  Future<void> onDelete(Delete event, Emitter<AppState> emit) async {
    try {
      loadingDialog();
      Either<ServerFailure, Response> response =
          await repo.deleteNotification(event.arguments as String);
      CustomNavigator.pop();

      response.fold((fail) {
        AppCore.showToast(fail.error);
      }, (success) {
        model!.data!.removeWhere((e) => e.id == (event.arguments as String));
        CustomNavigator.pop();
        AppCore.showToast(getTranslated("notification_deleted_successfully"));
        emit(Done(model: model));
      });
    } catch (e) {
      AppCore.showToast(e.toString());
    }
  }
}
