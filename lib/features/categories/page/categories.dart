import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/custom_app_bar.dart';
import 'package:stepOut/components/empty_widget.dart';
import 'package:stepOut/components/grid_list_animator.dart';
import 'package:stepOut/features/categories/widgets/category_card.dart';

import '../../../app/core/app_state.dart';
import '../../../components/shimmer/custom_shimmer.dart';
import '../bloc/categories_bloc.dart';
import '../model/categories_model.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getTranslated("categories"),
        withBack: false,
      ),
      body: SafeArea(
          child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<CategoriesBloc, AppState>(
                  builder: (context, state) {
                if (state is Done) {
                  List<CategoryItem> categories =
                      (state.model as CategoriesModel).data ?? [];
                  return GridListAnimatorWidget(
                      columnCount: 3,
                      aspectRatio: 100.w / 101.h,
                      items: List.generate(
                          categories.length,
                          (i) => CategoryCard(
                                category: categories[i],
                              )));
                }
                if (state is Loading) {
                  return GridListAnimatorWidget(
                      columnCount: 3,
                      aspectRatio: 100.w / 101.h,
                      items: List.generate(
                        3,
                        (index) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: CustomShimmerContainer(
                            height: 112.h,
                            width: 100.w,
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
                      columnCount: 3,
                      aspectRatio: 100.w / 101.h,
                      items: List.generate(20, (i) => const CategoryCard()));
                }
              }),
            )
          ],
        ),
      )),
    );
  }
}
