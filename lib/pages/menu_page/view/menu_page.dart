import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import 'package:warmindo_user_ui/widget/custom_search_bar.dart';
import 'package:warmindo_user_ui/widget/menucard_widget.dart'; // Pastikan import MenuCategory
import 'package:warmindo_user_ui/pages/menu_page/model/menu_model.dart'; // Pastikan import model menu dan SearchController

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final int initialTabIndex = Get.arguments ?? 0;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    List<Menu> drinksList =
        menuList.where((menu) => menu.category == 'Minuman').toList();
    List<Menu> foodList =
        menuList.where((menu) => menu.category == 'Makanan').toList();
    List<Menu> snackList =
        menuList.where((menu) => menu.category == 'Snack').toList();

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
              controller: SearchController(),
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
        body: TabBarView(
          children: [
            // Menampilkan semua menu
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: MenuCategory(
                  categoryName: 'All',
                  menuList: menuList,context: context
                ),
              ),
            ),
            // Menampilkan menu minuman
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: MenuCategory(
                  categoryName: 'Minuman',
                  menuList: drinksList,context: context
                ),
              ),
            ),
            // Menampilkan menu makanan
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: MenuCategory(
                  categoryName: 'Makanan',
                  menuList: foodList, context: context,
                ),
              ),
            ),
            // Menampilkan menu snack
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: MenuCategory(
                  categoryName: 'Snack',
                  menuList: snackList,context: context
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
