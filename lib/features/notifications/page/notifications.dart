import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/app_state.dart';
import 'package:stepOut/app/core/extensions.dart';
import 'package:stepOut/components/custom_loading.dart';
import 'package:stepOut/features/notifications/model/notifications_model.dart';

import '../../../app/core/app_event.dart';
import '../../../app/core/dimensions.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/svg_images.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/empty_widget.dart';
import '../bloc/notifications_bloc.dart';
import '../widgets/notification_card.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  void initState() {
    // Future.delayed(Duration.zero, () => NotificationsBloc.instance.add(Get()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getTranslated("notifications"),
      ),
      body: SafeArea(
        child: BlocBuilder<NotificationsBloc, AppState>(
          builder: (context, state) {
            if (state is Loading) {
              return const CustomLoading();
            }
            if (state is Done) {
              return RefreshIndicator(
                color: Styles.PRIMARY_COLOR,
                onRefresh: () async {
                  NotificationsBloc.instance.add(Get());
                },
                child: Column(
                  children: [
                    Expanded(
                      child: ListAnimator(
                          data: List.generate(
                              (state.model as NotificationsModel)
                                      .data
                                      ?.length ??
                                  5,
                              (index) => Dismissible(
                                    background: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        CustomButton(
                                          width: 120.w,
                                          height: 35.h,
                                          text: getTranslated("delete"),
                                          svgIcon: SvgImages.trash,
                                          iconSize: 18,
                                          iconColor: Styles.IN_ACTIVE,
                                          textColor: Styles.IN_ACTIVE,
                                          backgroundColor: Styles.IN_ACTIVE
                                              .withOpacity(0.12),
                                        ),
                                        SizedBox(
                                          width:
                                              Dimensions.PADDING_SIZE_DEFAULT.w,
                                        )
                                      ],
                                    ),
                                    direction: DismissDirection.endToStart,
                                    key: ValueKey(index),
                                    confirmDismiss:
                                        (DismissDirection direction) async {
                                      NotificationsBloc.instance.add(Delete(
                                          arguments: (state.model
                                                  as NotificationsModel)
                                              .data?[index]
                                              .id));
                                      return false;
                                    },
                                    child: NotificationCard(
                                      withBorder: index != 9,
                                      notification:
                                          (state.model as NotificationsModel)
                                              .data?[index],
                                    ),
                                  ))),
                    ),
                  ],
                ),
              );
            }
            if (state is Empty) {
              return RefreshIndicator(
                color: Styles.PRIMARY_COLOR,
                onRefresh: () async {
                  NotificationsBloc.instance.add(Get());
                },
                child: Column(
                  children: [
                    Expanded(
                      child: ListAnimator(
                        customPadding: EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                        data: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: context.height * 0.17),
                            child: EmptyState(
                              txt: getTranslated("no_notifications"),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            if (state is Error) {
              return RefreshIndicator(
                color: Styles.PRIMARY_COLOR,
                onRefresh: () async {
                  NotificationsBloc.instance.add(Get());
                },
                child: Column(
                  children: [
                    Expanded(
                      child: ListAnimator(
                        customPadding: EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                        data: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: context.height * 0.17),
                            child: EmptyState(
                              txt: getTranslated("no_notifications"),
                              subText: getTranslated("something_went_wrong"),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              color: Styles.PRIMARY_COLOR,
              onRefresh: () async {
                NotificationsBloc.instance.add(Get());
              },
              child: Column(
                children: [
                  Expanded(
                    child: ListAnimator(
                        data: List.generate(
                            5,
                            (index) => Dismissible(
                                  background: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      CustomButton(
                                        width: 120.w,
                                        height: 35.h,
                                        text: getTranslated("delete"),
                                        svgIcon: SvgImages.trash,
                                        iconSize: 18,
                                        iconColor: Styles.IN_ACTIVE,
                                        textColor: Styles.IN_ACTIVE,
                                        backgroundColor:
                                            Styles.IN_ACTIVE.withOpacity(0.12),
                                      ),
                                      SizedBox(
                                        width:
                                            Dimensions.PADDING_SIZE_DEFAULT.w,
                                      )
                                    ],
                                  ),
                                  direction: DismissDirection.endToStart,
                                  key: ValueKey(index),
                                  confirmDismiss:
                                      (DismissDirection direction) async {
                                    NotificationsBloc.instance
                                        .add(Delete(arguments: 0));
                                    return false;
                                  },
                                  child: NotificationCard(
                                    withBorder: index != 9,
                                    notification: NotificationItem(),
                                  ),
                                ))),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
