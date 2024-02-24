import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/components/custom_bottom_sheet.dart';
import 'package:stepOut/components/custom_text_form_field.dart';
import 'package:stepOut/features/add_address/bloc/add_address_bloc.dart';
import 'package:stepOut/features/add_address/bloc/area_bloc.dart';
import 'package:stepOut/navigation/custom_navigation.dart';

import '../../../app/core/app_core.dart';
import '../../../app/core/app_event.dart';
import '../../../app/core/app_notification.dart';
import '../../../app/core/app_state.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/validation.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_single_selector.dart';
import '../../../data/config/di.dart';
import '../bloc/city_bloc.dart';
import '../model/custom_field_model.dart';

class CityField extends StatelessWidget {
  const CityField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CityBloc, AppState>(
      builder: (context, state) {
        return StreamBuilder<CustomFieldItem?>(
            stream: context.read<AddAddressBloc>().cityStream,
            builder: (context, snapshot) {
              return CustomTextField(
                isEnabled: false,
                controller: TextEditingController(text: snapshot.data?.name),
                label: getTranslated("city"),
                hint: getTranslated("choose_your_city"),
                validate: (v) => Validations.city(snapshot.data?.name ?? ""),
                onTap: () {
                  if (state is Done) {
                    List<CustomFieldItem> list =
                        (state.model as CustomFieldModel).data
                            as List<CustomFieldItem>;
                    CustomBottomSheet.show(
                        widget: CustomSingleSelector(
                          list: list,
                          initialValue: snapshot.data?.id,
                          onConfirm: (v) {
                            context
                                .read<AddAddressBloc>()
                                .updateCity(v as CustomFieldItem);
                            sl<AreaBloc>().add(Click(arguments: v.id));
                          },
                        ),
                        onConfirm: () => CustomNavigator.pop(),
                        label: getTranslated("choose_your_city"));
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
                },
                suffixIcon: Icons.keyboard_arrow_down_rounded,
              );
            });
      },
    );
  }
}
