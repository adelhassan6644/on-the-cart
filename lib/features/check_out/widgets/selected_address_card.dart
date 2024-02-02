import 'package:flutter/material.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/core/svg_images.dart';
import 'package:stepOut/app/core/text_styles.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/custom_images.dart';

import '../../../app/core/styles.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../../addresses/model/addresses_model.dart';

class SelectedAddressCard extends StatelessWidget {
  const SelectedAddressCard({super.key, this.address});
  final AddressItem? address;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
        vertical: Dimensions.PADDING_SIZE_DEFAULT.w,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Styles.PRIMARY_COLOR,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            width: 16,
            height: 16,
            decoration: BoxDecoration(
                color: Styles.WHITE_COLOR,
                shape: BoxShape.circle,
                border: Border.all(color: Styles.PRIMARY_COLOR, width: 1)),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Styles.PRIMARY_COLOR,
              ),
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///City
                Text(
                  address?.city?.name ?? "city",
                  style: AppTextStyles.medium
                      .copyWith(color: Styles.HEADER, fontSize: 16),
                ),

                ///Address Details
                Padding(
                  padding: EdgeInsets.only(
                      top: 4.h,
                      bottom: address?.isDefaultAddress == true ? 4.h : 0),
                  child: Text(
                    address?.addressDetails ?? "addressDetails",
                    style: AppTextStyles.regular
                        .copyWith(color: Styles.DETAILS_COLOR, fontSize: 14),
                  ),
                ),

                ///Default Address
                Visibility(
                  visible: address?.isDefaultAddress == true,
                  child: Text(
                    getTranslated("default_address"),
                    style: AppTextStyles.regular
                        .copyWith(color: Colors.blueAccent, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          customImageIconSVG(
              onTap: () => CustomNavigator.push(Routes.addresses),
              imageName: SvgImages.edit,
              color: Styles.PRIMARY_COLOR,
              height: 18,
              width: 18),
        ],
      ),
    );
  }
}
