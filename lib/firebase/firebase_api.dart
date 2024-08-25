import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warmindo_user_ui/firebase/firebase_options.dart';
import 'package:warmindo_user_ui/main.dart';
import 'package:warmindo_user_ui/routes/AppPages.dart';
import '../pages/history_page/controller/history_controller.dart';

class FirebaseApi {
  final firebaseMessaging = FirebaseMessaging.instance;
  static final channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Channel',
    importance: Importance.high,
  );
  static final flutterNotificationPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initLocalNotifications() async {
    final InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );

    await flutterNotificationPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        print("Notification clicked: ${response.payload}");
        handleNotificationClick(response.payload);
      },
      onDidReceiveBackgroundNotificationResponse: (NotificationResponse response) async {
        print("Notification clicked in background: ${response.payload}");
        handleNotificationClick(response.payload);
      },
    );

    await flutterNotificationPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  }

  static void handleNotificationClick(String? payload) async {
    if (payload != null) {
      print("Handling notification click, payload: $payload");
      final RegExp regExp = RegExp(r'order id (\d+)');
      final match = regExp.firstMatch(payload.toLowerCase());
      if (match != null) {
        final orderId = int.parse(match.group(1)!);
        print("Order ID extracted: $orderId");
        HistoryController historyController = Get.put(HistoryController());
        await historyController.fetchHistorywithoutLoading();
        final order = historyController.orders2.firstWhere((element) => element.id == orderId);
        if (order != null) {
          print("Navigating to HistoryDetailPage for order ID: $orderId");
          navigatorKey.currentState?.pushNamed(Routes.HISTORYDETAIL_PAGE, arguments: order);
          // navigatorKey.currentState?.pushNamed(Routes.HISTORYDETAIL_PAGE, arguments: {'order': order});
        } else {
          print("Order with ID $orderId not found in history.");
        }
      } else {
        print("Order ID not found in the notification payload.");
      }
    } else {
      print("Notification payload is null.");
    }
  }

  static Future<void> handleMessage(RemoteMessage message) async {
    if (message.notification != null) {
      RemoteNotification notification = message.notification!;
      flutterNotificationPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            icon: '@mipmap/ic_launcher',
          ),
        ),
        payload: message.notification?.body, // Attach the notification body as payload
      );
      final body = message.notification?.body?.toLowerCase() ?? '';
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token != null) {
        if (body.contains('pembayaran') || body.contains('order')) {
          HistoryController historyController = Get.put(HistoryController());
          await historyController.fetchHistorywithoutLoading();
        }else{
          return;
        }
      }
    }
  }

  static Future<void> handleBackgroundMessaging(RemoteMessage message) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    if (message.notification != null) {
      flutterNotificationPlugin.show(
        message.notification.hashCode,
        message.notification?.title,
        message.notification?.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            icon: '@mipmap/ic_launcher',
          ),
        ),
        payload: message.notification?.body, // Attach the notification body as payload
      );
      final body = message.notification?.body?.toLowerCase() ?? '';
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token != null) {
        if (body.contains('pembayaran') || body.contains('order')) {
          HistoryController historyController = Get.put(HistoryController());
          await historyController.fetchHistorywithoutLoading();
        }else{
          return;
        }
      }
    }
  }

  Future<void> initNotifications() async {
    try {
      await firebaseMessaging.requestPermission(
        alert: true,
        sound: true,
        badge: true,
        provisional: false,
      );

      FirebaseMessaging.onMessage.listen(FirebaseApi.handleMessage);
      FirebaseMessaging.onBackgroundMessage(FirebaseApi.handleBackgroundMessaging);
      await FirebaseApi.initLocalNotifications();
    } catch (e) {
      print('Error initializing notifications: $e');
    }
  }
}
