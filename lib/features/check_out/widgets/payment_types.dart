import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/app_state.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/features/check_out/bloc/check_out_bloc.dart';

import '../../../app/core/styles.dart';
import '../../../app/core/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_radio_button.dart';
import '../model/payment_model.dart';

class PaymentTypes extends StatelessWidget {
  const PaymentTypes({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckOutBloc, AppState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Text(
                getTranslated("payment"),
                style: AppTextStyles.semiBold
                    .copyWith(fontSize: 16, color: Styles.HEADER),
              ),
            ),
            StreamBuilder<PaymentModel?>(
                stream: context.read<CheckOutBloc>().selectedPaymentType,
                builder: (context, snapshot) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.h),
                    child: Row(
                      children: List.generate(
                        context.read<CheckOutBloc>().paymentTypes.length,
                        (index) => Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: CustomRadioButton(
                              title: context
                                      .read<CheckOutBloc>()
                                      .paymentTypes[index]
                                      .title ??
                                  "",
                              check:
                                  (snapshot.hasData ? snapshot.data?.id : -1) ==
                                      context
                                          .read<CheckOutBloc>()
                                          .paymentTypes[index]
                                          .id,
                              onChange: (v) => context
                                  .read<CheckOutBloc>()
                                  .updateSelectedPaymentType(context
                                      .read<CheckOutBloc>()
                                      .paymentTypes[index]),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ],
        );
      },
    );
  }
}
