import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/app_state.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/core/svg_images.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/animated_widget.dart';
import 'package:stepOut/components/custom_app_bar.dart';
import 'package:stepOut/components/empty_widget.dart';
import 'package:stepOut/components/shimmer/custom_shimmer.dart';
import 'package:stepOut/features/addresses/bloc/addresses_bloc.dart';
import 'package:stepOut/features/addresses/model/addresses_model.dart';
import 'package:stepOut/features/addresses/widgets/address_card.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import 'package:stepOut/navigation/routes.dart';

import '../../../app/core/app_event.dart';
import '../../../app/core/styles.dart';
import '../../../components/custom_button.dart';
import '../../../data/config/di.dart';
import '../../../main_widgets/delete_item_widget.dart';

class AddressesPage extends StatelessWidget {
  const AddressesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getTranslated("addresses"),
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                Expanded(child: BlocBuilder<AddressesBloc, AppState>(
                  builder: (context, state) {
                    if (state is Done) {
                      List<AddressItem> address =
                          (state.data as AddressesModel).data!;
                      return ListAnimator(
                        data: List.generate(
                          address.length,
                          (index) => Dismissible(
                            direction: DismissDirection.startToEnd,
                            key: UniqueKey(),
                            onDismissed: (v) => sl<AddressesBloc>()
                                .add(Delete(arguments: address[index].id)),
                            background: const DeleteItemWidget(),
                            child: AddressCard(
                              address: address[index],
                            ),
                          ),
                        ),
                      );
                    }
                    if (state is Loading) {
                      return ListAnimator(
                        data: List.generate(
                          6,
                          (index) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: CustomShimmerContainer(
                              height: 130.h,
                              radius: 14,
                            ),
                          ),
                        ),
                      );
                    }
                    if (state is Empty || state is Error) {
                      return ListAnimator(
                        data: [
                          EmptyState(
                            txt: getTranslated(state is Empty
                                ? "there_is_no_addresses"
                                : "something_went_wrong"),
                            isSvg: true,
                            img: SvgImages.emptyAddress,
                          ),
                        ],
                      );
                    }
                    return ListAnimator(
                      data: List.generate(
                        5,
                        (index) => AddressCard(),
                      ),
                    );
                  },
                ))
              ],
            ),
            Positioned(
              bottom: 24,
              child: CustomButton(
                  textColor: Styles.PRIMARY_COLOR,
                  backgroundColor: Styles.WHITE_COLOR,
                  withBorderColor: true,
                  width: 200.w,
                  onTap: () => CustomNavigator.push(Routes.addAddress),
                  text: getTranslated("add_address")),
            ),
          ],
        ),
      ),
    );
  }
}
