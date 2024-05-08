import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/menu_page/model/menu_model.dart';

class HomeController extends GetxController {
  RxList<Menu> menu = <Menu>[].obs;
@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchProduct();
  }
  void fetchProduct()  {
        menu.assignAll(menuList);
  }
}
