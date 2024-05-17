import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/menu_page/model/menu_model.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';

import '../utils/themes/color_themes.dart';
import 'myCustomPopUp/myPopup_controller.dart';

class MenuCategory extends StatelessWidget {
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
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 1.3),
          physics: NeverScrollableScrollPhysics(),
          children: menuList.map((menu) {
            return Container(
              width: screenWidth * 0.43,
              margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: ColorResources.backgroundCardColor,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              // Tampilkan informasi menu di sini
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(2),
                        child: Image.asset(
                          menu.imagePath,
                          width: screenWidth / 0.2,
                          height: 130,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          menu.name,
                          style: menuNameTextStyle,
                        ),
                        SizedBox(height: 5),
                        Text(
                          menu.description,
                          maxLines: 2
                          ,
                          overflow: TextOverflow.ellipsis,
                          style: menuDescTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rp ${menu.price.toInt()}',
                          style: menuPriceTextStyle,
                        ),
                        InkWell(
                          onTap: (){
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
            );
          }).toList(),
        ),
      ],
    );
  }
}

