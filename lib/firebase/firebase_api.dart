import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:warmindo_user_ui/firebase/firebase_options.dart';


class FirebaseApi{
  final firebaseMessaging = FirebaseMessaging.instance;
  static final channel = AndroidNotificationChannel(
      'high_importance_channel',
    'High Importance Channel',
    importance: Importance.high
  );
  static final flutterNotificationPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> InitLocalNotifications() async{
   await flutterNotificationPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
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
      );
    }
  }
  static Future<void> handleBackgroundMessaging(RemoteMessage message) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Message data ${message.data}');
  }


  Future<void> initNotifications() async {
    try {
      await firebaseMessaging.requestPermission(
        alert: true,
        sound: true,
        badge: true,
        provisional: false,
      );

      final fCMToken = await firebaseMessaging.getToken();
      print('Token : $fCMToken');

      FirebaseMessaging.onMessage.listen(FirebaseApi.handleMessage);
      FirebaseMessaging.onBackgroundMessage(handleBackgroundMessaging);

      await InitLocalNotifications();
    } catch (e) {
      print('Error initializing notifications: $e');
      print('error disini');
    }
  }




}
