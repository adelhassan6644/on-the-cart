import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';
import 'package:stepOut/app/core/app_state.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/core/extensions.dart';
import 'package:stepOut/app/core/svg_images.dart';
import 'package:stepOut/app/core/text_styles.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/animated_widget.dart';
import 'package:stepOut/components/custom_button.dart';
import 'package:stepOut/components/custom_images.dart';
import 'package:stepOut/components/custom_network_image.dart';
import 'package:stepOut/features/item_details/bloc/item_details_bloc.dart';
import 'package:stepOut/features/item_details/repo/item_details_repo.dart';
import 'package:stepOut/main_widgets/wishlist_button.dart';
import 'package:stepOut/navigation/custom_navigation.dart';

import '../../../app/core/app_event.dart';
import '../../../app/core/styles.dart';
import '../../../data/config/di.dart';
import '../../../main_models/items_model.dart';
import '../../cart/bloc/cart_bloc.dart';
import '../../related_items/view/related_items_view.dart';
import '../widget/item_color_widget.dart';
import '../widget/item_sizes_widget.dart';

class ItemDetailsPage extends StatelessWidget {
  const ItemDetailsPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ItemDetailsBloc(repo: sl<ItemDetailsRepo>()),
        child: BlocBuilder<ItemDetailsBloc, AppState>(
          builder: (context, state) {
            return SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: ListAnimator(
                      data: [
                        ///Item Image
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                          child: Stack(
                            children: [
                              CustomNetworkImage.containerNewWorkImage(
                                  height: context.height * 0.4,
                                  width: context.width,
                                  radius: 20),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: customContainerSvgIcon(
                                    onTap: () => CustomNavigator.pop(),
                                    radius: 100,
                                    width: 45,
                                    height: 45,
                                    padding: 12,
                                    backGround: Colors.white,
                                    imageName: SvgImages.arrowRightCart,
                                    color: Colors.black),
                              ),
                              Positioned(
                                  bottom: 4,
                                  left: 4,
                                  child: customContainerSvgIcon(
                                    radius: 100,
                                    width: 45,
                                    height: 45,
                                    padding: 12,
                                    backGround: Colors.white,
                                    imageName: SvgImages.send,
                                  )),
                            ],
                          ),
                        ),

                        ///Item Title and Price
                        Padding(
                          padding: EdgeInsets.only(
                              left: Dimensions.PADDING_SIZE_DEFAULT.w,
                              right: Dimensions.PADDING_SIZE_DEFAULT.w,
                              top: 16.h,
                              bottom: 6.h),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                "item name",
                                maxLines: 2,
                                style: AppTextStyles.semiBold.copyWith(
                                    fontSize: 24, color: Styles.HEADER),
                              )),
                              SizedBox(width: 16.w),
                              Text(
                                "250 ${getTranslated("sar")}",
                                style: AppTextStyles.medium.copyWith(
                                    fontSize: 24, color: Styles.TITLE),
                              )
                            ],
                          ),
                        ),

                        ///Item Ratting
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: Colors.amberAccent,
                                size: 24,
                              ),
                              Text(
                                " 2.4 (20)",
                                maxLines: 2,
                                style: AppTextStyles.medium.copyWith(
                                    fontSize: 14, color: Styles.DETAILS_COLOR),
                              )
                            ],
                          ),
                        ),

                        ///Item Description
                        Padding(
                          padding: EdgeInsets.only(
                              left: Dimensions.PADDING_SIZE_DEFAULT.w,
                              right: Dimensions.PADDING_SIZE_DEFAULT.w,
                              top: 8.h,
                              bottom: 4.h),
                          child: Text(
                            getTranslated("description"),
                            style: AppTextStyles.medium.copyWith(
                                fontSize: 14, color: Styles.HINT_COLOR),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                          child: ReadMoreText(
                            "Item Description",
                            style: AppTextStyles.medium.copyWith(
                                fontSize: 14, color: Styles.DETAILS_COLOR),
                            trimLines: 2,
                            colorClickableText: Colors.pink,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: getTranslated("show_more"),
                            trimExpandedText: getTranslated("show_less"),
                            textAlign: TextAlign.start,
                            moreStyle: AppTextStyles.semiBold.copyWith(
                                fontSize: 14, color: Styles.PRIMARY_COLOR),
                            lessStyle: AppTextStyles.semiBold.copyWith(
                                fontSize: 14, color: Styles.PRIMARY_COLOR),
                          ),
                        ),

                        const ItemSizesWidget(),

                        const ItemColorWidget(),

                        RelatedItemsView(id: id),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: BlocBuilder<CartBloc, AppState>(
                            builder: (context, state) {
                              List<ItemModel> items = [];
                              if (state is Done) {
                                items = state.list as List<ItemModel>;
                              }
                              bool isAdded = false;
                              items.map((e) {
                                isAdded = (e.id == "1");
                              });
                              return CustomButton(
                                text: getTranslated("add_to_cart"),
                                onTap: () {
                                  if (!isAdded) {
                                    sl<CartBloc>().add(Add(
                                      arguments: ItemModel(
                                          id: 2,
                                          image:
                                              "https://images.unsplash.com/photo-1575936123452-b67c3203c357?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                                          title: "Test Add To Cart 2",
                                          price: 200,
                                          size: "XL",
                                          color: "#151416",
                                          count: 6),
                                    ));
                                  }
                                },
                                backgroundColor: isAdded
                                    ? Styles.ACTIVE
                                    : Styles.PRIMARY_COLOR,
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        WishlistButton(
                          size: 55,
                          item: ItemModel(),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
