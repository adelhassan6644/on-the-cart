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
import 'package:stepOut/components/custom_app_bar.dart';
import 'package:stepOut/components/custom_button.dart';
import 'package:stepOut/components/custom_images.dart';
import 'package:stepOut/components/custom_network_image.dart';
import 'package:stepOut/features/item_details/bloc/item_details_bloc.dart';
import 'package:stepOut/features/item_details/repo/item_details_repo.dart';
import 'package:stepOut/features/language/bloc/language_bloc.dart';
import 'package:stepOut/main_widgets/wishlist_button.dart';
import 'package:stepOut/navigation/custom_navigation.dart';

import '../../../app/core/app_core.dart';
import '../../../app/core/app_event.dart';
import '../../../app/core/styles.dart';
import '../../../components/empty_widget.dart';
import '../../../data/config/di.dart';
import '../../../main_models/items_model.dart';
import '../../../main_widgets/discount_widget.dart';
import '../../../main_widgets/final_price.dart';
import '../../cart/bloc/cart_bloc.dart';
import '../../edit_profile/bloc/profile_bloc.dart';
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
        create: (context) => ItemDetailsBloc(repo: sl<ItemDetailsRepo>())
          ..add(Click(arguments: id)),
        child: BlocBuilder<ItemDetailsBloc, AppState>(
          builder: (context, state) {
            if (state is Done) {
              ItemModel model = state.model as ItemModel;
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
                                    image: model.image ?? "",
                                    height: context.height * 0.4,
                                    width: context.width,
                                    radius: 20),
                                Positioned(
                                  top: 4,
                                  left: 4,
                                  child: customContainerSvgIcon(
                                      onTap: () => CustomNavigator.pop(),
                                      radius: 100,
                                      width: 45,
                                      height: 45,
                                      padding: 12,
                                      backGround: Colors.white,
                                      imageName: LanguageBloc.instance
                                                  .selectLocale?.languageCode ==
                                              "en"
                                          ? SvgImages.arrowLeft
                                          : SvgImages.arrowRightCart,
                                      color: Colors.black),
                                ),
                                Positioned(
                                    bottom: 4,
                                    right: 4,
                                    child: customContainerSvgIcon(
                                      radius: 100,
                                      width: 45,
                                      height: 45,
                                      padding: 12,
                                      backGround: Colors.white,
                                      imageName: SvgImages.send,
                                    )),
                                if (model.discount != null)
                                  Positioned(
                                    top: 12,
                                    right: 1,
                                    child: DiscountWidget(
                                        discount: model.discount!),
                                  ),
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: Text(
                                  model.name ?? "",
                                  maxLines: 2,
                                  style: AppTextStyles.semiBold.copyWith(
                                      fontSize: 24, color: Styles.HEADER),
                                )),
                                SizedBox(width: 16.w),

                                ///Price
                                FinalPriceWidget(
                                  finalPrice: model.finalPrice,
                                  price: model.price ?? 0,
                                  isExistDiscount: model.discount != null,
                                  fontSize: 18,
                                ),
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
                                  " ${model.rate} (${model.ratingCount})",
                                  maxLines: 2,
                                  style: AppTextStyles.medium.copyWith(
                                      fontSize: 14,
                                      color: Styles.DETAILS_COLOR),
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
                              model.description ?? "",
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

                          // const ItemSizesWidget(),
                          //
                          // const ItemColorWidget(),

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
                                bool isAdded = false;
                                if (state is Done) {
                                  isAdded = (state.list as List<ItemModel>)
                                      .any((e) => e.id == model.id);
                                }

                                return CustomButton(
                                  text: getTranslated(
                                      !((model.stock ?? 0) > model.count)
                                          ? "out_of_stock"
                                          : isAdded
                                              ? "added_to_cart"
                                              : "add_to_cart"),
                                  onTap: () {
                                    if (sl<ProfileBloc>().isLogin) {
                                      if (!isAdded &&
                                          ((model.stock ?? 0) > model.count)) {
                                        sl<CartBloc>().add(Add(
                                          arguments: model,
                                        ));
                                      }
                                    } else {
                                      AppCore.showToast(getTranslated(
                                          "you_have_to_login_first"));
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
                            item: model,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            if (state is Loading) {
              return const Column(
                children: [
                  CustomAppBar(),
                  Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Styles.PRIMARY_COLOR,
                      ),
                    ),
                  )
                ],
              );
            }
            if (state is Empty || state is Error) {
              return Column(
                children: [
                  Expanded(
                    child: ListAnimator(
                      customPadding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                      data: [
                        SizedBox(
                          height: 100.h,
                        ),
                        EmptyState(
                          txt: state is Empty
                              ? null
                              : getTranslated("something_went_wrong"),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
