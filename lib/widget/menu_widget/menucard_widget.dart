import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:warmindo_user_ui/pages/detail-menu_page/view/detail_menu_page.dart';
import 'package:warmindo_user_ui/common/model/menu_list_API_model.dart';
import 'package:warmindo_user_ui/common/model/menu_model.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import 'package:warmindo_user_ui/widget/shimmer/shimmer.dart';

import '../../pages/menu_page/controller/menu_controller.dart';
import '../../utils/themes/color_themes.dart';
import '../../utils/themes/image_themes.dart';
import '../dashed_divider.dart';
import '../myCustomPopUp/myPopup_controller.dart';

class MenuCategory extends StatelessWidget {
  final MenuPageController menuController = Get.put(MenuPageController());
  final MyCustomPopUpController popUpcontroller = Get.put(MyCustomPopUpController());

  final String? secondCategory;
  final bool isGuest;
  final List<MenuList> menuList;
  final BuildContext context;

  MenuCategory({
    Key? key,
    required this.menuList,
    required this.context,
    required this.isGuest,
     this.secondCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Filter the menuList based on the secondCategory
    final filteredMenuList = menuList.where((menu) => menu.second_category == secondCategory).toList();

    return Column(
        children: [
          SizedBox(height: 10,),
          DashedDivider(
            height: 1,dashSpace: 1.2,dashWidth: 4,color: Colors.black,
          ),
          SizedBox(height: 10,),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 260,
            ),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: filteredMenuList.length,
            itemBuilder: (context, index) {
              final menu = filteredMenuList[index];
              return GestureDetector(
                onTap: () {
                  Get.to(DetailMenuPage(
                    menu: menu,
                    isGuest: isGuest,
                  ));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  width: screenWidth * 0.43,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      ),
                    ],
                    color: ColorResources.backgroundCardColor,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 104,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              child: FadeInImage(
                                image: NetworkImage(menu.image),
                                fit: BoxFit.cover,
                                placeholder: AssetImage(Images.placeholder),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ListTile(
                        title: Text(
                          menu.nameMenu,
                          style: regularInputTextStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 3),
                            Text(
                              menu.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: descriptionTextStyle,
                            ),
                            SizedBox(height: screenHeight * 0.03),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    currencyFormat.format(menu.price),
                                    style: menuPriceTextStyle,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (isGuest == true) {
                                        popUpcontroller.showCustomModalForGuest(context);
                                      } else {
                                        popUpcontroller.showCustomModalForItem(menu, context);
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 10,),
          DashedDivider(
            height: 1,dashSpace: 1.2,dashWidth: 4,color: Colors.black,
          ),
          SizedBox(height: 50,),
        ],
      );
  }
}
