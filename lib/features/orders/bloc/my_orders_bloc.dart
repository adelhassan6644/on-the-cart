import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stepOut/app/core/svg_images.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import '../../../../app/core/app_core.dart';
import '../../../../app/core/app_event.dart';
import '../../../../app/core/app_notification.dart';
import '../../../../app/core/app_state.dart';
import '../../../../app/core/styles.dart';
import '../../../../data/error/failures.dart';
import '../model/orders_model.dart';
import '../repo/orders_repo.dart';

class OrdersBloc extends Bloc<AppEvent, AppState> {
  final OrdersRepo repo;

  OrdersBloc({required this.repo}) : super(Start()) {
    on<Click>(onClick);
  }

  final currentTab = BehaviorSubject<int?>();
  Function(int?) get updateCurrentTab => currentTab.sink.add;
  Stream<int?> get currentTabStream => currentTab.stream.asBroadcastStream();

  List<String> tabTitles = [
    getTranslated("running_orders"),
    getTranslated("last_orders"),
    getTranslated("cancel_orders"),
  ];

  List<String> tabIcons = [
    SvgImages.runningOrder,
    SvgImages.lastOrder,
    SvgImages.cancelOrder,
  ];

  Future<void> onClick(Click event, Emitter<AppState> emit) async {
    try {
      emit(Loading());

      Either<ServerFailure, Response> response =
          await repo.getMyOrders(event.arguments as int);

      response.fold((fail) {
        AppCore.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.red));
        emit(Error());
      }, (success) {
        OrdersModel model = OrdersModel.fromJson(success.data);
        if (model.data != null && model.data!.isNotEmpty) {
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
      ));
      emit(Error());
    }
  }
}
