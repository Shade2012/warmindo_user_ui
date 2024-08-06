import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_user_ui/common/model/menu_list_API_model.dart';
import 'package:warmindo_user_ui/common/model/menu_model.dart';
import 'package:warmindo_user_ui/pages/detail-menu_page/shimmer/bottom_detail_menu_shimmer.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';

import '../../../common/model/cartmodel.dart';
import '../../../routes/AppPages.dart';
import '../../../utils/themes/image_themes.dart';
import '../../../widget/appBar.dart';
import '../../../widget/myCustomPopUp/myPopup_controller.dart';
import '../../../widget/reusable_dialog.dart';
import '../../cart_page/controller/cart_controller.dart';
import '../../home_page/controller/schedule_controller.dart';
import '../controller/detail_menu_controller.dart';
import '../shimmer/detail_menu_shimmer.dart';

class DetailMenuPage extends StatelessWidget {
  final scheduleController = Get.find<ScheduleController>();
  final CartController cartController = Get.find();
  final DetailMenuController controller = Get.put(DetailMenuController());
  final MenuList menu;
  final bool isGuest;

  DetailMenuPage({Key? key, required this.menu, required this.isGuest})
      : super(key: key) {
  }

  @override
  Widget build(BuildContext context) {
    final popUpController = Get.put(MyCustomPopUpController());
    final currencyFormat =
    NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
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
                    style: boldTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            if (controller.isLoading.value) {
              return MenuDetailSkeleton();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        foregroundDecoration: scheduleController.jadwalElement[0].is_open
                            ? null
                            : BoxDecoration(
                          color: Colors.grey,
                          backgroundBlendMode: BlendMode.saturation,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        width: double.infinity,
                        height: screenHeight * 0.3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Image.network(
                            menu.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(menu.nameMenu, style: boldTextStyle2),
                      Text(menu.category, style: regulargreyText),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Icon(Icons.star_rounded,
                                  color:
                                  scheduleController.jadwalElement[0].is_open
                                      ? Colors.orange
                                      : Colors.grey, size: 23),
                              Text(menu.ratings.toString(),
                                  style: descriptionratingTextStyle),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      Text('Deskripsi', style: boldTextStyle),
                      Text(menu.description, style: onboardingskip),
                      Visibility(
                          visible: controller.varianList.any((varian) => varian.category == menu.nameMenu),
                          child:
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(),
                              Text('Varian', style: boldTextStyle),
                              SizedBox(height: 10,),
                              Obx((){
                                final varianList = controller.varianList.value.where((element) => element.category == menu.nameMenu).toList();
                                return Wrap(
                                    spacing: 10.0,
                                    runSpacing: 10.0,
                                    children: List.generate(varianList.length, (index) {
                                      final varian = varianList[index];
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        child: Text(varian.nameVarian, style: TextStyle(color: Colors.black)),
                                      );
                                    })
                                );
                              }),
                            ],
                          )),
                      Visibility(
                          visible: menu.category == 'Makanan',
                          child:
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(),
                              Text('Topping', style: boldTextStyle),
                              SizedBox(height: 10,),
                              Obx(()=>
                                  Wrap(
                                    spacing: 10.0,
                                    runSpacing: 10.0,
                                    children: List.generate(controller.toppingList.length, (index) {
                                      final topping = controller.toppingList[index];
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        child: Text(topping.nameTopping, style: TextStyle(color: Colors.black)),
                                      );
                                    })
                                  ),
                              ),
                            ],
                          )),

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
                style: boldTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        if (controller.isLoading.value) {
          return BottomMenuDetailSkeleton();
        }
        final cartItem = cartController.cartItems2
            .firstWhereOrNull((item) => item.productId == menu.menuId);
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
                  Text(currencyFormat.format(menu.price),
                      style: appBarTextStyle),
                ],
              ),
              Spacer(),
              Visibility(
                visible: menuQuantity > 0,
                child: InkWell(
                  onTap: () {
                    if(scheduleController.jadwalElement[0].is_open == false){
                      Get.snackbar('Pesan', 'Maaf Toko saat ini sedang tutup silahkan coba lagi nanti ',colorText: Colors.black);
                    }else{
                      if (isGuest) {
                        popUpController.showCustomModalForGuest(context);
                      } else {
                        popUpController.showCustomModalForItem(
                            menu, context, menuQuantity,
                            cartid: cartItem!.cartId ?? 0);
                      }
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child:
                    Text('${menuQuantity.toString()} Item', style: bold12),
                  ),
                ),
              ),
              Visibility(
                visible: menuQuantity == 0,
                child: InkWell(
                  onTap: () async {
                    if(scheduleController.jadwalElement[0].is_open == false){
                      Get.snackbar('Pesan', 'Maaf Toko saat ini sedang tutup silahkan coba lagi nanti ',colorText: Colors.black);
                    }else{
                      if (isGuest) {
                        popUpController.showCustomModalForGuest(context);
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
                          }else{
                            bool variantRequired = popUpController.varianList.any((varian) => varian.category == menu.nameMenu);
                            if(variantRequired){
        popUpController.showCustomModalForItem(menu, context, 1, cartid: 0);
        } else {
        final newCartItem = await cartController.addToCart2(productId: menu.menuId, productName: menu.nameMenu, productImage: menu.image, price: menu.price, quantity: 1,);
        popUpController.showCustomModalForItem(menu, context, 1, cartid: newCartItem?.cartId ?? 0);
        }
        }
                          }
                        }
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
