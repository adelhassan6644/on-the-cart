class EndPoints {
  static const String baseUrl = 'https://ecommerce.softwarecloud2.com/api/';
  static const String googleMapsBaseUrl = 'https://maps.googleapis.com';
  static const String imageUrl = 'https://ecommerce.softwarecloud2.com/';
  static const String apiKey =
      's7xrprFdw4G0F21rfLyD4TaBkjVJYgwGfI3y355yRnjw9zOggruX30eToVWvsASerert';
  static const String topic = 'stepOut';
  static const String forgetPassword = 'reset-password-email';
  static const String checkMailForResetPassword = 'reset-password-check-code';
  static const String resetPassword = 'new-password';
  static changePassword(id) => 'change-password/$id';
  static const String logIn = 'login';
  static const String register = 'register';
  static const String resend = 'send-verification-email';
  static const String verifyEmail = 'check-verification-code';
  static getProfile(id) => 'customer/$id';
  static updateProfile(id) => 'customer/$id';
  static deleteProfile(id) => 'customer/destroy/$id';
  static getFavourites(id) => 'favorites/$id';
  static const String postFavourite = 'favorite';
  static const String ads = 'slider';
  static const String categories = 'categories';
  static const String offers = 'offers';
  static const String bestSeller = 'best_seller';
  static getItems(id) => 'categories/$id';
  static getRelatedItems(id) => 'related-items/$id';
  static getItemDetails(id) => 'items/$id';

  static const String areas = 'areas';
  static const String cities = 'cities';
  static getAddresses(id) => 'customer/address/$id';
  static editAddresses(id) => 'address/update/$id';
  static deleteAddresses(id) => 'address/destroy/$id';
  static const String addAddress = 'address';

  static const String stores = 'stores';
  static getStoreDetails(id) => 'stores/$id';
  static const String services = 'service';
  static getServices(id) => 'subcategory/services/$id';
  static getCategoryDetails(id) => 'category/$id';
  static const String category = 'category';
  static const String searchPlaces = 'place/search';
  static getMyOrders(id) => 'my-orders/$id';
  static getOrderDetails(id) => 'order-details/$id';

  static const String search = 'search';
  static const String checkOut = 'checkOut';

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
