
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_user_ui/common/model/menu_list_API_model.dart';
import 'package:warmindo_user_ui/pages/detail-menu_page/shimmer/bottom_detail_menu_shimmer.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import '../../../routes/AppPages.dart';
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

  DetailMenuPage({super.key, required this.menu, required this.isGuest});

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
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        foregroundDecoration: (menu.stock! > 1 && scheduleController.jadwalElement[0].is_open && menu.statusMenu != '0')
                            ? null
                            : const BoxDecoration(
                          color: Colors.grey,
                          backgroundBlendMode: BlendMode.saturation,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        width: double.infinity,
                        height: screenHeight * 0.3,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          child: Image.network(
                            menu.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(menu.nameMenu, style: boldTextStyle2),
                      Text(menu.category, style: regulargreyText),
                      const SizedBox(height: 10),
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
                              Text(menu.rating.toString(),
                                  style: descriptionratingTextStyle),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(),
                      Text('Deskripsi', style: boldTextStyle),
                      Text(menu.description, style: onboardingskip),
                      Visibility(
                          visible: controller.varianList.any((varian) => varian.category == menu.nameMenu),
                          child:
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Divider(),
                              Text('Varian', style: boldTextStyle),
                              const SizedBox(height: 10,),
                              Obx((){
                                final varianList = controller.varianList.where((element) => element.category == menu.nameMenu).toList();
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
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        child: Text(varian.nameVarian, style: const TextStyle(color: Colors.black)),
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
                              const Divider(),
                              Text('Topping', style: boldTextStyle),
                              const SizedBox(height: 10,),
                              Obx((){
                                final toppings = controller.toppingList.where((topping) => topping.menus.any((menu2) => menu2.menuID == menu.menuId)).toList();
                                return Wrap(
                                  spacing: 10.0,
                                  runSpacing: 10.0,
                                  children: List.generate(toppings.length, (index) {
                                    final topping = toppings[index];
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      child: Text(
                                        topping.nameTopping,
                                        style: const TextStyle(color: Colors.black),
                                      ),
                                    );
                                  }),
                                );
                              }),
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
            child: Text(
              'Tidak ada koneksi internet mohon check koneksi internet anda',
              style: boldTextStyle,
              textAlign: TextAlign.center,
            ),
          );
        }
        if (controller.isLoading.value) {
          return BottomMenuDetailSkeleton();
        }
        final cartItem = cartController.cartItems2
            .firstWhereOrNull((item) => item.productId == menu.menuId);
        RxInt totalQuantity = cartController.getTotalQuantityForMenuID(menu.menuId);
        return Container(
          width: screenWidth,
          height: 100,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 0),
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
              const Spacer(),
              Visibility(
                visible: totalQuantity.value > 0,
                child: InkWell(
                  onTap: () {
                    if(scheduleController.jadwalElement[0].is_open == false){
                      Get.snackbar('Pesan', 'Maaf Toko saat ini sedang tutup silahkan coba lagi nanti ',colorText: Colors.black);
                    }else{
                      if (isGuest) {
                        popUpController.showCustomModalForGuest(context);
                      } else {
                        if(menu.statusMenu == '1'){
                          if(menu.stock! < 1){
                            Get.snackbar('Pesan', 'Stock Habis',colorText: Colors.black);
                          }
                          else{
                            popUpController.showDetailPopupModal(context, menu);
                          }
                        }else{
                          Get.snackbar('Pesan', 'Menu ini sedang dinonaktifkan.');
                        }
                      }
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child:
                    Text('${totalQuantity.value.toString()} Item', style: bold12),
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
                            if(menu.statusMenu == '1'){
                              if(menu.stock! < 1){
                                Get.snackbar('Pesan', 'Stock Habis',colorText: Colors.black);
                              }
                              else{
                                bool variantRequired = popUpController.varianList.any((varian) => varian.category == menu.nameMenu);
                                if(variantRequired){
                                  popUpController.isLoading.value = true;
                                  Future.delayed(const Duration(seconds: 2), () {
                                    popUpController.isLoading.value = false;
                                  });
                                  popUpController.showCustomModalForItem(menu, context, 1, cartid: -1);
                                }else {
                                  popUpController.addToCart2(product: menu, quantity: 1, cartID: cartItem?.cartId?.value ?? 0, context: context,);
                                  final cartItem2 = cartController.cartItems2.firstWhereOrNull((item) => item.productId == menu.menuId);
                                  popUpController.showCustomModalForItem(menu, context, 1, cartid: cartItem2?.cartId?.value ?? 0);
                                }
                              }
                            }else{
                              Get.snackbar('Pesan', 'Menu ini sedang dinonaktifkan.');
                            }
                            }
                          }
                        }
                      }
                    },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    decoration: const BoxDecoration(
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
