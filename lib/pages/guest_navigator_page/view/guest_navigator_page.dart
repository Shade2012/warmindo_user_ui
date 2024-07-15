import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/guest_home_page/view/guest_home_page.dart';
import 'package:warmindo_user_ui/pages/guest_menu_page/view/guest_menu_page.dart';
import 'package:warmindo_user_ui/pages/guest_navigator_page/controller/guest_navigator_controller.dart';
import 'package:warmindo_user_ui/pages/guest_profile_page/view/guest_profile_page.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';
import 'package:warmindo_user_ui/utils/themes/icon_themes.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';

class GuestNavigatorPage extends StatelessWidget {
  final GuestNavigatorController controller = Get.put(GuestNavigatorController());

  final List<Widget> pages = [
    GuestHomePage(),
    GuestMenuPage(),
    const GuestProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(() => pages[controller.currentIndex.value]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.changeIndex(1);
        },
        child: Obx(() => SvgPicture.asset(controller.currentIndex.value == 1 ? IconThemes.guest_iconmenuSelected : IconThemes.guest_iconmenu, color: Colors.white)),
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
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SizedBox.shrink(),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedLabelStyle: BottomNavbarSelectedTextStyle,
        unselectedLabelStyle: BottomNavbarUnselectedTextStyle,
      )),
    );
  }
}
