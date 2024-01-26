import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/shimmer/custom_shimmer.dart';
import 'package:stepOut/main_widgets/item_card.dart';

import '../../../app/core/app_state.dart';
import '../../../main_models/items_model.dart';
import '../../../main_widgets/section_title.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../bloc/offers_bloc.dart';

class HomeOffersView extends StatelessWidget {
  const HomeOffersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.h),
      padding: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
          color: const Color(0xFFffeaeb),
          borderRadius: BorderRadius.circular(20)),
      child: BlocBuilder<OffersBloc, AppState>(builder: (context, state) {
        if (state is Done) {
          List<ItemModel> items = (state.model as ItemsModel).data ?? [];
          return Column(
            children: [
              SectionTitle(
                title: getTranslated("offers_this_week"),
                onViewTap: () => CustomNavigator.push(Routes.offers),
                withView: true,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL.w),
                    ...List.generate(
                      items.length,
                      (i) => Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 8.h),
                        child: ItemCard(
                          item: items[i],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        }

        if (state is Loading) {
          return Column(
            children: [
              const SectionTitleShimmer(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL.w),
                    ...List.generate(
                      3,
                      (index) => Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 8.h),
                        child: CustomShimmerContainer(
                          height: 200.h,
                          width: 195.w,
                          radius: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        } else {
          return Column(
            children: [
              SectionTitle(
                title: getTranslated("offers_this_week"),
                onViewTap: () => CustomNavigator.push(Routes.offers),
                withView: true,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL.w),
                    ...List.generate(
                      4,
                      (i) => Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 8.h),
                        child: const ItemCard(),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        }
      }),
    );
  }
}
