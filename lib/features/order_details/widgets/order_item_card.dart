import 'package:flutter/material.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/features/order_details/model/order_details_model.dart';

import '../../../app/core/styles.dart';
import '../../../app/core/text_styles.dart';
import '../../../components/custom_network_image.dart';

class OrderItemCard extends StatelessWidget {
  const OrderItemCard({super.key, this.order});
  final OrderItem? order;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL.h),
      decoration: BoxDecoration(
        border: Border.all(color: Styles.BORDER_COLOR),
        color: Styles.WHITE_COLOR,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomNetworkImage.containerNewWorkImage(
            width: 120.w,
            height: 120.h,
            radius: 20,
            image: order?.product?.image ?? "",
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_SMALL.w,
                  vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ///Name
                  Text(
                    order?.product?.name ?? "",
                    textAlign: TextAlign.start,
                    style: AppTextStyles.semiBold
                        .copyWith(fontSize: 14, color: Styles.HEADER),
                  ),

                  ///Item Count
                  Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Text(
                      "${getTranslated("count")}${order?.quantity ?? 0}",
                      textAlign: TextAlign.start,
                      style: AppTextStyles.medium
                          .copyWith(fontSize: 14, color: Styles.DETAILS_COLOR),
                    ),
                  ),

                  // ///Item Color
                  // Container(
                  //   width: 30,
                  //   height: 30,
                  //   margin: EdgeInsets.symmetric(vertical: 4.h),
                  //   decoration: BoxDecoration(
                  //       color: Colors.blueAccent,
                  //       borderRadius: BorderRadius.circular(4),
                  //       border: Border.all(color: Styles.BORDER_COLOR)),
                  //   child: const SizedBox(),
                  // ),

                  ///Item Price
                  Text(
                    "${order?.product?.finalPrice} ${getTranslated("sar")}",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.medium
                        .copyWith(fontSize: 14, color: Styles.DETAILS_COLOR),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
