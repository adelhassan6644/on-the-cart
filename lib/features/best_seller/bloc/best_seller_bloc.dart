import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/core/app_core.dart';
import '../../../../app/core/app_event.dart';
import '../../../../app/core/app_notification.dart';
import '../../../../app/core/app_state.dart';
import '../../../../app/core/styles.dart';
import '../../../../data/error/failures.dart';
import '../../../main_models/items_model.dart';
import '../repo/best_seller_repo.dart';

class BestSellerBloc extends Bloc<AppEvent, AppState> {
  final BestSellerRepo repo;

  BestSellerBloc({required this.repo}) : super(Start()) {
    on<Click>(onClick);
  }

  Future<void> onClick(Click event, Emitter<AppState> emit) async {
    try {
      emit(Loading());

      Either<ServerFailure, Response> response = await repo.getItems();

      response.fold((fail) {
        AppCore.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.red));
        emit(Error());
      }, (success) {
        ItemsModel model = ItemsModel.fromJson(success.data);
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
              iconName: "fill-close-circle"));
      emit(Error());
    }
  }
}