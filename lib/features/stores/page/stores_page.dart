import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/custom_app_bar.dart';
import 'package:stepOut/components/empty_widget.dart';
import 'package:stepOut/components/grid_list_animator.dart';
import '../../../app/core/app_state.dart';
import '../../../components/shimmer/custom_shimmer.dart';
import '../bloc/stores_bloc.dart';
import '../model/stores_model.dart';
import '../widgets/store_card.dart';

class StoresPage extends StatelessWidget {
  const StoresPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getTranslated("stores"),
      ),
      body: SafeArea(
          child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
        child: Column(
          children: [
            Expanded(
              child:
                  BlocBuilder<StoresBloc, AppState>(builder: (context, state) {
                if (state is Done) {
                  List<StoreItem> stores =
                      (state.model as StoresModel).data ?? [];
                  return GridListAnimatorWidget(
                    columnCount: 3,
                    aspectRatio: 100.w / 75.h,
                    items: List.generate(
                      stores.length,
                      (i) => StoreCard(
                        store: stores[i],
                      ),
                    ),
                  );
                }
                if (state is Loading) {
                  return GridListAnimatorWidget(
                      columnCount: 3,
                      aspectRatio: 100.w / 75.h,
                      items: List.generate(
                        3,
                        (index) => Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 8.h),
                          child: CustomShimmerContainer(
                            height: 75.h,
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
                  return const SizedBox();
                }
              }),
            )
          ],
        ),
      )),
    );
  }
}
