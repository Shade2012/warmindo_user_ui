import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/pages/guest_home_page/view/guest_home_detail_page.dart';
import '../../menu_page/model/menu_model.dart';

class GuestHomeController extends GetxController {
  RxList<Menu> menu = <Menu>[].obs;
  RxBool isLoading = true.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(Duration(seconds: 4),(){
      isLoading.value = false;
    });
    fetchProduct();
  }
  void fetchProduct()  {
    menu.assignAll(menuList);
  }
  void navigateToFilteredMenu(BuildContext context, int priceThreshold) {
    final filteredMenu = menuList.where((menu) => menu.price == priceThreshold).toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GuestFilteredMenuPage(filteredMenu: filteredMenu,price: priceThreshold),
      ),
    );
  }
}
