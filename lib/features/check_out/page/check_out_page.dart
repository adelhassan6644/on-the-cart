import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/app_state.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/animated_widget.dart';
import 'package:stepOut/components/custom_app_bar.dart';
import 'package:stepOut/components/custom_button.dart';
import 'package:stepOut/features/check_out/bloc/check_out_bloc.dart';
import 'package:stepOut/features/check_out/repo/check_out_repo.dart';

import '../../../app/core/styles.dart';
import '../../../data/config/di.dart';
import '../model/payment_model.dart';
import '../widgets/check_out_details.dart';
import '../widgets/delivery_address.dart';
import '../widgets/delivery_date.dart';
import '../widgets/payment_types.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getTranslated("check_out"),
      ),
      body: BlocProvider(
        create: (context) => CheckOutBloc(repo: sl<CheckOutRepo>()),
        child: BlocBuilder<CheckOutBloc, AppState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: ListAnimator(
                    customPadding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                    ),
                    data: const [
                      CheckOutDetails(),
                      PaymentTypes(),
                      DeliveryAddress(),
                      DeliveryDate(),
                    ],
                  ),
                ),
                SafeArea(
                    child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                    vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL.h,
                  ),
                  child: StreamBuilder<PaymentModel?>(
                      stream: context.read<CheckOutBloc>().selectedPaymentType,
                      builder: (context, snapshot) {
                        return CustomButton(
                          text: getTranslated("confirm_order"),
                          isLoading: state is Loading,
                          backgroundColor: snapshot.hasData
                              ? Styles.PRIMARY_COLOR
                              : Styles.DISABLED,
                        );
                      }),
                ))
              ],
            );
          },
        ),
      ),
    );
  }
}
