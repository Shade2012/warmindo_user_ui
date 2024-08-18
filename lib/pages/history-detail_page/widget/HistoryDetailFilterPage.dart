import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:warmindo_user_ui/pages/history_page/widget/order_box.dart';
import '../../../utils/themes/textstyle_themes.dart';
import '../../../widget/appBar.dart';
import '../../../widget/shimmer/shimmer.dart';
import '../../history_page/controller/history_controller.dart';

class HistoryDetailFilterPage extends StatelessWidget {
  final HistoryController controller = Get.find(); // Use Get.find() to access the existing instance
  final List<String> titles = <String>[
    'Terbaru',
    'Terlama',
  ];
  final String status;

  HistoryDetailFilterPage({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCustom(title: 'Riwayat Pesanan $status', style: headerRegularStyle),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: CustomDropdown(
                decoration: CustomDropdownDecoration(
                  listItemStyle: boldTextStyle,
                  listItemDecoration: ListItemDecoration(
                    selectedColor: Colors.black,
                  ),
                ),
                initialItem: controller.selectedTimes.value,
                items: titles,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    controller.changeTime(newValue);
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Obx(
                    () => Text(
                  controller.selectedTimes.value,
                  style: headerBold,
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                final filteredOrders = controller.orders2
                    .where((order) => order.status.value.toLowerCase() == status.toLowerCase())
                    .toList();
                if(filteredOrders.length == 0){
                  return Center(child: Text('Belum ada data'),);
                }else{
                  return ListView.builder(
                    itemCount: filteredOrders.length,
                    itemBuilder: (context, index) {
                      return OrderBox(order: filteredOrders[index]);
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

}

