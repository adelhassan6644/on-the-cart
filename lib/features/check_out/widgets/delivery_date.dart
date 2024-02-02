import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/features/check_out/bloc/check_out_bloc.dart';

import '../../../app/core/app_state.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/text_styles.dart';
import '../../../app/localization/language_constant.dart';

class DeliveryDate extends StatelessWidget {
  const DeliveryDate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckOutBloc, AppState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 6.h),
              child: Text(
                getTranslated("delivery_data"),
                style: AppTextStyles.semiBold
                    .copyWith(fontSize: 16, color: Styles.HEADER),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 6.h),
              child: Text(
               "يصل في تاريخ 24 يناير او 25 يناير",
                style: AppTextStyles.medium
                    .copyWith(fontSize: 14, color: Styles.TITLE),
              ),
            ),
          ],
        );
      },
    );
  }
}
