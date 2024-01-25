import 'package:flutter/material.dart';
import 'package:stepOut/app/core/dimensions.dart';

import '../widgets/home_ads.dart';
import '../widgets/home_app_bar.dart';

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
            SizedBox(height: 24.h),
            const HomeAds(),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
