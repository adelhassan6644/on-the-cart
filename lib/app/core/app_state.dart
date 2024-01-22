import 'package:flutter/cupertino.dart';
import '../../components/custom_bottom_sheet.dart';
import '../../data/config/mapper.dart';

abstract class AppState {}

class Start extends AppState {}

class Done extends AppState {
  Mapper? model;
  List<Widget>? cards;
  List<CustomModelSheet>? list;
  bool? reload;
  bool? loading;
  dynamic data;
  Done(
      {this.model,
      this.data,
      this.cards,
      this.list,
      this.reload = true,
      this.loading = false});
}

class Error extends AppState {}

class Loading extends AppState {
  int? progress;
  int? total;
  Loading({this.progress, this.total});
}

class Empty extends AppState {
  final bool? initial;
  Empty({this.initial});
}
