import 'package:carousel_slider/carousel_controller.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../app/core/app_core.dart';
import '../../../../app/core/app_event.dart';
import '../../../../app/core/app_notification.dart';
import '../../../../app/core/app_state.dart';
import '../../../../app/core/styles.dart';
import '../../../../data/error/failures.dart';
import '../models/ads_model.dart';
import '../repo/home_repo.dart';

class HomeAdsBloc extends Bloc<AppEvent, AppState> {
  final HomeRepo repo;

  HomeAdsBloc({required this.repo}) : super(Start()) {
    on<Click>(onClick);
  }

  CarouselController bannerController = CarouselController();

  BehaviorSubject<int> index = BehaviorSubject();
  Function(int) get updateIndex => index.sink.add;
  Stream<int> get indexStream => index.stream.asBroadcastStream();

  Future<void> onClick(Click event, Emitter<AppState> emit) async {
    try {
      emit(Loading());

      Either<ServerFailure, Response> response = await repo.getHomeAds();

      response.fold((fail) {
        AppCore.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.red));
        emit(Error());
      }, (success) {
        AdsModel model = AdsModel.fromJson(success.data);
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
