import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/dimensions.dart';

import '../../../app/core/app_event.dart';
import '../bloc/my_orders_bloc.dart';
import 'orders_tab.dart';

class OrdersTabBar extends StatelessWidget {
  const OrdersTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL.h),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.4)))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          3,
          (index) => Expanded(
            child: StreamBuilder<int?>(
              stream: context.read<OrdersBloc>().currentTabStream,
              builder: (context, snapshot) {
                return OrderTab(
                  title: context.read<OrdersBloc>().tabTitles[index],
                  icon: context.read<OrdersBloc>().tabIcons[index],
                  isSelected: (snapshot.hasData ? snapshot.data : 0) == index,
                  onTap: () {
                    context.read<OrdersBloc>().add(Click(
                        arguments: index == 0
                            ? 8
                            : index == 1
                                ? 5
                                : 6));
                    context.read<OrdersBloc>().updateCurrentTab(index);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
