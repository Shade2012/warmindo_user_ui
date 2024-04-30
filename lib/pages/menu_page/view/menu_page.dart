import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import 'package:warmindo_user_ui/widget/custom_search_bar.dart';
import 'package:warmindo_user_ui/widget/menucard_widget.dart'; // Pastikan import MenuCategory
import 'package:warmindo_user_ui/pages/menu_page/model/menu_model.dart'; // Pastikan import model menu dan SearchController

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Menu> drinksList =
        menuList.where((menu) => menu.category == 'Minuman').toList();
    List<Menu> foodList =
        menuList.where((menu) => menu.category == 'Makanan').toList();
    List<Menu> snackList =
        menuList.where((menu) => menu.category == 'Snack').toList();

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: AppBar(
            backgroundColor: ColorResources.primaryColor,
            title: CustomSearchBar(
              hintText: 'Mau makan apa hari ini?',
              controller: SearchController(),
            ),
            bottom: TabBar(
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
                  ),
                ),
                Tab(
                  child: Text(
                    'Makanan',
                    style: categoryMenuTextStyle,
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
              child: MenuCategory(
                categoryName: 'All',
                menuList: menuList,
              ),
            ),
            // Menampilkan menu minuman
            SingleChildScrollView(
              child: MenuCategory(
                categoryName: 'Minuman',
                menuList: drinksList,
              ),
            ),
            // Menampilkan menu makanan
            SingleChildScrollView(
              child: MenuCategory(
                categoryName: 'Makanan',
                menuList: foodList,
              ),
            ),
            // Menampilkan menu snack
            SingleChildScrollView(
              child: MenuCategory(
                categoryName: 'Snack',
                menuList: snackList,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
