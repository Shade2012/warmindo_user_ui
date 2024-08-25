import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:warmindo_user_ui/common/model/history2_model.dart';
import 'package:warmindo_user_ui/pages/history_page/controller/history_controller.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';

import '../../history-detail_page/widget/HistoryDetailFilterPage.dart';

class HistoryCategory extends StatelessWidget {
  final List<Order2> orders;
  const HistoryCategory({
    Key? key,
    required this.status,
    required this.orders,
  }) : super(key: key);


  final String status;

  Color _getLabelColor(String status) {
    switch (status.toLowerCase()) {
      case 'selesai':
        return ColorResources.labelcomplete;
      case 'sedang diproses':
        return ColorResources.labelinprogg;
      case 'menunggu pembayaran':
        return Colors.grey;
      case 'menunggu batal':
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final HistoryController controller = Get.find();
    final labelColor = _getLabelColor(status);


    return Obx(() {
      // Calculate totalOrders based on the observable list
      final totalOrders = controller.orders2
          .where((o) => o.status.value.toLowerCase() == status.toLowerCase())
          .length;

      return GestureDetector(
        onTap: () {
          Get.to(() => HistoryDetailFilterPage(
            status: status,
          ));
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
            color: ColorResources.backgroundCardColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: screenWidth / 4.3,
                height: screenHeight * 0.11,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                  child: Image.asset(controller.imageChange(status)),
                ),
              ),
              const SizedBox(width: 10,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(status, style: GoogleFonts.oxygen(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: labelColor
                  ),),
                  Text('Total Order Status : $totalOrders', style: boldTextStyle),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
