import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/routes/AppPages.dart';
import 'firebase/firebase_api.dart';
import 'firebase/firebase_options.dart';
final navigatorKey = GlobalKey<NavigatorState>();
  void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: 'default-firebase',
      options: DefaultFirebaseOptions.currentPlatform
  );
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Warmindo User UI',
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      navigatorKey: navigatorKey,
    );
  }
}
