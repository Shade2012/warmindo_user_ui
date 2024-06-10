import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:warmindo_user_ui/common/model/history.dart';
import 'package:warmindo_user_ui/pages/history_page/controller/history_controller.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';

import '../../history-detail_page/widget/HistoryDetailFilterPage.dart';

class HistoryCategory extends StatelessWidget {
  final List<Order> orders;
  HistoryCategory({
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
    int totalOrders = orders.where((o) => o.status.value.toLowerCase() == status.toLowerCase()).length;

    return GestureDetector(
      onTap: (){
        Get.to(() => HistoryDetailFilterPage(status: status, orders: controller.getOrdersByStatus(status)));
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
              offset: Offset(0, 1),
            ),
          ],
          color: ColorResources.backgroundCardColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: screenWidth / 4.3,
              height: screenHeight * 0.11,
              child: ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                child: Image.asset(controller.imageChange(status)),
              ),
            ),
            SizedBox(width: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(status, style: GoogleFonts.oxygen(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: labelColor
                ),),
                Text('Total Order Status $totalOrders : ', style: boldTextStyle),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
