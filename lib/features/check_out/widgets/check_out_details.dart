import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/app_state.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/core/text_styles.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/features/cart/bloc/cart_bloc.dart';

import '../../../app/core/styles.dart';
import '../../../main_models/items_model.dart';

class CheckOutDetails extends StatelessWidget {
  const CheckOutDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, AppState>(
      builder: (context, state) {
        if (state is Done) {
          List<ItemModel> items = state.list as List<ItemModel>;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getTranslated("order_details"),
                style: AppTextStyles.semiBold
                    .copyWith(fontSize: 16, color: Styles.HEADER),
              ),
              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 6.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${getTranslated("order_count")} ${items.length}",
                        style: AppTextStyles.medium
                            .copyWith(fontSize: 14, color: Styles.TITLE),
                      ),
                    ),
                    Text(
                      "${context.read<CartBloc>().cartModel?.total} ${getTranslated("sar")}",
                      style: AppTextStyles.medium
                          .copyWith(fontSize: 14, color: Styles.DETAILS_COLOR),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 6.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        getTranslated("shipping"),
                        style: AppTextStyles.medium
                            .copyWith(fontSize: 14, color: Styles.TITLE),
                      ),
                    ),
                    Text(
                      "${20} ${getTranslated("sar")}",
                      style: AppTextStyles.medium
                          .copyWith(fontSize: 14, color: Styles.DETAILS_COLOR),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 6.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        getTranslated("total_amount"),
                        style: AppTextStyles.medium
                            .copyWith(fontSize: 14, color: Styles.TITLE),
                      ),
                    ),
                    Text(
                      "${(context.read<CartBloc>().cartModel?.total ?? 0) + 20} ${getTranslated("sar")}",
                      style: AppTextStyles.medium
                          .copyWith(fontSize: 14, color: Styles.DETAILS_COLOR),
                    ),
                  ],
                ),
              )
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
