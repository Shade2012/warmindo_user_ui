import 'package:get/get.dart';

import '../../menu_page/model/menu_model.dart';


class DetailMenuController extends GetxController {
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
