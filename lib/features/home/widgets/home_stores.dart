import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/shimmer/custom_shimmer.dart';
import 'package:stepOut/features/stores/model/stores_model.dart';
import 'package:stepOut/features/stores/widgets/store_card.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import 'package:stepOut/navigation/routes.dart';

import '../../../app/core/app_state.dart';
import '../../../main_widgets/section_title.dart';
import '../../stores/bloc/stores_bloc.dart';

class HomeStores extends StatelessWidget {
  const HomeStores({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoresBloc, AppState>(builder: (context, state) {
      if (state is Done) {
        List<StoreItem> stores = (state.model as StoresModel).data ?? [];
        return Column(
          children: [
            SectionTitle(
              title: getTranslated("explore_stores"),
              onViewTap: () => CustomNavigator.push(Routes.stores),
              withView: true,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL.w),
                  ...List.generate(
                    stores.length,
                    (i) => Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                      child: StoreCard(
                        store: stores[i],
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
                        height: 75.h,
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
              title: getTranslated("explore_stores"),
              onViewTap: () => CustomNavigator.push(Routes.stores),
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
                      child: const StoreCard(),
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
