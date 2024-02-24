import '../../features/maps/models/location_model.dart';

class AppStrings {
  static const String appName = 'On the cart';
  static const String googleApiKey = 'AIzaSyA2xA7d84QkR0_0OPjdDRLfu--YbjJkSa8';
  static const String defaultAddress = 'المملكة العربية السعودية ، الرياض';
  static const String defaultLat = '24.67401824245781';
  static const String defaultLong = '46.691234707832336';

  static LocationModel defaultPickUp = LocationModel(
      address: defaultAddress, longitude: defaultLong, latitude: defaultLat);

  static const String fontFamily = 'ar';
  static const String noRouteFound = 'No Route Found';
  static const String cachedRandomQuote = 'CACHED_RANDOM_QUOTE';
  static const String contentType = 'Content-Type';
  static const String applicationJson = 'application/json';
  static const String serverFailure = 'Server Failure';
  static const String cacheFailure = 'Cache Failure';
  static const String unexpectedError = 'Unexpected Error';
  static const String englishCode = 'en';
  static const String arabicCode = 'ar';
  static const String locale = 'locale';
  static const String guestTopic = 'guest';
}
