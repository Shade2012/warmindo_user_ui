import 'package:get/get.dart';

class ProfileController extends GetxController{
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(Duration(seconds: 4),(){
      isLoading.value = false;
    });
  }

}
