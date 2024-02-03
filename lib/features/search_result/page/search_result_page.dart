import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/custom_app_bar.dart';
import 'package:stepOut/features/search_result/bloc/search_result_bloc.dart';
import 'package:stepOut/features/search_result/repo/search_result_repo.dart';

import '../../../app/core/app_state.dart';
import '../../../app/core/dimensions.dart';
import '../../../components/empty_widget.dart';
import '../../../components/grid_list_animator.dart';
import '../../../components/shimmer/custom_shimmer.dart';
import '../../../data/config/di.dart';
import '../../../main_models/items_model.dart';
import '../../../main_widgets/item_card.dart';

class SearchResultPage extends StatelessWidget {
  const SearchResultPage({super.key, required this.search});
  final String search;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getTranslated("search_result"),
      ),
      body: BlocProvider(
        create: (context) => SearchResultBloc(repo: sl<SearchResultRepo>()),
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<SearchResultBloc, AppState>(
                    builder: (context, state) {
                  if (state is Done) {
                    List<ItemModel> items =
                        (state.model as ItemsModel).data ?? [];
                    return GridListAnimatorWidget(
                        columnCount: 2,
                        aspectRatio: 100.w / 120.h,
                        items: List.generate(
                            items.length,
                            (i) => ItemCard(
                                  item: items[i],
                                )));
                  }
                  if (state is Loading) {
                    return GridListAnimatorWidget(
                        columnCount: 2,
                        aspectRatio: 100.w / 120.h,
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
                        aspectRatio: 100.w / 120.h,
                        items: List.generate(20, (i) => const ItemCard()));
                  }
                }),
              )
            ],
          ),
        )),
      ),
    );
  }
}
