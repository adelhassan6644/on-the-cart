import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stepOut/features/auth/registar/page/register.dart';
import 'package:stepOut/features/auth/registar/repo/register_repo.dart';
import '../../app/theme/theme_provider/theme_provider.dart';
import '../../features/auth/forget_password/repo/forget_password_repo.dart';
import '../../features/auth/login/repo/login_repo.dart';
import '../../features/auth/reset_password/repo/reset_password_repo.dart';
import '../../features/auth/verification/repo/verification_repo.dart';
import '../../features/edit_profile/repo/edit_profile_repo.dart';
import '../../features/home/bloc/home_ads_bloc.dart';
import '../../features/home/repo/home_repo.dart';
import '../../features/language/bloc/language_bloc.dart';
import '../../features/language/repo/language_repo.dart';
import '../../features/maps/bloc/map_bloc.dart';
import '../../features/maps/repo/maps_repo.dart';
import '../../features/more/bloc/logout_bloc.dart';
import '../../features/notifications/bloc/notifications_bloc.dart';
import '../../features/notifications/bloc/turn_notification_bloc.dart';
import '../../features/notifications/repo/notifications_repo.dart';
import '../../features/profile/bloc/profile_bloc.dart';
import '../../features/profile/repo/profile_repo.dart';
import '../../features/setting/bloc/setting_bloc.dart';
import '../../features/setting/repo/setting_repo.dart';
import '../../features/splash/bloc/splash_bloc.dart';
import '../../main_blocs/user_bloc.dart';
import '../../main_page/bloc/dashboard_bloc.dart';
import '../../main_repos/download_repo.dart';
import '../../main_repos/user_repo.dart';
import '../api/end_points.dart';
import '../network/network_info.dart';
import '../dio/dio_client.dart';
import '../dio/logging_interceptor.dart';
import '../../features/splash/repo/splash_repo.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => NetworkInfo(sl()));
  sl.registerLazySingleton(() => DioClient(
        EndPoints.baseUrl,
        dio: sl(),
        loggingInterceptor: sl(),
        sharedPreferences: sl(),
      ));

  // Repository
  sl.registerLazySingleton(() => LocalizationRepo(sharedPreferences: sl(), dioClient: sl()));

  sl.registerLazySingleton(() => DownloadRepo());

  sl.registerLazySingleton(() => SplashRepo(sharedPreferences: sl(), dioClient: sl()));

  sl.registerLazySingleton(() => UserRepo(sharedPreferences: sl(), dioClient: sl()));

  sl.registerLazySingleton(() => LoginRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(() => RegisterRepo(sharedPreferences: sl(), dioClient: sl()));

  sl.registerLazySingleton(() => VerificationRepo(sharedPreferences: sl(), dioClient: sl()));

  sl.registerLazySingleton(() => ForgetPasswordRepo(sharedPreferences: sl(), dioClient: sl()));

  sl.registerLazySingleton(() => ResetPasswordRepo(sharedPreferences: sl(), dioClient: sl()));

  sl.registerLazySingleton(() => ProfileRepo(sharedPreferences: sl(), dioClient: sl()));

  sl.registerLazySingleton(() => EditProfileRepo(sharedPreferences: sl(), dioClient: sl()));

  sl.registerLazySingleton(() => MapRepo(sharedPreferences: sl(), dioClient: sl()));

  sl.registerLazySingleton(() => SettingRepo(sharedPreferences: sl(), dioClient: sl()));

  sl.registerLazySingleton(() => NotificationsRepo(sharedPreferences: sl(), dioClient: sl()));

  sl.registerLazySingleton(() => HomeRepo(sharedPreferences: sl(), dioClient: sl()));

  //provider
  // sl.registerLazySingleton(() => SplashBloc(repo: sl()));
  sl.registerLazySingleton(() => LanguageBloc(repo: sl()));
  sl.registerLazySingleton(() => ThemeProvider(sharedPreferences: sl()));
  sl.registerLazySingleton(() => DashboardBloc());
  sl.registerLazySingleton(() => LogoutBloc(repo: sl()));

  sl.registerLazySingleton(() => ProfileBloc(repo: sl()));
  sl.registerLazySingleton(() => SettingBloc(repo: sl()));
  sl.registerLazySingleton(() => UserBloc(repo: sl()));
  sl.registerLazySingleton(() => NotificationsBloc(repo: sl()));
  sl.registerLazySingleton(() => TurnNotificationsBloc(repo: sl()));
  sl.registerLazySingleton(() => MapBloc(repo: sl()));
  sl.registerLazySingleton(() => HomeAdsBloc(repo: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}
