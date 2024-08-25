import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_user_ui/common/model/history2_model.dart';
import 'package:warmindo_user_ui/pages/history-detail_page/view/history_detail_page.dart';
import 'package:warmindo_user_ui/pages/history_page/controller/history_controller.dart';
import 'package:warmindo_user_ui/pages/history_page/shimmer/history_shimmer.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';



class OrderBox extends StatelessWidget {
  final HistoryController controller = Get.put(HistoryController());

   OrderBox({
    super.key,
     required this.isBatal,
    required this.order,
  });
  bool isBatal;
  final Order2 order;

  Color _getLabelColor(String status) {

    switch (status.toLowerCase()) {
      case 'selesai':
        return ColorResources.labelcomplete;
      case 'sedang diproses':
        return ColorResources.labelinprogg;
      case 'menunggu batal':
        return ColorResources.labelcancel;
      case 'batal':
        return ColorResources.labelcancel;
      case 'pesanan siap':
        return ColorResources.labelcomplete;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    int totalPrice = int.parse(order.totalprice);
    final HistoryController controller = Get.find(); // Get the instance of HistoryController


    return Obx(() {
      if(controller.isLoading.value){
       return const HistoryShimmer();
      }else{
       return GestureDetector(
          onTap: () {
            if(isBatal == true){
              return;
            }else{
              Get.to(HistoryDetailPage(initialOrder: order,)); // Pass currentOrder
            }
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  offset: const Offset(1, 1),
                  blurRadius: 7.0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      final orderStatus = order.status.value.trim();
                      return Text(
                          orderStatus.split(' ').map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase()).join(' '),
                        style: TextStyle(
                          fontFamily: GoogleFonts.oxygen().fontFamily,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: _getLabelColor(orderStatus), // Use the observed status
                        ),
                      );
                    }),
                    Text(
                      currencyFormat.format(totalPrice),
                      style: boldTextStyle,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: order.orderDetails.length,
                  separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 4,
                          height: MediaQuery.of(context).size.height * 0.11,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              order.orderDetails[index].image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.11,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(order.orderDetails[index].nameMenu, style: boldTextStyle),
                              Text('(${order.orderDetails[index].quantity} Items)'),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }
    }
    );

  }
}
