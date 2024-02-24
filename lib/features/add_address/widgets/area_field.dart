import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stepOut/components/custom_bottom_sheet.dart';
import 'package:stepOut/components/custom_text_form_field.dart';
import 'package:stepOut/features/add_address/bloc/add_address_bloc.dart';
import 'package:stepOut/navigation/custom_navigation.dart';

import '../../../app/core/app_core.dart';
import '../../../app/core/app_notification.dart';
import '../../../app/core/app_state.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/validation.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_single_selector.dart';
import '../bloc/area_bloc.dart';
import '../model/custom_field_model.dart';

class AreaField extends StatelessWidget {
  const AreaField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AreaBloc, AppState>(
      builder: (context, state) {
        return StreamBuilder<CustomFieldItem?>(
            stream: context.read<AddAddressBloc>().areaStream,
            builder: (context, snapshot) {
              return CustomTextField(
                isEnabled: false,
                controller: TextEditingController(text: snapshot.data?.name),
                label: getTranslated("area"),
                hint: getTranslated("choose_your_area"),
                validate: (v) => Validations.area(snapshot.data?.name ?? ""),
                onTap: () {
                  if (context.read<AddAddressBloc>().city.value != null) {
                    if (state is Done) {
                      List<CustomFieldItem> list =
                          (state.model as CustomFieldModel).data
                              as List<CustomFieldItem>;
                      CustomBottomSheet.show(
                          widget: CustomSingleSelector(
                            list: list,
                            initialValue: snapshot.data?.id,
                            onConfirm: (v) => context
                                .read<AddAddressBloc>()
                                .updateArea(v as CustomFieldItem),
                          ),
                          onConfirm: () => CustomNavigator.pop(),
                          label: getTranslated("choose_your_area"));
                    } else if (state is Loading) {
                      AppCore.showSnackBar(
                        notification: AppNotification(
                          message: getTranslated("loading"),
                          backgroundColor: Styles.PENDING,
                          borderColor: Colors.transparent,
                        ),
                      );
                    } else if (state is Empty) {
                      AppCore.showSnackBar(
                        notification: AppNotification(
                          message: getTranslated("there_is_no_data"),
                          backgroundColor: Styles.PENDING,
                          borderColor: Colors.transparent,
                        ),
                      );
                    } else if (state is Error) {
                      AppCore.showSnackBar(
                        notification: AppNotification(
                          message: getTranslated("something_went_wrong"),
                          backgroundColor: Styles.IN_ACTIVE,
                          borderColor: Styles.RED_COLOR,
                        ),
                      );
                    }
                  } else {
                    AppCore.showSnackBar(
                      notification: AppNotification(
                        message: getTranslated("you_must_select_city_first"),
                        backgroundColor: Styles.PENDING,
                        borderColor: Styles.PENDING,
                      ),
                    );
                  }
                },
                suffixIcon: Icons.keyboard_arrow_down_rounded,
              );
            });
      },
    );
  }
}
