

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/menu_page/controller/menu_controller.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import 'package:warmindo_user_ui/widget/custom_search_bar.dart';
import 'package:warmindo_user_ui/widget/menu_widget/menuCardSecondCategory.dart';
import '../../../widget/menu_widget/search.dart';
import '../../guest_menu_page/controller/guest_menu_controller.dart';
import '../../navigator_page/controller/navigator_controller.dart';

class MenuPage extends StatelessWidget {
  final NavigatorController navigatorController = Get.find<NavigatorController>();
  final GuestMenuController guestMenuController = Get.put(GuestMenuController());
  final MenuPageController controller = Get.put(MenuPageController());

   MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if(didPop){
          navigatorController.goToHomePage();
          return;
        }
        navigatorController.goToHomePage();
        return;
      },
      child: DefaultTabController(
        initialIndex: navigatorController.menuPageArgument.value,
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
            if(controller.searchObx.value != ''){
              if (controller.searchResults.isEmpty) {
                return
                    const Center(child: Text('Produk tidak ditemukan'),);
              }else  {
                return Search(
                  categoryName: 'Search Results',
                  menuList: controller.searchResults,
                  context: context,
                  isGuest: false,
                );
              }
            }
            else if (!controller.isConnected.value) {
            return Center(
              child: Text(
                'Tidak ada koneksi internet mohon check koneksi internet anda',
                style: boldTextStyle,textAlign: TextAlign.center,
              ),
            );
          }

            else {
              return TabBarView(
                children: [
                  MenuSecondCategory(
                    categoryName: 'All',
                    menuList: controller.menuElement,
                    isGuest: false,
                  ),
                  MenuSecondCategory(
                    categoryName: 'Minuman',
                    menuList: controller.menuElement.where((menu) => menu.category.toLowerCase() == 'minuman').toList(),
                    isGuest: false,
                  ),
                  MenuSecondCategory(
                    categoryName: 'Makanan',
                    menuList: controller.menuElement.where((menu) => menu.category.toLowerCase() == 'makanan').toList(),
                    isGuest: false,
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
