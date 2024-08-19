import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/history_page/shimmer/history_shimmer.dart';
import 'package:warmindo_user_ui/pages/history_page/widget/history_category.dart';
import '../../../utils/themes/textstyle_themes.dart';

import '../../../widget/myCustomPopUp/myPopup_controller.dart';
import '../controller/history_controller.dart';


class HistoryPage extends StatelessWidget {
  final MyCustomPopUpController popUpController = Get.put(MyCustomPopUpController());
  final HistoryController controller = Get.put(HistoryController());
  Color selectedTextColor = Colors.white;
  Color dropdownTextColor = Colors.black;
  List<String> titles = <String>[
    'Semua',
    'Selesai',
    'Pesanan Siap',
    'Sedang Diproses',
    'Menunggu Batal',
    'Batal',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesanan dan Riwayat', style: headerRegularStyle,),
        centerTitle: true,
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await popUpController.fetchVarian();
          await popUpController.fetchTopping();
          await controller.fetchHistory();
          // controller.isLoading.value = true;
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Obx(() {
              if (controller.isLoading.value == true) {
                return HistoryShimmer();
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        HistoryCategory(
                          status: 'Pesanan Siap',
                          orders: controller.filteredHistory(),
                        ),
                        HistoryCategory(
                          status: 'Selesai',
                          orders: controller.filteredHistory(),
                        ),
                        HistoryCategory(
                          status: 'Sedang Diproses',
                          orders: controller.filteredHistory(),
                        ),
                        HistoryCategory(
                          status: 'Menunggu Batal',
                          orders: controller.filteredHistory(),
                        ),
                        HistoryCategory(
                          status: 'Menunggu Pembayaran',
                          orders: controller.filteredHistory(),
                        ),
                        HistoryCategory(
                          status: 'Batal',
                          orders: controller.filteredHistory(),
                        ),
                      ],
                    ),
                  ],
                );
              }
            }),
          ),
        ),
      ),
    );
  }

}
