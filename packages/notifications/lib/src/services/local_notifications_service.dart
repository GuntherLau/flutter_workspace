import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:utils/main.dart';

import '../model/received_notification.dart';


String? selectedNotificationPayload;

/// A notification action which triggers a url launch event
const String urlLaunchActionId = 'id_1';

/// A notification action which triggers a App navigation event
const String navigationActionId = 'id_3';

/// Defines a iOS/MacOS notification category for text input actions.
const String darwinNotificationCategoryText = 'textCategory';

/// Defines a iOS/MacOS notification category for plain actions.
const String darwinNotificationCategoryPlain = 'plainCategory';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print('notification action tapped with input: ${notificationResponse.input}');
  }
}

class LocalNotificationsService {
  LocalNotificationsService._();

  static LocalNotificationsService? _instance;

  static LocalNotificationsService _getInstance() {
    _instance ??= LocalNotificationsService._();
    return _instance!;
  }

  static LocalNotificationsService get instance => _getInstance();

  factory LocalNotificationsService() => _getInstance();

  // Logger log = Logger();

  bool _notificationsEnabled = false;

  int id = 0;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  /// Streams are created so that app can respond to notification-related events
  /// since the plugin is initialised in the `main` function
  final StreamController<ReceivedNotification> didReceiveLocalNotificationStream = StreamController<ReceivedNotification>.broadcast();
  final StreamController<String?> selectNotificationStream = StreamController<String?>.broadcast();

  Future<void> init() async {



    await _configureLocalTimeZone();
    //
    // final NotificationAppLaunchDetails? notificationAppLaunchDetails = !kIsWeb &&
    //     Platform.isLinux
    //     ? null
    //     : await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    // String initialRoute = Routes.testPage;
    // if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    //   selectedNotificationPayload = notificationAppLaunchDetails!.notificationResponse?.payload;
    //   initialRoute = Routes.testPage;
    // }

    _isAndroidPermissionGranted();
    requestPermissions();
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');

    final List<DarwinNotificationCategory> darwinNotificationCategories =
    <DarwinNotificationCategory>[
      DarwinNotificationCategory(
        darwinNotificationCategoryText,
        actions: <DarwinNotificationAction>[
          DarwinNotificationAction.text(
            'text_1',
            'Action 1',
            buttonTitle: 'Send',
            placeholder: 'Placeholder',
          ),
        ],
      ),
      DarwinNotificationCategory(
        darwinNotificationCategoryPlain,
        actions: <DarwinNotificationAction>[
          DarwinNotificationAction.plain('id_1', 'Action 1'),
          DarwinNotificationAction.plain(
            'id_2',
            'Action 2 (destructive)',
            options: <DarwinNotificationActionOption>{
              DarwinNotificationActionOption.destructive,
            },
          ),
          DarwinNotificationAction.plain(
            navigationActionId,
            'Action 3 (foreground)',
            options: <DarwinNotificationActionOption>{
              DarwinNotificationActionOption.foreground,
            },
          ),
          DarwinNotificationAction.plain(
            'id_4',
            'Action 4 (auth required)',
            options: <DarwinNotificationActionOption>{
              DarwinNotificationActionOption.authenticationRequired,
            },
          ),
        ],
        options: <DarwinNotificationCategoryOption>{
          DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
        },
      )
    ];

    /// Note: permissions aren't requested here just to demonstrate that can be
    /// done later
    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      // onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {
      //   didReceiveLocalNotificationStream.add(
      //     ReceivedNotification(
      //       id: id,
      //       title: title,
      //       body: body,
      //       payload: payload,
      //     ),
      //   );
      // },
      notificationCategories: darwinNotificationCategories,
    );
    final LinuxInitializationSettings initializationSettingsLinux =
    LinuxInitializationSettings(
      defaultActionName: 'Open notification',
      defaultIcon: AssetsLinuxIcon('icons/app_icon.png'),
    );
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            selectNotificationStream.add(notificationResponse.payload);
            break;
          case NotificationResponseType.selectedNotificationAction:
            if (notificationResponse.actionId == navigationActionId) {
              selectNotificationStream.add(notificationResponse.payload);
            }
            break;
        }
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    // log.d("LocalNotificationsService init success.");
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  Future<void> _isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.areNotificationsEnabled() ??
          false;

      _notificationsEnabled = granted;
    }
  }

  Future<bool> requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      final bool? grantedNotificationPermission = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      _notificationsEnabled = grantedNotificationPermission ?? false;
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      final bool? grantedNotificationPermission = await androidImplementation?.requestNotificationsPermission();
      _notificationsEnabled = grantedNotificationPermission ?? false;
    }
    return _notificationsEnabled;
  }

  Future<NotificationsEnabledOptions?> checkNotificationsOnCupertino(BuildContext context) async {
    final NotificationsEnabledOptions? isEnabled =
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
            ?.checkPermissions() ??
            await flutterLocalNotificationsPlugin
                .resolvePlatformSpecificImplementation<
                MacOSFlutterLocalNotificationsPlugin>()
                ?.checkPermissions();
    final String isEnabledString = isEnabled == null
        ? 'ERROR: received null'
        : '''
    isEnabled: ${isEnabled.isEnabled}
    isSoundEnabled: ${isEnabled.isSoundEnabled}
    isAlertEnabled: ${isEnabled.isAlertEnabled}
    isBadgeEnabled: ${isEnabled.isBadgeEnabled}
    isProvisionalEnabled: ${isEnabled.isProvisionalEnabled}
    isCriticalEnabled: ${isEnabled.isCriticalEnabled}
    ''';
    // log.d(isEnabledString);
    return isEnabled;
    // await showDialog<void>(
    //     context: context,
    //     builder: (BuildContext context) => AlertDialog(
    //       content: Text(isEnabledString),
    //       actions: <Widget>[
    //         TextButton(
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //           child: const Text('OK'),
    //         ),
    //       ],
    //     ));
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationStream.stream.listen((ReceivedNotification receivedNotification) async {

      print("_configureDidReceiveLocalNotificationSubject receivedNotification:$receivedNotification");

    });
  }

  void _configureSelectNotificationSubject() {
    selectNotificationStream.stream.listen((String? payload) async {
      // await Navigator.of(context).push(MaterialPageRoute<void>(
      //   builder: (BuildContext context) => SecondPage(payload),
      // ));
      print("======>>>>>>点击推送消息");
      print("_configureSelectNotificationSubject payload:$payload");
      // HudService.showSuccess(payload!);
    });
  }

  /// 立即触发，文本通知
  Future<void> showNotificationImmediately({
    String? title,
    String? body,
    String? payload
  }) async {
    // log.d("showNotificationImmediately title:$title body:$body");
    try {
      const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails('your channel id', 'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker');
      // const DarwinNotificationDetails iosNotificationDetails = DarwinNotificationDetails();
      const NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        // iOS: iosNotificationDetails
      );
      await flutterLocalNotificationsPlugin.show(id++, title, body, notificationDetails, payload: payload);
    } catch(e) {
      // log.e(e);
    }
  }

  /// 指定时间触发，文本通知
  Future<void> scheduleDailyNotification({
    required DateTime time,
    String? title,
    String? body,
    String? payload
  }) async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
    tz.TZDateTime(tz.local, now.year, now.month, now.day, time.hour, time.minute, time.second);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    // log.d("scheduleDailyNotification time:$scheduledDate title:$title body:$body");
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id++,
        title,
        body,
        scheduledDate,
        const NotificationDetails(
          android: AndroidNotificationDetails('daily notification channel id',
              'daily notification channel name',
              channelDescription: 'daily notification description'),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: payload);
  }

  /// 取消所有通知
  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }


}