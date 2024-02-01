import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/core/extensions.dart';
import 'package:stepOut/app/core/svg_images.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/animated_widget.dart';
import 'package:stepOut/components/custom_app_bar.dart';
import 'package:stepOut/components/custom_images.dart';

import '../../../app/core/styles.dart';
import '../../../app/core/text_styles.dart';
import '../widgets/order_item_card.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getTranslated("order_details"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListAnimator(
              customPadding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
              data: const [
                OrderItemCard(),
                OrderItemCard(),
              ],
            ),
          ),
          SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
              padding: EdgeInsets.symmetric(
                  vertical: Dimensions.PADDING_SIZE_DEFAULT.h,
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
              decoration: const BoxDecoration(
                color: Styles.FILL_COLOR,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DottedLine(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.center,
                    lineLength: double.infinity,
                    lineThickness: 1.5,
                    dashLength: 20,
                    dashColor: Colors.grey.withOpacity(0.4),
                    dashGapLength: 10,
                    dashGapColor: Colors.transparent,
                    dashGapRadius: 0.0,
                  ),
                  SizedBox(height: 16.h),

                  ///Order Id and Order Status
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${getTranslated("order_id")} :#${2}",
                            textAlign: TextAlign.start,
                            style: AppTextStyles.medium.copyWith(
                                fontSize: 14, color: Styles.DETAILS_COLOR),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: Styles.PRIMARY_COLOR.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            "Order Status",
                            textAlign: TextAlign.start,
                            style: AppTextStyles.semiBold.copyWith(
                                fontSize: 14, color: Styles.PRIMARY_COLOR),
                          ),
                        )
                      ],
                    ),
                  ),

                  ///Order Created At
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            getTranslated("order_created_at"),
                            textAlign: TextAlign.start,
                            style: AppTextStyles.medium.copyWith(
                                fontSize: 14, color: Styles.DETAILS_COLOR),
                          ),
                        ),
                        Text(
                          DateTime.now().dateFormat(format: "d/MMM/yyyy"),
                          textAlign: TextAlign.start,
                          style: AppTextStyles.medium.copyWith(
                              fontSize: 14, color: Styles.DETAILS_COLOR),
                        ),
                      ],
                    ),
                  ),

                  ///Can Retail
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 4.h),
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: Styles.DISABLED.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        customImageIconSVG(
                            imageName: SvgImages.retry,
                            width: 18,
                            height: 18,
                            color: Styles.DETAILS_COLOR),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          getTranslated("exceeded_return_period"),
                          textAlign: TextAlign.start,
                          style: AppTextStyles.semiBold.copyWith(
                              fontSize: 14, color: Styles.DETAILS_COLOR),
                        ),
                      ],
                    ),
                  ),

                  ///Order Created At
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            getTranslated("order_delivered_at"),
                            textAlign: TextAlign.start,
                            style: AppTextStyles.medium.copyWith(
                                fontSize: 14, color: Styles.DETAILS_COLOR),
                          ),
                        ),
                        Text(
                          DateTime.now().dateFormat(format: "d/MMM/yyyy"),
                          textAlign: TextAlign.start,
                          style: AppTextStyles.medium.copyWith(
                              fontSize: 14, color: Styles.DETAILS_COLOR),
                        ),
                      ],
                    ),
                  ),

                  ///Order Items count
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            getTranslated("order_count"),
                            textAlign: TextAlign.start,
                            style: AppTextStyles.medium.copyWith(
                                fontSize: 14, color: Styles.DETAILS_COLOR),
                          ),
                        ),
                        Text(
                          "2",
                          textAlign: TextAlign.start,
                          style: AppTextStyles.medium.copyWith(
                              fontSize: 14, color: Styles.DETAILS_COLOR),
                        ),
                      ],
                    ),
                  ),

                  ///Order Total
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            getTranslated("total_amount"),
                            textAlign: TextAlign.start,
                            style: AppTextStyles.medium.copyWith(
                                fontSize: 14, color: Styles.DETAILS_COLOR),
                          ),
                        ),

                        ///Order Delivered At
                        Text(
                          "223 ${getTranslated("sar")}",
                          textAlign: TextAlign.start,
                          style: AppTextStyles.medium.copyWith(
                              fontSize: 14, color: Styles.DETAILS_COLOR),
                        ),
                      ],
                    ),
                  ),

                  ///Shipping Address
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Text(
                      getTranslated("shipping_address"),
                      textAlign: TextAlign.start,
                      style: AppTextStyles.medium
                          .copyWith(fontSize: 14, color: Styles.DETAILS_COLOR),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Text(
                      "الدمام",
                      textAlign: TextAlign.start,
                      style: AppTextStyles.medium
                          .copyWith(fontSize: 14, color: Styles.DETAILS_COLOR),
                    ),
                  ),
                  Text(
                    "الدمام, حي الزهراء, شارع الملك سعود, منزل رقم 6",
                    textAlign: TextAlign.start,
                    style: AppTextStyles.medium
                        .copyWith(fontSize: 14, color: Styles.DETAILS_COLOR),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
