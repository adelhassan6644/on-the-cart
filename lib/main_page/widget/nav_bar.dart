import 'package:flutter/material.dart';
import 'package:stepOut/app/core/extensions.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import '../../app/core/styles.dart';
import '../../app/core/svg_images.dart';
import '../bloc/dashboard_bloc.dart';
import 'nav_bar_item.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: DashboardBloc.instance.selectIndexStream,
        builder: (context, snapshot) {
          return Container(
              height: 80,
              width: context.width,
              decoration: BoxDecoration(color: Styles.WHITE_COLOR, boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, -3),
                    spreadRadius: 3,
                    blurRadius: 20)
              ]),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: BottomNavBarItem(
                        label: getTranslated("more", context: context),
                        svgIcon: SvgImages.moreIcon,
                        width: 15,
                        height: 19,
                        isSelected: (snapshot.data ?? 0) == 4,
                        onTap: () =>
                            DashboardBloc.instance.updateSelectIndex(4),
                      ),
                    ),
                    Expanded(
                      child: BottomNavBarItem(
                        label: getTranslated("cart", context: context),
                        svgIcon: SvgImages.cartIcon,
                        isSelected: (snapshot.data ?? 0) == 2,
                        onTap: () =>
                            DashboardBloc.instance.updateSelectIndex(2),
                      ),
                    ),
                    Expanded(
                      child: BottomNavBarItem(
                        label: getTranslated("dashboard", context: context),
                        svgIcon: SvgImages.homeIcon,
                        isSelected: (snapshot.data ?? 0) == 0,
                        onTap: () =>
                            DashboardBloc.instance.updateSelectIndex(0),
                      ),
                    ),
                    Expanded(
                      child: BottomNavBarItem(
                        label: getTranslated("favorite", context: context),
                        svgIcon: SvgImages.favorite,
                        isSelected: (snapshot.data ?? 0) == 3,
                        onTap: () =>
                            DashboardBloc.instance.updateSelectIndex(3),
                      ),
                    ),
                    Expanded(
                      child: BottomNavBarItem(
                        label: getTranslated("categories", context: context),
                        svgIcon: SvgImages.categoryIcon,
                        isSelected: (snapshot.data ?? 0) == 1,
                        onTap: () =>
                            DashboardBloc.instance.updateSelectIndex(1),
                      ),
                    ),
                  ]));
        });
  }
}
