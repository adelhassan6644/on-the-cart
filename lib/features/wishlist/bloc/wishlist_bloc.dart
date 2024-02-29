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
import '../repo/wishlist_repo.dart';

class WishlistBloc extends Bloc<AppEvent, AppState> {
  final WishlistRepo repo;

  WishlistBloc({required this.repo}) : super(Start()) {
    on<Click>(onClick);
    on<Update>(onUpdate);
  }

  bool get isLogin => repo.isLogin;


  ItemsModel? model;
  Future<void> onClick(Click event, Emitter<AppState> emit) async {
    try {
      emit(Loading());

      Either<ServerFailure, Response> response = await repo.getWishlist();

      response.fold(
        (fail) {
          AppCore.showSnackBar(
              notification: AppNotification(
                  message: fail.error,
                  isFloating: true,
                  backgroundColor: Styles.IN_ACTIVE,
                  borderColor: Colors.red));
          emit(Error());
        },
        (success) {
          model = ItemsModel.fromJson(success.data);
          if (model?.data != null && model!.data!.isNotEmpty) {
            emit(Done(model: model));
          } else {
            emit(Empty());
          }
        },
      );
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

  Future<void> onUpdate(Update event, Emitter<AppState> emit) async {
    try {
      Map data = event.arguments as Map;
      Either<ServerFailure, Response> response =
          await repo.updateWishlist((data["item"] as ItemModel).id);

      response.fold((fail) {
        AppCore.showToast(fail.error);
      }, (success) {
        if (data["isFav"]) {
          model?.data
              ?.removeWhere((e) => e.id == (data["item"] as ItemModel).id);
        } else {
          model?.data?.add((data["item"] as ItemModel));
        }
        emit(Done(model: model));
      });
    } catch (e) {
      AppCore.showToast(e.toString());
    }
  }
}
