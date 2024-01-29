import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/app_state.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/animated_widget.dart';
import 'package:stepOut/components/custom_app_bar.dart';
import 'package:stepOut/components/custom_button.dart';
import 'package:stepOut/features/addresses/model/addresses_model.dart';
import '../../../app/core/app_event.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/text_styles.dart';
import '../../../app/core/validation.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../data/config/di.dart';
import '../../more/widgets/turn_button.dart';
import '../bloc/add_address_bloc.dart';
import '../widgets/area_field.dart';
import '../widgets/city_field.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key, this.address});
  final AddressItem? address;

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode nameNode = FocusNode();
  final FocusNode phoneNode = FocusNode();
  final FocusNode addressNode = FocusNode();
  final FocusNode addressDetailsNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => widget.address != null
          ? (AddAddressBloc(repo: sl())..add(Init(arguments: widget.address)))
          : AddAddressBloc(repo: sl()),
      child: Scaffold(
        appBar: CustomAppBar(
          title: getTranslated(
                  widget.address != null ? "edit_address" : "add_address")
              .replaceAll("+ ", ""),
        ),
        body: BlocBuilder<AddAddressBloc, AppState>(
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                      child: ListAnimator(
                    customPadding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                    ),
                    data: [
                      SizedBox(
                        height: Dimensions.PADDING_SIZE_DEFAULT.h,
                      ),

                      ///name
                      CustomTextField(
                        controller: context.read<AddAddressBloc>().nameTEC,
                        focusNode: nameNode,
                        nextFocus: phoneNode,
                        label: getTranslated("full_name"),
                        hint: getTranslated("enter_your_full_name"),
                        inputType: TextInputType.name,
                        validate: Validations.name,
                      ),

                      ///phone
                      CustomTextField(
                        controller: context.read<AddAddressBloc>().phoneTEC,
                        focusNode: phoneNode,
                        label: getTranslated("phone"),
                        hint: getTranslated("enter_your_phone"),
                        inputType: TextInputType.phone,
                        validate: Validations.phone,
                      ),

                      const CityField(),

                      const AreaField(),

                      ///Address
                      CustomTextField(
                        controller: context.read<AddAddressBloc>().addressTEC,
                        focusNode: addressNode,
                        nextFocus: addressDetailsNode,
                        label: getTranslated("address"),
                        hint: getTranslated("enter_address"),
                        inputType: TextInputType.streetAddress,
                        validate: Validations.field,
                      ),

                      ///Address Details
                      CustomTextField(
                        controller:
                            context.read<AddAddressBloc>().addressDetailsTEC,
                        focusNode: addressDetailsNode,
                        label: getTranslated("address_details"),
                        hint: getTranslated("enter_address_details"),
                        inputType: TextInputType.streetAddress,
                        validate: Validations.field,
                      ),

                      ///Make as A Default Address
                      StreamBuilder<bool?>(
                          stream:
                              context.read<AddAddressBloc>().isDefaultStream,
                          builder: (context, snapshot) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                      getTranslated(
                                          "make_as_a_default_address"),
                                      maxLines: 1,
                                      style: AppTextStyles.semiBold.copyWith(
                                          fontSize: 16,
                                          overflow: TextOverflow.ellipsis,
                                          color: Styles.PRIMARY_COLOR)),
                                ),
                                SizedBox(
                                  width: 16.w,
                                ),
                                SizedBox(
                                  height: 10,
                                  child: Switch(
                                    value: snapshot.hasData
                                        ? snapshot.data!
                                        : false,
                                    inactiveThumbColor: Styles.WHITE_COLOR,
                                    inactiveTrackColor: Styles.BORDER_COLOR,
                                    onChanged: context
                                        .read<AddAddressBloc>()
                                        .upIsDefault,
                                    trackOutlineColor: MaterialStateProperty
                                        .resolveWith<Color?>(
                                            (Set<MaterialState> states) {
                                      return snapshot.data == true
                                          ? Styles.PRIMARY_COLOR
                                          : Styles.BORDER_COLOR;
                                    }),
                                    trackOutlineWidth: MaterialStateProperty
                                        .resolveWith<double?>(
                                            (Set<MaterialState> states) {
                                      return 1.0;
                                    }),
                                  ),
                                )
                              ],
                            );
                          }),
                      SizedBox(
                        height: Dimensions.PADDING_SIZE_DEFAULT.h,
                      ),
                    ],
                  )),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL.h),
            child: BlocBuilder<AddAddressBloc, AppState>(
              builder: (context, state) {
                return CustomButton(
                  text: getTranslated("save"),
                  isLoading: state is Loading,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      context
                          .read<AddAddressBloc>()
                          .add(Click(arguments: widget.address?.id));
                    }
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
