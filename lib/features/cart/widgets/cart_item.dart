import 'package:flutter/material.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/core/styles.dart';
import 'package:stepOut/components/custom_network_image.dart';
import 'package:stepOut/features/cart/bloc/cart_bloc.dart';
import 'package:stepOut/main_models/items_model.dart';
import '../../../app/core/app_event.dart';
import '../../../app/core/text_styles.dart';
import '../../../app/core/extensions.dart';
import '../../../app/localization/language_constant.dart';
import '../../../data/config/di.dart';
import '../../../main_widgets/wishlist_button.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.item});
  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Styles.BORDER_COLOR)),
      child: Row(
        children: [
          CustomNetworkImage.containerNewWorkImage(
              height: 120.h, width: 120.h, radius: 14),
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

              ///Size & Color
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Styles.BORDER_COLOR)),
                      child: Text(
                        item.size ?? "M",
                        textAlign: TextAlign.start,
                        style: AppTextStyles.medium.copyWith(
                            fontSize: 14, color: Styles.DETAILS_COLOR),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: item.color?.toColor,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Styles.BORDER_COLOR)),
                      child: const SizedBox(),
                    )
                  ],
                ),
              ),

              ///Count & Price
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Styles.BORDER_COLOR)),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            item.count++;
                            sl<CartBloc>().add(Update(arguments: item));
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
                  Expanded(child: SizedBox(width: 6.w)),
                  Text(
                    "${item.price ?? 100} ${getTranslated("sar")}",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.medium
                        .copyWith(fontSize: 14, color: Styles.DETAILS_COLOR),
                  ),
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
