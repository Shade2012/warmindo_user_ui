import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:warmindo_user_ui/pages/cart_page/controller/cart_controller.dart';
import 'package:warmindo_user_ui/pages/detail-menu_page/view/detail_menu_page.dart';
import 'package:warmindo_user_ui/common/model/menu_list_API_model.dart';
import 'package:warmindo_user_ui/common/model/menu_model.dart';
import 'package:warmindo_user_ui/pages/guest_menu_page/controller/guest_menu_controller.dart';
import 'package:warmindo_user_ui/pages/menu_page/shimmer/menushimmer.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import 'package:warmindo_user_ui/widget/dashed_divider.dart';
import 'package:warmindo_user_ui/widget/menu_widget/all.dart';
import 'package:warmindo_user_ui/widget/menu_widget/makanan.dart';
import 'package:warmindo_user_ui/widget/menu_widget/minuman.dart';
import 'package:warmindo_user_ui/widget/menu_widget/snack.dart';
import 'package:warmindo_user_ui/widget/shimmer/shimmer.dart';

import '../../pages/menu_page/controller/menu_controller.dart';
import '../../utils/themes/color_themes.dart';
import '../../utils/themes/image_themes.dart';
import 'menucard_widget.dart';
import '../myCustomPopUp/myPopup_controller.dart';

class MenuSecondCategory extends StatelessWidget {
  final String categoryName;
  final List<MenuList> menuList;
  final bool isGuest;

  MenuSecondCategory({
    Key? key,
    required this.categoryName, required this.menuList, required this.isGuest,
  }) : super(key: key);

  final MenuPageController menuController = Get.find<MenuPageController>();
  final CartController cartController = Get.find<CartController>();
  final GuestMenuController guestMenuController = Get.find<GuestMenuController>();

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return RefreshIndicator(
      onRefresh: () async {
        await cartController.fetchUser();
        await menuController.fetchProduct();
        await guestMenuController.fetchProduct();
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Obx(() {
              if(menuController.isLoading.value || guestMenuController.isLoading.value){
                return MenuShimmer();
                // return GridView.count(
                //   crossAxisCount: 2,
                //   shrinkWrap: true,
                //   childAspectRatio: MediaQuery.of(context).size.width /
                //       (MediaQuery.of(context).size.height / 1.60),
                //   physics: NeverScrollableScrollPhysics(),
                //   children: [
                //     Container(
                //         margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                //         child: Skeleton(width: 60, radius: 20)),
                //     Container(
                //         margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                //         child: Skeleton(width: 60, radius: 20)),
                //     Container(
                //         margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                //         child: Skeleton(width: 60, radius: 20)),
                //     Container(
                //         margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                //         child: Skeleton(width: 60, radius: 20)),
                //     Container(
                //         margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                //         child: Skeleton(width: 60, radius: 20)),
                //     Container(
                //         margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                //         child: Skeleton(width: 60, radius: 20)),
                //   ],
                // );
              }else{
                if(categoryName == "Snack"){
                  return SnackMenu(menuList: menuList, isGuest: isGuest,);
                } else if (categoryName == "Minuman"){
                  return  MinumanMenu(menuList: menuList, isGuest: isGuest,);
                }else if (categoryName == "Makanan"){
                  return  MakananMenu(menuList: menuList, isGuest: isGuest,);
                }else {
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
