import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/cart_page/controller/cart_controller.dart';
import 'package:warmindo_user_ui/pages/guest_navigator_page/controller/guest_navigator_controller.dart';
import 'package:warmindo_user_ui/pages/menu_page/controller/menu_controller.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import 'package:warmindo_user_ui/widget/custom_search_bar.dart';
import 'package:warmindo_user_ui/widget/menu_widget/menuCardSecondCategory.dart';


import '../../../widget/menu_widget/search.dart';
import '../controller/guest_menu_controller.dart';

class GuestMenuPage extends StatelessWidget {
  GuestMenuPage({super.key});
  final GuestNavigatorController navigatorController = Get.find<GuestNavigatorController>();
  final GuestMenuController controller = Get.put(GuestMenuController());
  final CartController cartController = Get.put(CartController());
  final MenuPageController menuPageController = Get.put(MenuPageController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if(didPop){
          navigatorController.goToGuestHomePage();
          return;
        }
        navigatorController.goToGuestHomePage();
        return;
      },
      child: DefaultTabController(
        initialIndex: navigatorController.guestMenuPageArgument.value,
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(110),
            child: AppBar(
              backgroundColor: ColorResources.primaryColor,
              title: CustomSearchBar(
                hintText: 'Mau makan apa hari ini?',
                controller: controller.search,
                onChanged: (query) {
                  controller.searchFilter(query);
                },
              ),
              automaticallyImplyLeading: false,
              bottom: TabBar(
                labelPadding: const EdgeInsets.only(bottom: 10),
                indicatorPadding: const EdgeInsets.only(bottom: 10),
                indicatorColor: ColorResources.backgroundCardColor,
                tabs: [
                  Tab(
                    child: Text(
                      'All',
                      style: categoryMenuTextStyle,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Minuman',
                      style: categoryMenuTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Makanan',
                      style: categoryMenuTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Obx(() {
          if (!controller.isConnected.value) {
            return Center(
              child: Text(
                'Tidak ada koneksi internet mohon check koneksi internet anda',
                style: boldTextStyle,textAlign: TextAlign.center,
              ),
            );
          }
         else if(controller.searchObx.value != ''){
            if (controller.searchResults.length == 0) {
              return
                const Center(child: Text('Produk tidak ditemukan'),);
            }else  {
              return Search(
                categoryName: 'Search Results',
                menuList: controller.searchResults,
                context: context,
                isGuest: true,
              );
            }
          } else {
            return TabBarView(
              children: [
                MenuSecondCategory(
                  categoryName: 'All',
                  menuList: controller.menuElement,
                  isGuest: true,
                ),
                MenuSecondCategory(
                  categoryName: 'Minuman',
                  menuList: controller.menuElement.where((menu) => menu.category.toLowerCase() == 'minuman').toList(),
                  isGuest: true,
                ),
                MenuSecondCategory(
                  categoryName: 'Makanan',
                  menuList: controller.menuElement.where((menu) => menu.category.toLowerCase() == 'makanan').toList(),
                  isGuest: true,
                ),
              ],
            );
          }
        }),
        ),

      ),
    );
  }
}

