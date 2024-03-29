library notification_helper;

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:huawei_push/huawei_push.dart' as huawei;
import 'package:stepOut/features/notifications/bloc/notifications_bloc.dart';
import 'package:stepOut/main_blocs/user_bloc.dart';
import '../../data/config/di.dart';
import '../../main_page/bloc/dashboard_bloc.dart';
import '../../navigation/custom_navigation.dart';
import '../../navigation/routes.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import '../core/app_event.dart';
@pragma('vm:entry-point')
part 'firebase_notification_helper.dart';
part 'notification_operation.dart';
part 'local_notification.dart';
part 'share_dynamic_link.dart';
part 'huawei_push_notification.dart';
