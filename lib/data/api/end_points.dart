class EndPoints {
  static const String baseUrl = 'https://dashboard.stepoutnet.com/api/';
  static const String googleMapsBaseUrl = 'https://maps.googleapis.com';
  static const String imageUrl = 'https://dashboard.stepoutnet.com/';
  static const String apiKey =
      's7xrprFdw4G0F21rfLyD4TaBkjVJYgwGfI3y355yRnjw9zOggruX30eToVWvsASerert';
  static const String topic = 'stepOut';
  static const String logIn = 'login';
  static const String forgetPassword = 'resetPassword/email';
  static const String checkMailForResetPassword = 'resetPassword/checkCode';
  static const String resetPassword = 'resetPassword/newPassword';
  static changePassword(id) => 'client/changePassword/$id';
  static const String register = 'client';
  static const String resend = 'email/verification';
  static const String verifyEmail = 'check/verificationCode';
  static const String getProfile = 'client';
  static const String updateProfile = 'client';
  static const String deleteProfile = 'client/destroy';
  static getFavourites(id) => 'favorites/$id';
  static const String postFavourite = 'favorite';
  static const String ads = 'ads';
  static const String categories = 'categories';
  static const String offers = 'offers';
  static const String bestSeller = 'best_seller';
  static getItems(id) => 'categories/$id';
  static getRelatedItems(id) => 'related-items/$id';
  static getItemDetails(id) => 'items/$id';

  static const String areas = 'areas';
  static const String cities = 'cities';
  static getAddresses(id) => 'address/$id';
  static editAddresses(id) => 'address/$id';
  static deleteAddresses(id) => 'address/$id';
  static const String addAddress = 'add_address';

  static const String stores = 'stores';
  static getStoreDetails(id) => 'stores/$id';
  static const String services = 'service';
  static getServices(id) => 'subcategory/services/$id';
  static getCategoryDetails(id) => 'category/$id';
  static const String category = 'category';
  static const String searchPlaces = 'place/search';
  static getTagPlaces(id) => 'tag/places/$id';

  static const String aboutUs = 'about_us';
  static const String setting = 'setting';

  ///Notification
  static getNotifications(id) => 'notification/$id';
  static readNotification(userId, id) => 'notification/read/$userId/$id';
  static deleteNotification(userId, id) => 'notification/delete/$userId/$id';

  static const String sendRate = 'feedback';
  static const String nearPlaces = 'near/places';

  /// maps
  static const String GEOCODE_URI = '/maps/api/geocode/';
  static const String Autocomplete = '/maps/api/place/autocomplete/';
//https://maps.googleapis.com/maps/api/geocode/json?latlng=40.714224,-73.961452&key=AIzaSyB_l2x6zgnLTF4MKxX3S4Df9urLN6vLNP0
//'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=n,&key=AIzaSyB_l2x6zgnLTF4MKxX3S4Df9urLN6vLNP0
}
