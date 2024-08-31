import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/history_page/widget/order_box.dart';
import '../../../utils/themes/textstyle_themes.dart';
import '../../../widget/appBar.dart';
import '../../history_page/controller/history_controller.dart';

class HistoryDetailFilterPage extends StatelessWidget {
  final HistoryController controller = Get.find(); // Use Get.find() to access the existing instance

  final String status;

  HistoryDetailFilterPage({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppbarCustom(title: 'Pesanan $status', style: headerRegularStyle),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchHistory();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  final filteredOrders = controller.orders2
                      .where((order) => order.status.value.toLowerCase() == status.toLowerCase())
                      .toList()
                      .reversed
                      .toList();
                  if (filteredOrders.isEmpty) {
                    return Column(
                      children: [
                        SizedBox(height: screenHeight * 0.4,),
                        Center(child: Text('Belum ada pesanan',style: regularTextStyle,)),
                      ],
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true, // Add this line to ensure the ListView takes the minimum size it needs
                      physics: const NeverScrollableScrollPhysics(), // Prevents the ListView from scrolling separately
                      itemCount: filteredOrders.length,
                      itemBuilder: (context, index) {
                        return OrderBox(order: filteredOrders[index], isBatal: false);
                      },
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
