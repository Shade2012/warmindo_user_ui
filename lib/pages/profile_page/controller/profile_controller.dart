import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warmindo_user_ui/routes/AppPages.dart';

class ProfileController extends GetxController{
  RxBool isLoading = true.obs;
  RxString txtUsername = "".obs;
  RxString txtName = "".obs;
  late final SharedPreferences prefs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(Duration(seconds: 4),(){
      isLoading.value = false;
    });
    checkSharedPreference();
  }
  void checkSharedPreference() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      txtUsername.value = prefs.getString('username') ?? '';
      txtName.value = prefs.getString('name') ?? '';
    }
  }
  void logOut() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
    prefs.remove('token2');
    prefs.remove('token');
    Get.offAllNamed(Routes.SPLASH_SCREEN);
  }
}
