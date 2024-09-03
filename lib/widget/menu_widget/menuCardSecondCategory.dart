import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/cart_page/controller/cart_controller.dart';
import 'package:warmindo_user_ui/common/model/menu_list_API_model.dart';
import 'package:warmindo_user_ui/pages/guest_menu_page/controller/guest_menu_controller.dart';
import 'package:warmindo_user_ui/pages/home_page/controller/schedule_controller.dart';
import 'package:warmindo_user_ui/pages/menu_page/shimmer/menushimmer.dart';
import 'package:warmindo_user_ui/widget/menu_widget/all.dart';
import 'package:warmindo_user_ui/widget/menu_widget/makanan.dart';
import 'package:warmindo_user_ui/widget/menu_widget/minuman.dart';
import '../../pages/menu_page/controller/menu_controller.dart';
import '../myCustomPopUp/myPopup_controller.dart';

class MenuSecondCategory extends StatelessWidget {
  final String categoryName;
  final List<MenuList> menuList;
  final bool isGuest;

  MenuSecondCategory({
    super.key,
    required this.categoryName, required this.menuList, required this.isGuest,
  });

  final MenuPageController menuController = Get.find<MenuPageController>();
  final ScheduleController scheduleController  = Get.find<ScheduleController>();
  final CartController cartController = Get.find<CartController>();
  final MyCustomPopUpController popUpController = Get.put(MyCustomPopUpController());
  final GuestMenuController guestMenuController = Get.find<GuestMenuController>();

  @override
  Widget build(BuildContext context) {

    return RefreshIndicator(
      onRefresh: () async {
        if(isGuest == true){
          await scheduleController.fetchSchedule(true);
          await cartController.fetchUser();
          await cartController.fetchCart();
          await guestMenuController.fetchProduct();
          await popUpController.fetchVarian();
          await popUpController.fetchTopping();
        }else{
          await scheduleController.fetchSchedule(true);
          await cartController.fetchUser();
          await cartController.fetchCart();
          await menuController.fetchProduct();
          await popUpController.fetchVarian();
          await popUpController.fetchTopping();
        }


      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Obx(() {
              if(menuController.isLoading.value || guestMenuController.isLoading.value){
                return const MenuShimmer();
              }else{
                if (categoryName == "Minuman"){
                  // return Center(child: Text('Minuman'),);
                  return  MinumanMenu(menuList: menuList, isGuest: isGuest,);
                }else if (categoryName == "Makanan"){
                  // return Center(child: Text('Makanan'),);
                  return  MakananMenu(menuList: menuList, isGuest: isGuest,);
                }else {
                  // return Center(child: Text('All'),);
                  return AllMenu(menuList: menuList, isGuest: isGuest,);
                }
              }
            }),
          ],
        ),
      ),
    );
  }
}
