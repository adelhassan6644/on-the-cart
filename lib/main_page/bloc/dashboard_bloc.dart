import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../app/core/app_event.dart';
import '../../app/core/app_state.dart';
import '../../data/config/di.dart';

class DashboardBloc extends Bloc<AppEvent, AppState> {
  DashboardBloc() : super(Start()) {
    updateSelectIndex(0);
  }

  static DashboardBloc get instance => sl<DashboardBloc>();

  final selectIndex = BehaviorSubject<int>();
  Function(int) get updateSelectIndex => selectIndex.sink.add;
  Stream<int> get selectIndexStream => selectIndex.stream.asBroadcastStream();
}
