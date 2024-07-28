import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/history_page/widget/history_category.dart';
import 'package:warmindo_user_ui/pages/history_page/widget/order_box.dart';
import 'package:warmindo_user_ui/widget/shimmer/shimmer.dart';
import '../../../utils/themes/textstyle_themes.dart';
import '../../../widget/appBar.dart';
import '../controller/history_controller.dart';
import '../../../common/model/history.dart';

class HistoryPage extends StatelessWidget {
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
      appBar: AppBar(title: Text('Pesanan dan Riwayat',style: headerRegularStyle,),centerTitle: true,automaticallyImplyLeading: false,),
      body: Container(
        padding: EdgeInsets.all(10),
        child:
        Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView(
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
                            status: 'Batal',
                            orders: controller.filteredHistory(),
                          ),
                        ],
                    ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
