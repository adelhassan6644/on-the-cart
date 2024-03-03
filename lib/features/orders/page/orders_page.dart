import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/app_state.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/core/extensions.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/animated_widget.dart';
import 'package:stepOut/components/custom_app_bar.dart';
import 'package:stepOut/components/shimmer/custom_shimmer.dart';
import 'package:stepOut/features/orders/model/orders_model.dart';
import 'package:stepOut/features/orders/repo/orders_repo.dart';
import 'package:stepOut/features/orders/widgets/order_card.dart';

import '../../../app/core/app_event.dart';
import '../../../components/empty_widget.dart';
import '../../../data/config/di.dart';
import '../bloc/my_orders_bloc.dart';
import '../widgets/orders_tab_bar.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getTranslated("orders_history"),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) =>
              OrdersBloc(repo: sl<OrdersRepo>())..add(Click(arguments: 8)),
          child: Column(
            children: [
              const OrdersTabBar(),
              Expanded(
                child: BlocBuilder<OrdersBloc, AppState>(
                  builder: (context, state) {
                    if (state is Done) {
                      List<MyOrderItem> orders =
                          (state.model as OrdersModel).data!;
                      return ListAnimator(
                        customPadding: EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                        data: List.generate(orders.length,
                            (index) => OrderCard(order: orders[index])),
                      );
                    }
                    if (state is Loading) {
                      return ListAnimator(
                        customPadding: EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                        data: List.generate(
                            10,
                            (index) => Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.h),
                                  child: CustomShimmerContainer(
                                    height: 120.h,
                                    radius: 20,
                                    width: context.width,
                                  ),
                                )),
                      );
                    }
                    if (state is Empty || state is Error) {
                      return ListAnimator(
                        customPadding: EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                        data: [
                          SizedBox(
                            height: 100.h,
                          ),
                          EmptyState(
                            txt: state is Empty
                                ? null
                                : getTranslated("something_went_wrong"),
                          )
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
