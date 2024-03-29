import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/core/extensions.dart';
import '../app/core/styles.dart';
import '../app/core/text_styles.dart';
import '../app/localization/language_constant.dart';
import '../navigation/custom_navigation.dart';
import 'animated_widget.dart';
import 'custom_button.dart';

abstract class CustomBottomSheet {
  static show(
      {Function()? onConfirm,
      String? label,
      String? buttonText,
      required Widget? list,
      double? height,
      Widget? child,
      bool? isLoading,
      bool withPadding = true,
      BuildContext? context,
      Function()? onDismiss,
      Function()? onClose}) {
    return showMaterialModalBottomSheet(
      enableDrag: true,
      clipBehavior: Clip.antiAlias,
      backgroundColor: Colors.transparent,
      context: CustomNavigator.navigatorState.currentContext!,
      expand: false,
      useRootNavigator: true,
      isDismissible: true,
      builder: (_) {
        return Padding(
          padding: MediaQuery.of(CustomNavigator.navigatorState.currentContext!)
              .viewInsets,
          child: Container(
            height: height ?? 500,
            width: CustomNavigator.navigatorState.currentContext!.width,
            decoration: const BoxDecoration(
              color: Styles.WHITE_COLOR,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 8.h,
                          ),
                          child: Container(
                            height: 5.h,
                            width: 50.w,
                            decoration: const BoxDecoration(
                                color: Styles.BORDER_COLOR,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                              vertical: 8.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                label ?? "",
                                style: AppTextStyles.medium.copyWith(
                                  fontSize: 18,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  CustomNavigator.pop();
                                  onDismiss?.call();
                                },
                                child: const Icon(
                                  Icons.highlight_remove,
                                  size: 24,
                                  color: Styles.DISABLED,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 8.h,
                            right: 24.w,
                            left: 24.w,
                          ),
                          child: const Divider(
                            color: Styles.BORDER_COLOR,
                          ),
                        ),
                        Expanded(
                            child: ListAnimator(
                          controller: ScrollController(),
                          data: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: withPadding
                                      ? Dimensions.PADDING_SIZE_DEFAULT.w
                                      : 0),
                              child: list!,
                            )
                          ],
                        )),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: child != null || onConfirm != null,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                        vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
                    child: child ??
                        CustomButton(
                          text: getTranslated(buttonText ?? "confirm"),
                          isLoading: isLoading ?? false,
                          onTap: onConfirm,
                        ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    ).then((value) => onClose?.call());
  }
}

class CustomModelSheet {
  final int? id;
  final String? relatedId;
  final String? name;
  final String? value;
  bool? isSelected;
  final dynamic list;
  CustomModelSheet(
      {this.id,
      this.relatedId,
      this.list,
      this.name,
      this.isSelected = false,
      this.value});

  toJson() {
    var data = {};
    data["id"] = id;
    data["name"] = name;
    data["value"] = value;
    return data;
  }
}
