import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/core/extensions.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/animated_widget.dart';
import 'package:stepOut/components/custom_app_bar.dart';
import 'package:stepOut/components/empty_widget.dart';
import 'package:stepOut/features/language/bloc/language_bloc.dart';
import 'package:stepOut/main_models/items_model.dart';
import 'package:stepOut/navigation/custom_navigation.dart';

import '../../../app/core/app_event.dart';
import '../../../app/core/app_state.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/svg_images.dart';
import '../../../components/custom_button.dart';
import '../../../components/shimmer/custom_shimmer.dart';
import '../../../data/config/di.dart';
import '../../../navigation/routes.dart';
import '../../guest/guest_mode.dart';
import '../bloc/cart_bloc.dart';
import '../widgets/cart_item.dart';
import '../../../main_widgets/delete_item_widget.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () => sl<CartBloc>().add(Get()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getTranslated("cart"),
        withBack: false,
      ),
      body: SafeArea(
          child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Column(
              children: [
                Expanded(
                  child: BlocBuilder<CartBloc, AppState>(
                      builder: (context, state) {
                    if (!sl<CartBloc>().isLogin) {
                      return const GuestMode();
                    }
                    if (state is Done) {
                      List<ItemModel> items = state.list as List<ItemModel>;
                      return ListAnimator(
                        data: List.generate(
                            items.length,
                            (i) => Dismissible(
                                  direction: DismissDirection.startToEnd,
                                  key: UniqueKey(),
                                  onDismissed: (v) => sl<CartBloc>()
                                      .add(Delete(arguments: items[i])),
                                  background: const DeleteItemWidget(),
                                  child: CartItem(
                                    item: items[i],
                                  ),
                                )),
                      );
                    }
                    if (state is Loading) {
                      return ListAnimator(
                        data: List.generate(
                          7,
                          (index) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: CustomShimmerContainer(
                              height: 140.h,
                              width: context.width,
                              radius: 12,
                            ),
                          ),
                        ),
                      );
                    }
                    if (state is Empty) {
                      return const EmptyState();
                    }
                    if (state is Error) {
                      return EmptyState(
                        txt: getTranslated("something_went_wrong"),
                      );
                    }
                    return const SizedBox();
                  }),
                ),
              ],
            ),
            BlocBuilder<CartBloc, AppState>(
              builder: (context, state) {
                return Visibility(
                  visible: state is Done,
                  child: Positioned(
                    bottom: 20,
                    child: CustomButton(
                        svgIcon: sl<LanguageBloc>().isLtr
                            ? SvgImages.arrowRightCart
                            : SvgImages.arrowLeft,
                        iconSize: 18,
                        onTap: () => CustomNavigator.push(Routes.checkOut),
                        textColor: Styles.PRIMARY_COLOR,
                        iconColor: Styles.PRIMARY_COLOR,
                        backgroundColor: Styles.WHITE_COLOR,
                        withBorderColor: true,
                        width: 150.w,
                        text: getTranslated("continue", context: context)),
                  ),
                );
              },
            )
          ],
        ),
      )),
    );
  }
}
