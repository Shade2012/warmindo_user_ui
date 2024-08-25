

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_user_ui/common/model/menu_list_API_model.dart';
import 'package:warmindo_user_ui/pages/home_page/shimmer/home_detail_shimmer.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import 'package:warmindo_user_ui/widget/appBar.dart';
import 'package:warmindo_user_ui/widget/reusable_card.dart';
import '../controller/guest_home_detail_controller.dart';




class GuestFilteredMenuPage extends StatelessWidget {
  final GuestHomeDetailController controller = Get.put(GuestHomeDetailController());
  final List<MenuList> filteredMenu;
  int price;

  GuestFilteredMenuPage({super.key, required this.filteredMenu,required this.price});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return Scaffold(
      appBar: AppbarCustom(title:'Menu Seharga ${currencyFormat.format(price)}', style: headerRegularStyle,),
      body: SafeArea(
        child: Obx((){
          if (!controller.isConnected.value) {
            return Center(
              child: Text(
                'Tidak ada koneksi internet mohon check koneksi internet anda',
                style: boldTextStyle,textAlign: TextAlign.center,
              ),
            );
          }
          if (controller.isLoading.value) {
            return HomeDetailSkeleton();
          }
          return RefreshIndicator(
              onRefresh: () async {
                controller.fetchProduct();
              },
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 240
                ),
                itemCount: filteredMenu.length,
                itemBuilder: (context, index) {
                  final menu = filteredMenu[index];
                  return ReusableCard(context: context, product: menu, width: MediaQuery.of(context).size.width * 0.8, isGuest: true,);
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}
