import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stepOut/components/loading_dialog.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import '../../../../app/core/app_event.dart';
import '../../../../app/core/app_state.dart';

class ShareItemDetailsBloc extends Bloc<AppEvent, AppState> {
  ShareItemDetailsBloc() : super(Start()) {
    on<Click>(onClick);
  }

  Future<void> onClick(Click event, Emitter<AppState> emit) async {
    spinKitDialog();
    emit(Loading());
    String link = "https://ebrandstepout.page.link/${event.arguments as int}";
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse(link),
      uriPrefix: "https://ebrandstepout.page.link",
      androidParameters: const AndroidParameters(
        packageName: "com.eBrandstepOut.stepOut",
      ),
      iosParameters: const IOSParameters(
        bundleId: "com.eBrandstepOut.stepOut",
        appStoreId: "6451453145",
      ),
    );
    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);
    String shareLink =
        Uri.decodeFull(Uri.decodeComponent(dynamicLink.toString()));
    CustomNavigator.pop();
    emit(Done());
    await Share.share(shareLink);
  }
}
