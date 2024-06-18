import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_user_ui/common/model/menu_list_API_model.dart';
import 'package:warmindo_user_ui/common/model/menu_model.dart';
import 'package:warmindo_user_ui/pages/detail-menu_page/shimmer/bottom_detail_menu_shimmer.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';

import '../../../common/model/cartmodel.dart';
import '../../../utils/themes/image_themes.dart';
import '../../../widget/appBar.dart';
import '../../../widget/myCustomPopUp/myPopup_controller.dart';
import '../../cart_page/controller/cart_controller.dart';
import '../controller/detail_menu_controller.dart';
import '../shimmer/detail_menu_shimmer.dart';

class DetailMenuPage extends StatelessWidget {
  final CartController cartController = Get.find();
  final DetailMenuController controller = Get.put(DetailMenuController());
  final MenuList menu;
  final bool isGuest;

  DetailMenuPage({Key? key, required this.menu, required this.isGuest}) : super(key: key) {
    // Fetch the products filtered by the provided menuId
    controller.fetchProduct(menu.menuId);
  }

  @override
  Widget build(BuildContext context) {
    final popUpController = Get.put(MyCustomPopUpController());
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppbarCustom(
        title: 'Details',
        style: headerRegularStyle,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchProduct(menu.menuId);
        },
        child: SingleChildScrollView(
          child: Obx(() {
            if (!controller.isConnected.value) {
              return Center(
                child: Container(
                  margin: EdgeInsets.only(top: screenHeight * 0.3),
                  child: Text(
                    'Tidak ada koneksi internet mohon check koneksi internet anda',
                    style: boldTextStyle, textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            if (controller.isLoading.value) {
              return MenuDetailSkeleton();
            }
            if (controller.menu.isEmpty) {
              return Center(
                child: Container(
                  margin: EdgeInsets.only(top: screenHeight * 0.4),
                  child: Text(
                    'Menu not found',
                    style: boldTextStyle, textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            final menuItem = controller.menu.first;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: screenHeight * 0.3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Image.network(
                            menuItem.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(menuItem.nameMenu, style: boldTextStyle2),
                      Text(menuItem.category, style: regulargreyText),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Icon(Icons.star_rounded, color: Colors.orange, size: 23),
                              Text(menuItem.ratings.toString(), style: descriptionratingTextStyle),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      Text('Deskripsi', style: boldTextStyle),
                      Text(menuItem.description, style: onboardingskip)
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
      bottomNavigationBar: Obx(() {
        if (!controller.isConnected.value) {
          return Center(
            child: Container(
              child: Text(
                'Tidak ada koneksi internet mohon check koneksi internet anda',
                style: boldTextStyle, textAlign: TextAlign.center,
              ),
            ),
          );
        }
        if (controller.isLoading.value) {
          return BottomMenuDetailSkeleton();
        }
        final cartItem = cartController.cartItems.firstWhereOrNull((item) => item.productId == menu.menuId);
        final menuQuantity = cartItem?.quantity.value ?? 0;
        return Container(
          width: screenWidth,
          height: 100,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Harga', style: onboardingskip),
                  Text(currencyFormat.format(menu.price), style: appBarTextStyle),
                ],
              ),
              Spacer(),
              Visibility(
                visible: menuQuantity > 0,
                child: InkWell(
                  onTap: () {
                    if (isGuest) {
                      popUpController.showCustomModalForGuest(context);
                    } else {
                      popUpController.showCustomModalForItem(menu, context, cartItem!);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text('${menuQuantity.toString()} Item', style: bold12),
                  ),
                ),
              ),
              Visibility(
                visible: menuQuantity == 0,
                child: InkWell(
                  onTap: () {
                    if (isGuest) {
                      popUpController.showCustomModalForGuest(context);
                    } else {
                      final newCartItem = CartItem(
                        productId: menu.menuId,
                        productName: menu.nameMenu,
                        price: menu.price.toInt(),
                        quantity: 1.obs,
                        productImage: menu.image,
                      );
                      popUpController.addToCart(newCartItem);
                      popUpController.showCustomModalForItem(menu, context, newCartItem);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Text("Tambah", style: whiteregulerTextStyle15),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
