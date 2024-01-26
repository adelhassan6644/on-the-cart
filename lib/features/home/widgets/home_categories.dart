import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/shimmer/custom_shimmer.dart';
import 'package:stepOut/features/categories/model/categories_model.dart';
import 'package:stepOut/features/categories/widgets/category_card.dart';

import '../../../app/core/app_state.dart';
import '../../../main_page/bloc/dashboard_bloc.dart';
import '../../../main_widgets/section_title.dart';
import '../../categories/bloc/categories_bloc.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, AppState>(builder: (context, state) {
      if (state is Done) {
        List<CategoryItem> categories =
            (state.model as CategoriesModel).data ?? [];
        return Column(
          children: [
            SectionTitle(
              title: getTranslated("categories"),
              onViewTap: () => DashboardBloc.instance.updateSelectIndex(1),
              withView: true,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL.w),
                  ...List.generate(
                    categories.length,
                    (i) => Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                      child: CategoryCard(
                        category: categories[i],
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                      child: CustomShimmerContainer(
                        height: 112.h,
                        width: 100.w,
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
              title: getTranslated("categories"),
              onViewTap: () => DashboardBloc.instance.updateSelectIndex(1),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                      child: const CategoryCard(),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      }
    });
  }
}
