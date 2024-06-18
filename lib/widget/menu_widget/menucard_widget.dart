import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:warmindo_user_ui/pages/detail-menu_page/view/detail_menu_page.dart';
import 'package:warmindo_user_ui/common/model/menu_list_API_model.dart';
import 'package:warmindo_user_ui/common/model/menu_model.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import 'package:warmindo_user_ui/widget/shimmer/shimmer.dart';

import '../../common/model/cartmodel.dart';
import '../../pages/cart_page/controller/cart_controller.dart';
import '../../pages/menu_page/controller/menu_controller.dart';
import '../../routes/AppPages.dart';
import '../../utils/themes/color_themes.dart';
import '../../utils/themes/image_themes.dart';
import '../dashed_divider.dart';
import '../myCustomPopUp/myPopup_controller.dart';

class MenuCategory extends StatelessWidget {
  final MenuPageController menuController = Get.put(MenuPageController());
  final CartController cartController = Get.put(CartController());
  final MyCustomPopUpController popUpcontroller =
  Get.put(MyCustomPopUpController());

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
    final currencyFormat =
    NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Filter the menuList based on the secondCategory
    final filteredMenuList = menuList
        .where((menu) => menu.second_category == secondCategory)
        .toList();

    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        DashedDivider(
          height: 0.4,
          dashSpace: 2,
          dashWidth: 2,
          color: Colors.grey,
        ),
        SizedBox(
          height: 10,
        ),
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
            return Obx(() {
              final cartItem = cartController.cartItems.firstWhereOrNull((item) => item.productId == menu.menuId);
              final menuQuantity = cartItem?.quantity.value ?? 0;
              return GestureDetector(
                onTap: () {
                  Get.toNamed(
                    Routes.DETAIL_MENU_PAGE,
                    arguments: {
                      'menu': menu,
                      'isGuest': isGuest,
                    },
                  );
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
                      Expanded(
                        child: ListTile(
                          title: Text(
                            menu.nameMenu,
                            style: regularInputTextStyle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle:
                              Padding(
                                padding: EdgeInsets.only(bottom: screenHeight * 0.054),
                                child:    Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      menu.description,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: descriptionTextStyle,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            currencyFormat.format(menu.price),
                                            style: menuPriceTextStyle,
                                          ),
                                          Spacer(),

                                          Visibility(
                                            visible: menuQuantity > 0,
                                            child: InkWell(
                                              onTap: () {
                                                if (isGuest) {
                                                  popUpcontroller
                                                      .showCustomModalForGuest(context);
                                                } else {
                                                  popUpcontroller.showCustomModalForItem(menu, context,cartItem!);
                                                }
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10, vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(color: Colors.black),
                                                  borderRadius:
                                                  BorderRadius.circular(5),
                                                ),
                                                child: Text(
                                                  '${menuQuantity.toString()} Item',overflow: TextOverflow.ellipsis,
                                                  style: bold12,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: menuQuantity == 0,
                                            child: InkWell(
                                              onTap: () {
                                                if (isGuest) {
                                                  popUpcontroller
                                                      .showCustomModalForGuest(context);
                                                } else {
                                                  final cartItem = CartItem(
                                                    productId: menu.menuId,
                                                    productName: menu.nameMenu,
                                                    price: menu.price.toInt(),
                                                    quantity: 1.obs,
                                                    productImage: menu.image,
                                                  );

                                                  popUpcontroller.addToCart(cartItem);
                                                  popUpcontroller.showCustomModalForItem(menu, context,cartItem);
                                                }
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                  BorderRadius.circular(5),
                                                ),
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
          },
        ),
        SizedBox(
          height: 10,
        ),
        DashedDivider(
          height: 0.4,
          dashSpace: 2,
          dashWidth: 2,
          color: Colors.grey,
        ),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
