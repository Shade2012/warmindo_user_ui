import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/edit-profile/controller/edit_profile_controller.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileController>(() => EditProfileController());
  }
}