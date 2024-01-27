import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/custom_app_bar.dart';
import 'package:stepOut/components/empty_widget.dart';
import 'package:stepOut/components/grid_list_animator.dart';
import 'package:stepOut/main_models/items_model.dart';
import 'package:stepOut/main_widgets/item_card.dart';

import '../../../app/core/app_state.dart';
import '../../../components/shimmer/custom_shimmer.dart';
import '../bloc/best_seller_bloc.dart';

class BestSellerPage extends StatelessWidget {
  const BestSellerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getTranslated("best_seller"),
      ),
      body: SafeArea(
          child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<BestSellerBloc, AppState>(
                  builder: (context, state) {
                if (state is Done) {
                  List<ItemModel> items =
                      (state.model as ItemsModel).data ?? [];
                  return GridListAnimatorWidget(
                      columnCount: 2,
                      aspectRatio: 100.w / 123.h,
                      items: List.generate(
                          items.length,
                          (i) => ItemCard(
                                item: items[i],
                              )));
                }
                if (state is Loading) {
                  return GridListAnimatorWidget(
                      columnCount: 2,
                      aspectRatio: 100.w / 123.h,
                      items: List.generate(
                        15,
                        (index) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: CustomShimmerContainer(
                            height: 200.h,
                            width: 195.w,
                            radius: 12,
                          ),
                        ),
                      ));
                }
                if (state is Empty) {
                  return const EmptyState();
                }
                if (state is Error) {
                  return EmptyState(
                    txt: getTranslated("something_went_wrong"),
                  );
                } else {
                  return GridListAnimatorWidget(
                      columnCount: 2,
                      aspectRatio: 100.w / 123.h,
                      items: List.generate(20, (i) => const ItemCard()));
                }
              }),
            )
          ],
        ),
      )),
    );
  }
}
