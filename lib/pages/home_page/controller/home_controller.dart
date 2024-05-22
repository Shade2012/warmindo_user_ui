import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:warmindo_user_ui/pages/menu_page/model/menu_model.dart';

import '../view/home_detaile_page.dart';

class HomeController extends GetxController {
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
    final filteredMenu = menuList.where((menu) => menu.price < priceThreshold).toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FilteredMenuPage(filteredMenu: filteredMenu,price: priceThreshold),
      ),
    );
  }
}

