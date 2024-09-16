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
  RxString image = "".obs;
  RxString user_verified = '0'.obs;
  RxString token = "".obs;
  RxString isLoginGoogle = "".obs;
  RxBool isConnected = true.obs;
  SharedPreferences? prefs;

  @override
  void onInit() {
    super.onInit();
    checkConnectivity();
  }

  Future<void> initializePrefs() async {
    prefs ??= await SharedPreferences.getInstance();
  }
  void checkSharedPreference() async {
    await initializePrefs();
    if (prefs != null) {
      token.value = prefs!.getString('token') ?? '';
      isLoginGoogle.value = prefs!.getString('isLoginGoogle') ?? '';

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
            image.value = data['user']['profile_picture'] ?? '';
            user_verified.value = data['user']['user_verified'];
          }
        }
      } catch (e) {
        Get.snackbar('Error', '$e');
      } finally {
        isLoading.value = false; // Set loading to false after data is fetched
      }
    }
  }
Future<void> logoutFetch() async{
    final url = Uri.parse(GlobalVariables.apiLogout);
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try{
      final response = await http.post(url,headers: headers,);
      if(response.statusCode == 200){
        Get.snackbar('Pesan', 'Berhasil Log out');
      }
    }
    catch(e){
    Get.snackbar('Error', e.toString());
    }
  // apiLogout
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
      logoutFetch();
      await GoogleSignIn().signOut();
      prefs!.remove('username');
      prefs!.remove('token3');
      prefs!.remove('isLoginGoogle');
      prefs!.remove('token2');
      prefs!.remove('token');
      prefs!.remove('user_id');
      prefs!.remove('token4');
      prefs!.remove('notif_token');
      prefs?.clear();
      Get.offAllNamed(Routes.SPLASH_SCREEN);
    }
  }
}

