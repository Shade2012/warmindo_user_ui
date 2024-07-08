import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warmindo_user_ui/routes/AppPages.dart';
import 'package:http/http.dart' as http;

import '../../../common/global_variables.dart';

class ProfileController extends GetxController {
  RxBool isLoading = true.obs;
  RxString txtUsername = "".obs;
  RxString txtName = "".obs;
  RxString token = "".obs;
  RxBool isConnected = true.obs;
  SharedPreferences? prefs;

  @override
  void onInit() {
    super.onInit();
    checkConnectivity();
  }

  Future<void> initializePrefs() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
  }

  void checkSharedPreference() async {
    await initializePrefs();
    if (prefs != null) {
      token.value = prefs!.getString('token') ?? '';

      try {
        isLoading.value = true; // Set loading to true before fetching data
        final response = await http.get(
          Uri.parse(GlobalVariables.apiDetailUser),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);

          if (data['success']) {
            txtName.value = data['user']['name'];
            txtUsername.value = data['user']['username'];
            print("Fetched username: ${txtUsername.value}");
          } else {
            print('Error: ${data['message']}');
          }
        } else {
          print('Error: ${response.statusCode}');
        }
      } catch (e) {
        print('Exception: $e');
      } finally {
        isLoading.value = false; // Set loading to false after data is fetched
      }
      print('object2');
    }
  }

  void checkConnectivity() async {
    await initializePrefs();
    if (prefs != null) {
      txtUsername.value = prefs!.getString('username') ?? '';
      token.value = prefs!.getString('token') ?? '';
    }
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      isConnected.value = result != ConnectivityResult.none;
      if (isConnected.value) {
        checkSharedPreference();
      }
    });

    var connectivityResult = await Connectivity().checkConnectivity();
    isConnected.value = connectivityResult != ConnectivityResult.none;
    if (isConnected.value) {
      checkSharedPreference();
    }
  }

  void logOut() async {
    await initializePrefs();
    if (prefs != null) {
      await GoogleSignIn().signOut();
      prefs!.remove('username');
      prefs!.remove('token2');
      prefs!.remove('token');
      Get.offAllNamed(Routes.SPLASH_SCREEN);
    }
  }
}
