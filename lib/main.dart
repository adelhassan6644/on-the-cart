import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:stepOut/app/core/app_state.dart';
import 'package:stepOut/features/language/bloc/language_bloc.dart';
import 'app/core/app_storage_keys.dart';
import 'app/core/un_focus.dart';
import 'app/localization/app_localization.dart';
import 'app/notifications/notification_helper.dart';
import 'app/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app/core/app_strings.dart';
import 'data/config/provider.dart';
import 'navigation/custom_navigation.dart';
import 'package:stepOut/data/config/di.dart' as di;

import 'navigation/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseNotifications.setUpFirebase();
  await di.init();
  runApp(MultiBlocProvider(
      providers: ProviderList.providers, child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<Locale> locals = [];
    for (var language in AppStorageKey.languages) {
      locals.add(Locale(language.languageCode!, language.countryCode));
    }

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light));

    return BlocBuilder<LanguageBloc, AppState>(
      builder: (context, state) {
        return MaterialApp(
          builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.0)),
              child: UnFocus(child: child!)),
          initialRoute: Routes.SPLASH,
          navigatorKey: CustomNavigator.navigatorState,
          onGenerateRoute: CustomNavigator.onCreateRoute,
          navigatorObservers: [CustomNavigator.routeObserver],
          title: AppStrings.appName,
          scaffoldMessengerKey: CustomNavigator.scaffoldState,
          debugShowCheckedModeBanner: false,
          theme: light,
          supportedLocales: locals,
          locale: LanguageBloc.instance.selectLocale != null
              ? LanguageBloc.instance.selectLocale!
              : const Locale('en', 'US'),
          localizationsDelegates: const [
            AppLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        );
      },
    );
  }
}
