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
import '../../pages/home_page/controller/schedule_controller.dart';
import '../../pages/menu_page/controller/menu_controller.dart';
import '../../pages/verification_profile_page/controller/verification_profile_controller.dart';
import '../../pages/verification_profile_page/view/verification_profile_Page.dart';
import '../../routes/AppPages.dart';
import '../../utils/themes/color_themes.dart';
import '../../utils/themes/image_themes.dart';
import '../dashed_divider.dart';
import '../myCustomPopUp/myPopup_controller.dart';
import '../reusable_dialog.dart';

class MenuCategory extends StatelessWidget {
  final scheduleController = Get.find<ScheduleController>();
  final MenuPageController menuController = Get.put(MenuPageController());
  final CartController cartController = Get.put(CartController());
  final MyCustomPopUpController popUpcontroller = Get.put(MyCustomPopUpController());
  // final VerificationProfileController controller = Get.find<VerificationProfileController>();

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

              final cartItem = cartController.cartItems2.firstWhereOrNull((item) => item.productId == menu.menuId);
              RxInt totalQuantity = cartController.getTotalQuantityForMenuID(menu.menuId);
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
                  foregroundDecoration: (menu.stock! > 1 && scheduleController.jadwalElement[0].is_open)
                      ? null
                      : BoxDecoration(
                    color: Colors.grey,
                    backgroundBlendMode: BlendMode.saturation,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            visible: totalQuantity.value > 0,
                                            child: InkWell(
                                              onTap: () {
                                                if(scheduleController.jadwalElement[0].is_open == false){
                                                  Get.snackbar('Pesan', 'Maaf Toko saat ini sedang tutup silahkan coba lagi nanti ',colorText: Colors.black);
                                                }else{
                                                  if (isGuest) {
                                                    popUpcontroller.showCustomModalForGuest(context);
                                                  } else {
                                                    if(menu.stock! < 1){
                                                      Get.snackbar('Pesan', 'Stock Habis',colorText: Colors.black);
                                                    }
                                                    else{
                                                      popUpcontroller.showDetailPopupModal(context, menu);
                                                    }
                                                  }
                                                }
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5, vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(color: Colors.black),
                                                  borderRadius:
                                                  BorderRadius.circular(5),
                                                ),
                                                child: Text(
                                                  '${totalQuantity.value.toString()} Item',overflow: TextOverflow.ellipsis,
                                                  style: bold12,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: totalQuantity.value == 0,
                                            child: InkWell(
                                              onTap: () async {
                                                if(scheduleController.jadwalElement[0].is_open == false){
                                                  Get.snackbar('Pesan', 'Maaf Toko saat ini sedang tutup silahkan coba lagi nanti ',colorText: Colors.black);
                                                }else{
                                                  if (isGuest) {
                                                    popUpcontroller.showCustomModalForGuest(context);
                                                  } else {
                                                    if (cartController.userPhone.value == '') {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) {
                                                            return ReusableDialog(
                                                                title: 'Pesan',
                                                                content: 'Nomor Hp anda belum terdaftar tolong isi terlebih dahulu',
                                                                cancelText: 'Nanti',
                                                                confirmText: 'Oke',
                                                                onCancelPressed: () {
                                                                  Get.back();
                                                                },
                                                                onConfirmPressed: () {
                                                                  Get.toNamed(Routes.EDITPROFILE_PAGE);
                                                                });
                                                          });
                                                    }
                                                    else{
                                                      if (cartController.userPhoneVerified.value == '') {
                                                        showDialog(context: context, builder: (BuildContext context) {
                                                          return ReusableDialog(
                                                              title: 'Pesan',
                                                              content:
                                                              'Nomor Hp anda belum terverifikasi tolong verifikasi terlebih dahulu',
                                                              cancelText: 'Nanti',
                                                              confirmText: 'Oke',
                                                              onCancelPressed: () {
                                                                Get.back();
                                                              },
                                                              onConfirmPressed: () {
                                                                cartController.goToVerification();
                                                              });
                                                        });
                                                      }
                                                      else{
                                                        if(menu.stock! < 1 ){
                                                          Get.snackbar('Pesan', 'Stock Habis',colorText: Colors.black);
                                                        }
                                                        else{
                                                          bool variantRequired = popUpcontroller.varianList.any((varian) => varian.category == menu.nameMenu);
                                                          if(variantRequired){
                                                            popUpcontroller.isLoading.value = true;
                                                          Future.delayed(const Duration(seconds: 2), () {
                                                            popUpcontroller.isLoading.value = false;
                                                          });
                                                            popUpcontroller.showCustomModalForItem(menu, context, 1, cartid: 1);
                                                          }
                                                          else {
                                                            print(cartItem?.cartId);
                                                            print(cartController.cartItems2);
                                                            popUpcontroller.addToCart2(product: menu, quantity: 1, cartID: cartItem?.cartId?.value ?? 0, context: context,);
                                                            final cartItem2 = cartController.cartItems2.firstWhereOrNull((item) => item.productId == menu.menuId);
                                                            popUpcontroller.showCustomModalForItem(menu, context, 1, cartid: cartItem2?.cartId?.value ?? 0);
                                                          }
                                                        }
                                                      }
                                                    }
                                                  }
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
