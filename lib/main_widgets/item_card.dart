import 'package:flutter/material.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/core/extensions.dart';
import 'package:stepOut/components/custom_network_image.dart';
import 'package:stepOut/main_models/items_model.dart';
import 'package:stepOut/main_widgets/wishlist_button.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import 'package:stepOut/navigation/routes.dart';
import '../app/core/styles.dart';
import '../app/core/text_styles.dart';
import 'discount_widget.dart';
import 'final_price.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, this.item});
  final ItemModel? item;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () => CustomNavigator.push(Routes.itemDetails,
              arguments: item?.id ?? 1),
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
                        item?.name ?? "Item Tile",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.semiBold
                            .copyWith(fontSize: 14, color: Styles.HEADER),
                      ),
                      SizedBox(height: 6.h),

                      ///Price
                      FinalPriceWidget(
                        finalPrice: item?.finalPrice ?? 0,
                        price: item?.price ?? 0,
                        isExistDiscount: item?.discount != null,
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
        if (item?.discount != null)
          Positioned(
            top: 12,
            right: 1,
            child: DiscountWidget(discount: item!.discount!),
          ),
      ],
    );
  }
}
