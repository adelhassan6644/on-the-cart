import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/core/app_state.dart';
import '../../../app/core/dimensions.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/grid_list_animator.dart';
import '../../../components/shimmer/custom_shimmer.dart';
import '../../../main_models/items_model.dart';
import '../../../main_widgets/item_card.dart';
import '../../../main_widgets/section_title.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../bloc/best_seller_bloc.dart';

class HomeBestSellerView extends StatelessWidget {
  const HomeBestSellerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BestSellerBloc, AppState>(builder: (context, state) {
      if (state is Done) {
        List<ItemModel> items = (state.model as ItemsModel).data ?? [];
        return Column(
          children: [
            SectionTitle(
              title: getTranslated("best_seller"),
              onViewTap: () => CustomNavigator.push(Routes.bestSeller),
              withView: true,
            ),
            GridListAnimatorWidget(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                columnCount: 2,
                aspectRatio: 100.w / 123.h,
                items: List.generate(
                    items.length,
                    (i) => ItemCard(
                          item: items[i],
                        ))),
          ],
        );
      }
      if (state is Loading) {
        return Column(
          children: [
            const SectionTitleShimmer(),
            GridListAnimatorWidget(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                columnCount: 2,
                aspectRatio: 100.w / 123.h,
                items: List.generate(
                  10,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: CustomShimmerContainer(
                      height: 200.h,
                      width: 195.w,
                      radius: 12,
                    ),
                  ),
                )),
          ],
        );
      } else {
        return Column(
          children: [
            SectionTitle(
              title: getTranslated("best_seller"),
              onViewTap: () => CustomNavigator.push(Routes.bestSeller),
              withView: true,
            ),
            GridListAnimatorWidget(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                columnCount: 2,
                aspectRatio: 100.w / 123.h,
                items: List.generate(10, (i) => const ItemCard())),
          ],
        );
      }
    });
  }
}
