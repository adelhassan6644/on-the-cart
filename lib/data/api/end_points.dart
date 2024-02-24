class EndPoints {
  static const String baseUrl = 'https://ecommerce.softwarecloud2.com/api/';
  static const String googleMapsBaseUrl = 'https://maps.googleapis.com';
  static const String imageUrl = 'https://ecommerce.softwarecloud2.com/';
  static const String apiKey =
      's7xrprFdw4G0F21rfLyD4Tasdwe123JYgwGfI3y355yRnjw9zOggruX30eToVWvsASerert';
  static const String topic = 'on-the-cart';

  ///Auth
  static const String forgetPassword = 'reset-password-email';
  static const String checkMailForResetPassword = 'reset-password-check-code';
  static const String resetPassword = 'new-password';
  static changePassword(id) => 'change-password/$id';
  static const String logIn = 'login';
  static const String register = 'register';
  static const String resend = 'send-verification-email';
  static const String verifyEmail = 'check-verification-code';

  ///Profile
  static getProfile(id) => 'customer/$id';
  static updateProfile(id) => 'customer/$id';
  static deleteProfile(id) => 'customer/destroy/$id';

  ///Favourite
  static getFavourites(id) => 'favorites/$id';
  static const String postFavourite = 'favorite';

  ///Home data
  static const String ads = 'slider';
  static const String categories = 'category';
  static const String offers = 'product/Week/offers';
  static const String bestSeller = 'product/best/selling';

  static const String stores = 'brand';
  static getStoreDetails(id) => 'brand/$id';

  static const String category = 'category';
  static getCategoryDetails(id) => 'category/$id';

  ///Items
  static getRelatedItems(id) => 'product/related/$id';
  static getItemDetails(id) => 'product/$id';
  static const String sendRate = 'feedback';

  ///Addresses
  static const String areas = 'areas';
  static const String cities = 'cities';
  static getAddresses(id) => 'customer/address/$id';
  static editAddresses(id) => 'address/update/$id';
  static deleteAddresses(id) => 'address/destroy/$id';
  static const String addAddress = 'address';

  ///Order
  static getMyOrders(id) => 'order/$id';
  static getOrderDetails(id) => 'order/show/$id';

  ///Search
  static const String search = 'product/search';
  static const String checkOut = 'checkOut';

  ///Setting
  static const String aboutUs = 'about_us';
  static const String setting = 'setting';

  ///Notification
  static getNotifications(id) => 'notification/$id';
  static readNotification(userId, id) => 'notification/read/$userId/$id';
  static deleteNotification(userId, id) => 'notification/delete/$userId/$id';

  /// maps
  static const String GEOCODE_URI = '/maps/api/geocode/';
  static const String Autocomplete = '/maps/api/place/autocomplete/';
//https://maps.googleapis.com/maps/api/geocode/json?latlng=40.714224,-73.961452&key=AIzaSyB_l2x6zgnLTF4MKxX3S4Df9urLN6vLNP0
//'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=n,&key=AIzaSyB_l2x6zgnLTF4MKxX3S4Df9urLN6vLNP0
}
