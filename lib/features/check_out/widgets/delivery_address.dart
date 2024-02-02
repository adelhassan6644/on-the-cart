import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/features/addresses/bloc/addresses_bloc.dart';
import 'package:stepOut/features/addresses/model/addresses_model.dart';
import 'package:stepOut/features/check_out/widgets/selected_address_card.dart';

import '../../../app/core/app_state.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/text_styles.dart';
import '../../../app/localization/language_constant.dart';

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
          builder: (context, state) {
            return Padding(
                padding: EdgeInsets.symmetric(vertical: 6.h),
                child: SelectedAddressCard(
                  address: AddressItem(isDefaultAddress: true),
                ));
          },
        ),
      ],
    );
  }
}
