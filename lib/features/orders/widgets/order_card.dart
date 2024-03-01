import 'package:flutter/material.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/core/extensions.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/features/orders/model/orders_model.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/text_styles.dart';
import '../../../components/custom_network_image.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order});
  final MyOrderItem order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL.h),
      child: InkWell(
        onTap: () =>
            CustomNavigator.push(Routes.orderDetails, arguments: order.id ?? 1),
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Container(
          height: 120.h,
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
                image: order.image ?? "",
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
                      ///Order ID
                      Text(
                        "${getTranslated("order_id")} :#${order.id ?? 0}",
                        textAlign: TextAlign.start,
                        style: AppTextStyles.medium.copyWith(
                            fontSize: 14, color: Styles.DETAILS_COLOR),
                      ),

                      ///Order Status
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 6.h),
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Styles.PRIMARY_COLOR.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          OrderStatus.values[order.status ?? 0].name,
                          textAlign: TextAlign.start,
                          style: AppTextStyles.semiBold.copyWith(
                              fontSize: 14, color: Styles.PRIMARY_COLOR),
                        ),
                      ),

                      ///Order Created At
                      Text(
                        (order.createdAt ?? DateTime.now())
                            .dateFormat(format: "d/MMM/yyyy h:m a"),
                        textAlign: TextAlign.start,
                        style: AppTextStyles.semiBold
                            .copyWith(fontSize: 14, color: Styles.HEADER),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
