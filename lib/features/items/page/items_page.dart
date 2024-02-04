import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/custom_app_bar.dart';
import 'package:stepOut/components/empty_widget.dart';
import 'package:stepOut/components/grid_list_animator.dart';
import 'package:stepOut/features/items/bloc/items_bloc.dart';
import 'package:stepOut/main_models/items_model.dart';
import 'package:stepOut/main_widgets/item_card.dart';

import '../../../app/core/app_event.dart';
import '../../../app/core/app_state.dart';
import '../../../components/shimmer/custom_shimmer.dart';
import '../../../data/config/di.dart';
import '../../../main_models/base_model.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({super.key, required this.model});
  final BaseModel model;

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  @override
  void initState() {
    // Future.delayed(
    //     Duration.zero,
    //     () => sl<ItemsBloc>().add(Click(arguments: {
    //           "isStore": widget.model.isStore,
    //           "id": widget.model.id,
    //         })));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.model.title ?? "Model Title",
      ),
      body: SafeArea(
          child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
        child: Column(
          children: [
            Expanded(
              child:
                  BlocBuilder<ItemsBloc, AppState>(builder: (context, state) {
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
                              ),),);
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
    );
  }
}
