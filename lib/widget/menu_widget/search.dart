import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_user_ui/pages/detail-menu_page/view/detail_menu_page.dart';
import 'package:warmindo_user_ui/common/model/menu_list_API_model.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import 'package:warmindo_user_ui/widget/shimmer/shimmer.dart';
import '../../pages/cart_page/controller/cart_controller.dart';
import '../../pages/guest_menu_page/controller/guest_menu_controller.dart';
import '../../pages/home_page/controller/schedule_controller.dart';
import '../../pages/menu_page/controller/menu_controller.dart';
import '../../routes/AppPages.dart';
import '../../utils/themes/color_themes.dart';
import '../../utils/themes/image_themes.dart';
import '../myCustomPopUp/myPopup_controller.dart';
import '../reusable_dialog.dart';



class Search extends StatelessWidget {
  final scheduleController = Get.find<ScheduleController>();
  final CartController cartController = Get.put(CartController());
  final MenuPageController menuController = Get.put(MenuPageController());
  final popUpcontroller = Get.put(MyCustomPopUpController());
  final GuestMenuController guestMenuController = Get.find<GuestMenuController>();
  final String categoryName;
  final bool isGuest;
  final List<MenuList> menuList;
  final BuildContext context;
  Search({
    super.key,
    required this.categoryName,
    required this.menuList,
    required this.context, required this.isGuest
  });

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
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                categoryName ?? '',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            Obx((){

              return menuController.isLoading.value ?
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.60),
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                      child: const Skeleton(width: 60, radius: 20,)),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                      child: const Skeleton(width: 60,radius: 20,)),
                  Container(margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),child: const Skeleton(width: 60,radius: 20,)),
                  Container(margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),child: const Skeleton(width: 60,radius: 20,)),
                  Container(margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),child: const Skeleton(width: 60,radius: 20,)),
                  Container(margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),child: const Skeleton(width: 60,radius: 20,))
                ],

              ) :        GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 260,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: menuList.length,
                itemBuilder: (context, index) {
                  final menu = menuList[index];
                  final cartItem = cartController.cartItems2
                      .firstWhereOrNull((item) => item.productId == menu.menuId);
                  RxInt totalQuantity = cartController.getTotalQuantityForMenuID(menu.menuId);
                  return GestureDetector(
                    onTap: () {
                      Get.to(DetailMenuPage(menu: menu, isGuest: isGuest,));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      width: screenWidth * 0.43,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        color: ColorResources.backgroundCardColor,
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Column(
                        children: [
                          Stack(
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
                                height: 104,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  child: FadeInImage(
                                    image: NetworkImage(menu.image),
                                    fit: BoxFit.cover,
                                    placeholder: const AssetImage(Images.placeholder),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ListTile(
                            title: Text(menu.nameMenu, style: regularInputTextStyle,maxLines: 1,overflow: TextOverflow.ellipsis,),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(height: 3),
                                Text(
                                  menu.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: descriptionTextStyle,
                                ),
                                SizedBox(height: screenHeight * 0.03),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        currencyFormat.format(menu.price),
                                        style: menuPriceTextStyle,
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
                                                popUpcontroller.showCustomModalForGuest(context);
                                              } else {
                                                if(menu.statusMenu == '1'){
                                                  if(menu.stock! < 1){
                                                    Get.snackbar('Pesan', 'Stock Habis',colorText: Colors.black);
                                                  }
                                                  else{
                                                    popUpcontroller.showDetailPopupModal(context, menu);
                                                  }
                                                }else{
                                                  Get.snackbar('Pesan', 'Menu ini sedang dinonaktifkan.');
                                                }

                                              }
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(color: Colors.black),
                                              borderRadius:
                                              BorderRadius.circular(5),
                                            ),
                                            child: Obx(() =>
                                               Text(
                                                '${totalQuantity.value.toString()} Item',overflow: TextOverflow.ellipsis,
                                                style: bold12,
                                              ),
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
                                                    if(menu.statusMenu == '1'){
                                                      if(menu.stock! < 1){
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
                                                        } else {
                                                          popUpcontroller.addToCart2(product: menu, quantity: 1, cartID: cartItem?.cartId?.value ?? 0, context: context,);
                                                          final cartItem2 = cartController.cartItems2.firstWhereOrNull((item) => item.productId == menu.menuId);
                                                          popUpcontroller.showCustomModalForItem(menu, context, 1, cartid: cartItem2?.cartId?.value ?? 0);
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
                                            padding: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                              BorderRadius.circular(5),
                                            ),
                                            child: const Icon(
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
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
