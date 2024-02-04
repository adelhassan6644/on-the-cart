import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/features/related_items/repo/related_items_repo.dart';

import '../../../app/core/app_event.dart';
import '../../../app/core/app_state.dart';
import '../../../app/core/dimensions.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/shimmer/custom_shimmer.dart';
import '../../../data/config/di.dart';
import '../../../main_models/items_model.dart';
import '../../../main_widgets/item_card.dart';
import '../../../main_widgets/section_title.dart';
import '../bloc/related_items_bloc.dart';

class RelatedItemsView extends StatelessWidget {
  const RelatedItemsView({required this.id, super.key});
  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // create: (context) => RelatedItemsBloc(repo: sl<RelatedItemsRepo>())..add(Click(arguments: id)),
      create: (context) => RelatedItemsBloc(repo: sl<RelatedItemsRepo>()),
      child: BlocBuilder<RelatedItemsBloc, AppState>(builder: (context, state) {
        if (state is Done) {
          List<ItemModel> items = (state.model as ItemsModel).data ?? [];
          return Column(
            children: [
              SectionTitle(
                title: getTranslated("related_products"),
                withView: false,
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
                title: getTranslated("related_products"),
                withView: false,
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
