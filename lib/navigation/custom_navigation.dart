import 'package:stepOut/features/add_address/page/add_address_page.dart';
import 'package:stepOut/features/addresses/model/addresses_model.dart';
import 'package:stepOut/features/addresses/page/addresses_page.dart';
import 'package:stepOut/features/best_seller/page/best_seller_page.dart';
import 'package:stepOut/features/check_out/page/check_out_page.dart';
import 'package:stepOut/features/order_details/page/order_details_page.dart';
import 'package:stepOut/features/orders/page/orders_page.dart';
import 'package:stepOut/features/notifications/page/notifications.dart';
import 'package:stepOut/features/offers/page/offers_page.dart';
import 'package:flutter/material.dart';
import 'package:stepOut/features/stores/page/stores_page.dart';
import 'package:stepOut/main_models/base_model.dart';
import '../features/auth/forget_password/page/forget_password.dart';
import '../features/auth/login/page/login.dart';
import '../features/auth/register/page/register.dart';
import '../features/auth/reset_password/page/reset_password.dart';
import '../features/auth/verification/model/verification_model.dart';
import '../features/auth/verification/page/verification.dart';
import '../features/change_password/page/change_password_page.dart';
import '../features/edit_profile/page/edit_profile.dart';
import '../features/item_details/page/item_details_page.dart';
import '../features/items/page/items_page.dart';
import '../features/on_boarding/pages/on_boarding.dart';
import '../features/search/page/search_page.dart';
import '../features/search_result/page/search_result_page.dart';
import '../features/setting/pages/about_us.dart';
import '../features/setting/pages/terms.dart';
import '../features/splash/page/splash.dart';
import '../main.dart';
import '../main_page/page/dashboard.dart';
import 'routes.dart';

abstract class CustomNavigator {
  static final GlobalKey<NavigatorState> navigatorState =
      GlobalKey<NavigatorState>();
  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();
  static final GlobalKey<ScaffoldMessengerState> scaffoldState =
      GlobalKey<ScaffoldMessengerState>();

  static Route<dynamic> onCreateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.app:
        return _pageRoute(const MyApp());
      case Routes.splash:
        return _pageRoute(const Splash());
      case Routes.onBoarding:
        return _pageRoute(const OnBoarding());
      case Routes.login:
        return _pageRoute(Login(
          fromMain:
              settings.arguments != null ? settings.arguments as bool : false,
        ));
      case Routes.forgetPassword:
        return _pageRoute(const ForgetPassword());
      case Routes.resetPassword:
        return _pageRoute(ResetPassword(
          email: settings.arguments as String,
        ));

      case Routes.register:
        return _pageRoute(const Register());

      case Routes.changePassword:
        return _pageRoute(const ChangePasswordPage());

      case Routes.verification:
        return _pageRoute(
            Verification(model: settings.arguments as VerificationModel));


      case Routes.editProfile:
        return _pageRoute(const EditProfile());

      case Routes.dashboard:
        return _pageRoute(DashBoard(
          index:
              settings.arguments != null ? (settings.arguments as int) : null,
        ));

      // case Routes.MAP:
      //   return _pageRoute(MapPage(
      //       baseModel: settings.arguments != null
      //           ? settings.arguments as BaseModel
      //           : null));

      case Routes.notifications:
        return _pageRoute(const Notifications());

      case Routes.addresses:
        return _pageRoute(const AddressesPage());

      case Routes.addAddress:
        return _pageRoute(AddAddressPage(
          address: settings.arguments != null
              ? settings.arguments as AddressItem
              : null,
        ));

      case Routes.stores:
        return _pageRoute(const StoresPage());

      case Routes.bestSeller:
        return _pageRoute(const BestSellerPage());

      case Routes.offers:
        return _pageRoute(const OffersPage());

      case Routes.items:
        return _pageRoute(ItemsPage(
          model: settings.arguments as BaseModel,
        ));

      case Routes.itemDetails:
        return _pageRoute(ItemDetailsPage(
          id: settings.arguments as int,
        ));

      case Routes.aboutUs:
        return _pageRoute(const AboutUs());

      case Routes.orders:
        return _pageRoute(const OrdersPage());

      case Routes.orderDetails:
        return _pageRoute(OrderDetailsPage(
          id: settings.arguments as int,
        ));

      case Routes.checkOut:
        return _pageRoute(const CheckOutPage());

      case Routes.search:
        return _pageRoute(const SearchPage());

      case Routes.searchResult:
        return _pageRoute(SearchResultPage(
          search: settings.arguments as String,
        ));

      case Routes.terms:
        return _pageRoute(const Terms());

      default:
        return MaterialPageRoute(builder: (_) => const MyApp());
    }
  }

  static PageRouteBuilder<dynamic> _pageRoute(Widget child) => PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 100),
      reverseTransitionDuration: const Duration(milliseconds: 100),
      transitionsBuilder: (c, anim, a2, child) {
        var begin = const Offset(1.0, 0.0);
        var end = Offset.zero;
        var tween = Tween(begin: begin, end: end);
        var curveAnimation =
            CurvedAnimation(parent: anim, curve: Curves.linearToEaseOut);
        return SlideTransition(
          position: tween.animate(curveAnimation),
          child: child,
        );
      },
      opaque: false,
      pageBuilder: (_, __, ___) => child);

  static pop({dynamic result}) {
    if (navigatorState.currentState!.canPop()) {
      navigatorState.currentState!.pop(result);
    }
  }

  static push(String routeName,
      {arguments, bool replace = false, bool clean = false}) {
    if (clean) {
      return navigatorState.currentState!.pushNamedAndRemoveUntil(
          routeName, (_) => false,
          arguments: arguments);
    } else if (replace) {
      return navigatorState.currentState!.pushReplacementNamed(
        routeName,
        arguments: arguments,
      );
    } else {
      return navigatorState.currentState!
          .pushNamed(routeName, arguments: arguments);
    }
  }
}
