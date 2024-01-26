import 'package:flutter/material.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/components/animated_widget.dart';

import '../../../app/core/styles.dart';
import '../../best_seller/view/best_seller_view.dart';
import '../../offers/view/home_offers_view.dart';
import '../widgets/home_ads.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_categories.dart';
import '../widgets/home_stores.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: const Color(0xFFFAF6F3),
      body: SafeArea(
        child: Column(
          children: [
            const HomeAppBar(),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Styles.WHITE_COLOR,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20))),
                child: ListAnimator(
                  data: [
                    SizedBox(height: 24.h),
                    const HomeAds(),
                    const HomeCategories(),
                    const HomeOffersView(),
                    const HomeStores(),
                    const HomeBestSellerView(),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
