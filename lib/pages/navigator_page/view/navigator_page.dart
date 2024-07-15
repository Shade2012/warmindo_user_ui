import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/cart_page/view/cart_page.dart';
import 'package:warmindo_user_ui/pages/history_page/view/history_page.dart';
import 'package:warmindo_user_ui/pages/home_page/view/home_page.dart';
import 'package:warmindo_user_ui/pages/menu_page/view/menu_page.dart';
import 'package:warmindo_user_ui/pages/navigator_page/controller/navigator_controller.dart';
import 'package:warmindo_user_ui/pages/profile_page/view/profile_page.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';
import 'package:warmindo_user_ui/utils/themes/icon_themes.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';

class BottomNavbar extends StatelessWidget {
  final NavigatorController controller = Get.put(NavigatorController());

  final List<Widget> pages = [
    HomePage(),
    MenuPage(),
    CartPage(), // Empty Container for Cart Page (to replace with FloatingActionButton)
    HistoryPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:false,
      body:
      Obx(() => pages[controller.currentIndex.value]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.changeIndex(2);
        },
        child: Obx(() => SvgPicture.asset(controller.currentIndex.value == 2 ? IconThemes.iconcartSelected: IconThemes.iconcart)),
        backgroundColor: ColorResources.bgfloatingActionButtonColor,
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        currentIndex: controller.currentIndex.value,
        onTap: controller.changeIndex,
        backgroundColor: ColorResources.backgroundColor,
        selectedItemColor: ColorResources.selectedItemColor,
        unselectedItemColor: ColorResources.unselectedItemColor,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Obx(() => SvgPicture.asset(controller.currentIndex.value == 0 ? IconThemes.iconhomeSelected : IconThemes.iconhome)),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Obx(() => SvgPicture.asset(controller.currentIndex.value == 1 ? IconThemes.iconmenuSelected : IconThemes.iconmenu)),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: SizedBox.shrink(),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Pesanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        selectedLabelStyle: BottomNavbarSelectedTextStyle ,
        unselectedLabelStyle:BottomNavbarUnselectedTextStyle ,
      )
      ),
    );
  }
}
