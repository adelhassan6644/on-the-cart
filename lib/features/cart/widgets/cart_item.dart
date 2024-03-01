import 'package:flutter/material.dart';
import 'package:stepOut/app/core/app_core.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/core/styles.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/custom_network_image.dart';
import 'package:stepOut/features/cart/bloc/cart_bloc.dart';
import 'package:stepOut/main_models/items_model.dart';
import 'package:stepOut/main_widgets/final_price.dart';
import '../../../app/core/app_event.dart';
import '../../../app/core/text_styles.dart';
import '../../../data/config/di.dart';
import '../../../main_widgets/discount_widget.dart';
import '../../../main_widgets/wishlist_button.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.item});
  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => CustomNavigator.push(Routes.itemDetails, arguments: item.id),
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Styles.BORDER_COLOR)),
        child: Row(
          children: [
            Stack(
              children: [
                CustomNetworkImage.containerNewWorkImage(
                  height: 120.h,
                  width: 120.h,
                  radius: 14,
                  image: item.image ?? "",
                ),
                if (item.discount != null)
                  Positioned(
                    top: 12,
                    right: 1,
                    child: DiscountWidget(discount: item.discount!),
                  ),
              ],
            ),
            SizedBox(width: 16.w),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ///Name
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        item.name ?? "Item Tile",
                        style: AppTextStyles.semiBold
                            .copyWith(fontSize: 14, color: Styles.HEADER),
                      ),
                    ),
                    SizedBox(width: 6.w),
                    WishlistButton(item: item),
                  ],
                ),

                // ///Size & Color
                // Padding(
                //   padding: EdgeInsets.symmetric(vertical: 8.h),
                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Container(
                //         width: 30,
                //         height: 30,
                //         alignment: Alignment.center,
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(4),
                //             border: Border.all(color: Styles.BORDER_COLOR)),
                //         child: Text(
                //           item.size ?? "M",
                //           textAlign: TextAlign.start,
                //           style: AppTextStyles.medium.copyWith(
                //               fontSize: 14, color: Styles.DETAILS_COLOR),
                //         ),
                //       ),
                //       SizedBox(width: 8.w),
                //       Container(
                //         width: 30,
                //         height: 30,
                //         decoration: BoxDecoration(
                //             color: item.color?.toColor,
                //             borderRadius: BorderRadius.circular(4),
                //             border: Border.all(color: Styles.BORDER_COLOR)),
                //         child: const SizedBox(),
                //       )
                //     ],
                //   ),
                // ),
                ///Count
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 4.h),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Styles.BORDER_COLOR)),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              if (item.count <= (item.stock ?? 0)) {
                                item.count++;
                                sl<CartBloc>().add(Update(arguments: item));
                              } else {
                                AppCore.showToast(
                                  getTranslated(
                                      "there_is_no_products_any_more"),
                                );
                              }
                            },
                            child: const Icon(
                              Icons.add,
                              size: 18,
                              color: Styles.DETAILS_COLOR,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Text(
                              "${item.count}",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.medium.copyWith(
                                  fontSize: 12, color: Styles.DETAILS_COLOR),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if ((item.count) > 1) {
                                item.count--;
                                sl<CartBloc>().add(Update(arguments: item));
                              }
                            },
                            child: Icon(
                              Icons.remove,
                              size: 18,
                              color: ((item.count) > 0)
                                  ? Styles.DETAILS_COLOR
                                  : Styles.DISABLED,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                ///Price
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: FinalPriceWidget(
                      price: item.price ?? 0,
                      finalPrice: item.finalPrice,
                      isExistDiscount: item.discount != null),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
