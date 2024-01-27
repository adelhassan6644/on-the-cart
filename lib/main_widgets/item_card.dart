import 'package:flutter/material.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/core/extensions.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/custom_network_image.dart';
import 'package:stepOut/main_models/items_model.dart';
import 'package:stepOut/main_widgets/wishlist_button.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import 'package:stepOut/navigation/routes.dart';
import '../app/core/app_event.dart';
import '../app/core/styles.dart';
import '../app/core/text_styles.dart';
import '../data/config/di.dart';
import '../features/cart/bloc/cart_bloc.dart';
import 'discount_widget.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, this.item});
  final ItemModel? item;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          // onTap: () => CustomNavigator.push(Routes.ITEM_DETAILS, arguments: item?.id),
          onTap: () => sl<CartBloc>().add(Add(
            arguments: ItemModel(
                id: "4",
                image:
                    "https://images.unsplash.com/photo-1575936123452-b67c3203c357?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                title: "Test Add To Cart 3",
                price: 300,
                size: "XXL",
                color: "#22BB55",
                count: 5),
          )),
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: Container(
            width: 195.w,
            decoration: BoxDecoration(
                border: Border.all(color: Styles.BORDER_COLOR),
                color: Styles.WHITE_COLOR,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomNetworkImage.containerNewWorkImage(
                  topEdges: true,
                  width: context.width,
                  height: 135.h,
                  radius: 20,
                  image: item?.image ?? "",
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_SMALL.w,
                      vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ///Name
                      Text(
                        item?.title ?? "Item Tile",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.semiBold
                            .copyWith(fontSize: 14, color: Styles.HEADER),
                      ),
                      SizedBox(height: 6.h),

                      ///Price
                      Text(
                        "${item?.price ?? 100} ${getTranslated("sar")}",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.medium.copyWith(
                            fontSize: 14, color: Styles.DETAILS_COLOR),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 8,
          left: 8,
          child: WishlistButton(item: item),
        ),
        Positioned(
          top: 12,
          right: 1,
          child: DiscountWidget(discount: item?.discount),
        ),
      ],
    );
  }
}
