import 'package:flutter/material.dart';
import 'package:stepOut/app/core/dimensions.dart';
import '../../navigation/custom_navigation.dart';
import '../app/core/images.dart';
import '../app/core/styles.dart';
import 'custom_images.dart';

abstract class CustomSimpleDialog {
  static parentSimpleDialog(
      {required Widget? customListWidget,
      String? icon,
      bool canDismiss = true}) {
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.8),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: SimpleDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 1,
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                ),
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Styles.WHITE_COLOR,
                            borderRadius: BorderRadius.circular(20)),
                        padding: EdgeInsets.symmetric(
                            vertical: Dimensions.PADDING_SIZE_DEFAULT.h,
                            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                        margin: const EdgeInsets.symmetric(vertical: 70),
                        child: customListWidget,
                      ),
                      Visibility(
                          visible: icon != null,
                          child: customImageIcon(
                              imageName: (icon ?? Images.success),
                              width: 120,
                              height: 120)),
                    ],
                  )
                ],
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
        barrierDismissible: canDismiss,
        barrierLabel: '',
        context: CustomNavigator.navigatorState.currentContext!,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        });
  }
}
