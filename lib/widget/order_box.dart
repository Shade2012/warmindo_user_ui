import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:warmindo_user_ui/pages/history-detail_page/view/history_detail_page.dart';
import 'package:warmindo_user_ui/pages/history_page/controller/history_controller.dart';
import 'package:warmindo_user_ui/common/model/history.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import 'package:warmindo_user_ui/widget/shimmer/shimmer.dart';

import '../utils/themes/image_themes.dart';
import '../common/model/history.dart';

class OrderBox extends StatelessWidget {
  final HistoryController controller = Get.put(HistoryController());

   OrderBox({
    Key? key,
    required this.order,
  }) : super(key: key);

  final Order order;

  Color _getLabelColor(String status) {

    switch (status.toLowerCase()) {
      case 'selesai':
        return ColorResources.labelcomplete;
      case 'in progress':
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

    final HistoryController controller = Get.find(); // Get the instance of HistoryController
    final labelColor = _getLabelColor(order.status.value);

    return Obx(() {
      if(controller.isLoading.value){
       return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
          child:  GestureDetector(
            onTap: () {
              Get.to(HistoryDetailPage(order: order)); // Pass currentOrder
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
                    offset: Offset(1, 1),
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
                        final orderStatus = order.status.value;
                        return Text(
                          orderStatus,
                          style: TextStyle(
                            fontFamily: GoogleFonts.oxygen().fontFamily,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: _getLabelColor(orderStatus), // Use the observed status
                          ),
                        );
                      }),
                      Text(
                        controller.calculateTotalPrice(order).toString(),
                        style: boldTextStyle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: order.menus.length,
                    separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 4,
                            height: MediaQuery.of(context).size.height * 0.11,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                order.menus[index].imagePath,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.11,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(order.menus[index].name, style: boldTextStyle),
                                Text('(${order.menus[index].quantity} Items)'),
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
          ),
        );
      }else{
       return GestureDetector(
          onTap: () {
            Get.to(HistoryDetailPage(order: order)); // Pass currentOrder
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
                  offset: Offset(1, 1),
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
                      final orderStatus = order.status.value;
                      return Text(
                        orderStatus,
                        style: TextStyle(
                          fontFamily: GoogleFonts.oxygen().fontFamily,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: _getLabelColor(orderStatus), // Use the observed status
                        ),
                      );
                    }),
                    Text(
                      controller.calculateTotalPrice(order).toString(),
                      style: boldTextStyle,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: order.menus.length,
                  separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 4,
                          height: MediaQuery.of(context).size.height * 0.11,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              order.menus[index].imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.11,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(order.menus[index].name, style: boldTextStyle),
                              Text('(${order.menus[index].quantity} Items)'),
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
