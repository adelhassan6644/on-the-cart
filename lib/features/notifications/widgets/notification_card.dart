import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:stepOut/app/core/extensions.dart';
import 'package:stepOut/components/custom_images.dart';
import 'package:stepOut/features/notifications/bloc/notifications_bloc.dart';
import '../../../app/core/app_event.dart';
import '../../../app/core/dimensions.dart';
import '../../../app/core/images.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../model/notifications_model.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard({
    super.key,
    this.notification,
    this.withBorder = true,
  });
  final NotificationItem? notification;
  final bool withBorder;

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.notification?.notificationBody?.placeId != null) {
          CustomNavigator.push(Routes.ITEM_DETAILS,
              arguments: widget.notification?.notificationBody?.placeId);
        }
        if (widget.notification?.isRead != true) {
          NotificationsBloc.instance.add(Read(arguments: widget.notification?.id ?? ""));

          setState(() => widget.notification?.isRead = true);
        }
      },
      child: Container(
        width: context.width,
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
            vertical: Dimensions.PADDING_SIZE_SMALL.h),
        decoration: BoxDecoration(
          color: widget.notification?.isRead == true
              ? Styles.WHITE_COLOR
              : Styles.PRIMARY_COLOR.withOpacity(0.1),
          border: Border(
            top: const BorderSide(color: Styles.BORDER_COLOR),
            bottom: BorderSide(
              color:
                  widget.withBorder ? Styles.BORDER_COLOR : Colors.transparent,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            customContainerImage(
              backGroundColor: widget.notification?.isRead != true
                  ? Styles.WHITE_COLOR
                  : Styles.PRIMARY_COLOR.withOpacity(0.1),
              imageName: Images.logo,
              radius: 100,
              width: 50,
              height: 50,
            ),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.notification?.notificationBody?.title ??
                        "jkjfb3vfi3vv3 ",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.medium
                        .copyWith(fontSize: 14, color: Styles.HEADER),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: ReadMoreText(
                      widget.notification?.notificationBody?.message ?? " ",
                      style: AppTextStyles.medium
                          .copyWith(fontSize: 12, color: Styles.TITLE),
                      trimLines: 2,
                      colorClickableText: Colors.pink,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: getTranslated("show_more"),
                      trimExpandedText: getTranslated("show_less"),
                      textAlign: TextAlign.start,
                      moreStyle: AppTextStyles.semiBold
                          .copyWith(fontSize: 14, color: Styles.PRIMARY_COLOR),
                      lessStyle: AppTextStyles.semiBold
                          .copyWith(fontSize: 14, color: Styles.PRIMARY_COLOR),
                    ),
                  ),
                  Row(
                    children: [
                      const Expanded(child: SizedBox()),
                      Text(
                          widget.notification?.createdAt
                                  ?.dateFormat(format: "EEE dd/mm -hh:mm a") ??
                              "434/ef/f",
                          style: AppTextStyles.regular.copyWith(
                              fontSize: 12, color: Styles.DETAILS_COLOR)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
