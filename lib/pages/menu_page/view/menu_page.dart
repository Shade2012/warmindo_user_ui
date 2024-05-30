import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:warmindo_user_ui/common/model/menu_list_API_model.dart';
import 'package:warmindo_user_ui/pages/menu_page/controller/menu_controller.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import 'package:warmindo_user_ui/widget/custom_search_bar.dart';
import 'package:warmindo_user_ui/widget/menucard_widget.dart'; // Pastikan import MenuCategory
import 'package:warmindo_user_ui/common/model/menu_model.dart';

import '../../home_page/controller/home_controller.dart'; // Pastikan import model menu dan SearchController

class MenuPage extends StatelessWidget {
   MenuPage({Key? key}) : super(key: key);
  final MenuPageController controller = Get.put(MenuPageController());
  @override
  Widget build(BuildContext context) {

    final int initialTabIndex = Get.arguments ?? 0;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    List<MenuList> drinksList =
    controller.menuElement.where((menu) => menu.category.toLowerCase() == 'minuman').toList();
    List<MenuList> foodList =
    controller.menuElement.where((menu) => menu.category.toLowerCase() == 'makanan').toList();
    List<MenuList> snackList =
    controller.menuElement.where((menu) => menu.category.toLowerCase() == 'snack').toList();


    return DefaultTabController(
      initialIndex: initialTabIndex,
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(110),
          child: AppBar(
            backgroundColor: ColorResources.primaryColor,
            title: CustomSearchBar(
              hintText: 'Mau makan apa hari ini?',
              controller: controller.search,
              onChanged: (query){
                print(query);{
                  controller.searchFilter(query);
                  print(controller.searchResults);
                }
              },
            ),
            automaticallyImplyLeading: false,
            bottom: TabBar(
              labelPadding: EdgeInsets.only(bottom: 10),
              indicatorPadding: EdgeInsets.only(bottom: 10),
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
                    style: categoryMenuTextStyle,overflow: TextOverflow.ellipsis,
                  ),
                ),
                Tab(
                  child: Text(
                    'Snack',
                    style: categoryMenuTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
        body:Obx(() {
          if (controller.searchResults.isNotEmpty) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: MenuCategory(
                  categoryName: 'Search Results',
                  menuList: controller.searchResults,
                  context: context,
                  isGuest: false,
                ),
              ),
            );
          } else {
            return TabBarView(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: MenuCategory(
                      categoryName: 'All',
                      menuList: controller.menuElement,
                      context: context,
                      isGuest: false,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: MenuCategory(
                      categoryName: 'Minuman',
                      menuList: drinksList,
                      context: context,
                      isGuest: false,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: MenuCategory(
                      categoryName: 'Makanan',
                      menuList: foodList,
                      context: context,
                      isGuest: false,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: MenuCategory(
                      categoryName: 'Snack',
                      menuList: snackList,
                      context: context,
                      isGuest: false,
                    ),
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
