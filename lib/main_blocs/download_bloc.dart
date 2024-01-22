import 'dart:io';
import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';

import '../../../helpers/permissions.dart';
import '../app/core/app_event.dart';
import '../app/core/app_state.dart';
import '../main_repos/download_repo.dart';

class DownloadBloc extends Bloc<AppEvent, AppState> {
  final DownloadRepo repo;
  DownloadBloc({required this.repo}) : super(Start()) {
    on<Click>(_download);
  }
  void _download(AppEvent event, Emitter<AppState> emit) async {
    if (await PermissionHandler.checkFilePermission()) {
      emit(Loading(progress: 0, total: 100));
      String url = event.arguments as String;
      String path = "";
      if (Platform.isAndroid) {
        path =
            '${await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS)}/LiveChat/live.${url.split("/").last}';
      } else {
        Directory documents = await getApplicationDocumentsDirectory();
        path = '${documents.path}/LiveChat/live.${url.split("/").last}';
      }
      try {
        Response res = repo.download(
          url: url,
          path: path,
          onReceiveProgress: (progress, total) {
            emit(Loading(progress: progress.abs(), total: total.abs()));
            // if (total.abs() >= 100) {
            //   emit(Done());
            // }
          },
        );
        if (res.statusCode == 200) {
          await OpenFilex.open(path);
          emit(Done());
        } else {
          emit(Error());
        }
      } catch (e) {
        emit(Error());
      }
    }
  }
}
