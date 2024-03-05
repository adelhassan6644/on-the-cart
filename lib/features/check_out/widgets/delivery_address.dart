import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/app_event.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/features/addresses/bloc/addresses_bloc.dart';
import 'package:stepOut/features/addresses/model/addresses_model.dart';
import 'package:stepOut/features/check_out/widgets/selected_address_card.dart';

import '../../../app/core/app_state.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_button.dart';
import '../../../data/config/di.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';

class DeliveryAddress extends StatelessWidget {
  const DeliveryAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h),
          child: Text(
            getTranslated("delivery_address"),
            style: AppTextStyles.semiBold
                .copyWith(fontSize: 16, color: Styles.HEADER),
          ),
        ),
        BlocBuilder<AddressesBloc, AppState>(
          bloc: sl<AddressesBloc>()..add(Click()),
          builder: (context, state) {
            if (state is Done) {
              List<AddressItem> address = (state.model as AddressesModel).data!;
              return Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  child: SelectedAddressCard(
                    address:
                        address.firstWhere((e) => e.isDefaultAddress == true),
                  ));
            }
            if (state is Empty) {
              return Center(
                child: CustomButton(
                    textColor: Styles.PRIMARY_COLOR,
                    backgroundColor: Styles.WHITE_COLOR,
                    withBorderColor: true,
                    width: 200.w,
                    onTap: () => CustomNavigator.push(Routes.addAddress),
                    text: getTranslated("add_address")),
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}
