import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:warmindo_user_ui/pages/detail-menu_page/view/detail_menu_page.dart';
import 'package:warmindo_user_ui/pages/menu_page/model/menu_model.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import 'package:warmindo_user_ui/widget/shimmer/shimmer.dart';

import '../pages/menu_page/controller/menu_controller.dart';
import '../utils/themes/color_themes.dart';
import '../utils/themes/image_themes.dart';
import 'myCustomPopUp/myPopup_controller.dart';

class MenuCategory extends StatelessWidget {
  final MenuPageController menuController = Get.put(MenuPageController());
  final popUpcontroller = Get.put(MyCustomPopUpController());
  final String categoryName;
  final List<Menu> menuList;
  final BuildContext context;
   MenuCategory({
    Key? key,
    required this.categoryName,
    required this.menuList,
    required this.context
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            categoryName,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 10,
        ),

        Obx((){
          return menuController.isLoading.value ?
          GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 1.60),
          physics: NeverScrollableScrollPhysics(),
            children: [
          Container(
              margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
              child: Skeleton(width: 60, radius: 20,)),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                  child: Skeleton(width: 60,radius: 20,)),
              Container(margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),child: Skeleton(width: 60,radius: 20,)),
              Container(margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),child: Skeleton(width: 60,radius: 20,)),
              Container(margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),child: Skeleton(width: 60,radius: 20,)),
              Container(margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),child: Skeleton(width: 60,radius: 20,))
            ],

          ) :        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 260,
          ),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: menuList.length,
          itemBuilder: (context, index) {
            final menu = menuList[index];
            return GestureDetector(
              onTap: () {
                Get.to(DetailMenuPage(menu: menu));
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
                              image: AssetImage(menu.imagePath),
                              fit: BoxFit.cover,
                              placeholder: AssetImage(Images.placeholder),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      title: Text(menu.name, style: regularInputTextStyle),
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
                                    popUpcontroller.showCustomModalForItem(menu, context);
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
        );
        }),
      ],
    );
  }
}

