import 'package:flutter/material.dart';
import 'package:stepOut/features/more/page/more.dart';
import 'package:stepOut/features/offers/bloc/offers_bloc.dart';
import 'package:stepOut/main_blocs/user_bloc.dart';
import '../../app/core/app_event.dart';
import '../../app/core/styles.dart';
import '../../data/config/di.dart';
import '../../data/network/network_info.dart';
import '../../features/best_seller/bloc/best_seller_bloc.dart';
import '../../features/cart/page/cart.dart';
import '../../features/categories/bloc/categories_bloc.dart';
import '../../features/categories/page/categories.dart';
import '../../features/home/bloc/home_ads_bloc.dart';
import '../../features/home/page/home.dart';
import '../../features/edit_profile/bloc/profile_bloc.dart';
import '../../features/stores/bloc/stores_bloc.dart';
import '../../features/wishlist/bloc/wishlist_bloc.dart';
import '../../features/wishlist/page/wishlist.dart';
import '../bloc/dashboard_bloc.dart';
import '../widget/nav_bar.dart';

class DashBoard extends StatefulWidget {
  final int? index;
  const DashBoard({this.index, super.key});
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
    if (widget.index != null) {
      DashboardBloc.instance.updateSelectIndex(widget.index!);
    }
    sl<HomeAdsBloc>().add(Click());
    sl<CategoriesBloc>().add(Click());
    sl<StoresBloc>().add(Click());
    sl<BestSellerBloc>().add(Click());
    sl<OffersBloc>().add(Click());

    if (UserBloc.instance.isLogin) {
      UserBloc.instance.add(Click());
      sl<ProfileBloc>().add(Get());
      sl<WishlistBloc>().add(Click());
    }
    NetworkInfo.checkConnectivity(onVisible: initData);
    super.initState();
  }

  initData() {
    Future.delayed(Duration.zero, () {
      // UserBloc.instance.add(Click());
      // sl<HomeProvider>().getCategories();
      // sl<HomeProvider>().getOffers();
      // if (UserBloc.instance.isLogin) {
      //   sl<ProfileBloc>().add(Get());
      // }
    });
  }

  Widget fragment(int index) {
    switch (index) {
      case 0:
        return const Home();
      case 1:
        return const Categories();
      case 2:
        return const Wishlist();
      case 3:
        return const Cart();
      case 4:
        return const More();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: DashboardBloc.instance.selectIndexStream,
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: Styles.BACKGROUND_COLOR,
            bottomNavigationBar: const NavBar(),
            body: fragment(snapshot.hasData ? snapshot.data! : 0),
          );
        });
  }
}
