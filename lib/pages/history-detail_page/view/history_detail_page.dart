import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_user_ui/utils/themes/image_themes.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';

import '../../../utils/themes/buttonstyle_themes.dart';
import '../../../utils/themes/color_themes.dart';
import '../../../widget/appBar.dart';
import '../../history_page/controller/history_controller.dart';
import '../../history_page/model/history.dart';

class HistoryDetailPage extends StatelessWidget {
  final HistoryController controller = Get.put(HistoryController());
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
 HistoryDetailPage({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final labelColor = _getLabelColor(order.status.value);
    int totalQuantity = 0;
    for (Menu menu in order.menus) {
      totalQuantity += menu.quantity;
    }
    return Scaffold(

      appBar: AppbarCustom(title: 'History Details'),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(Images.history),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            offset: Offset(1,1),
                            blurRadius: 7.0,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(order.status.value, style: TextStyle(
                                fontFamily: GoogleFonts.oxygen().fontFamily,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: labelColor
                            ),),
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Rincian Pemesanan",style: boldTextStyle,),
                              Text('#${order.id}')
                            ],
                          ),
                          SizedBox(height: 10,),
                          Text('${totalQuantity} Items',style: boldTextStyle,),
                          SizedBox(height: 10,),
                          ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: order.menus.length,
                            separatorBuilder: (BuildContext context, int index) => SizedBox(height: 20),
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Container(
                                    width: screenWidth / 4,
                                    height: screenHeight * 0.11,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      child: Image.asset(order.menus[index].imagePath, fit: BoxFit.cover,),
                                    ),
                                  ),
                                  SizedBox(width: 10), // Add space between image and text
                                  Container(
                                    width: screenWidth * 0.51,
                                    height:screenHeight * 0.11,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(order.menus[index].name, style: boldTextStyle,),
                                            Text('${order.menus[index].quantity}x',style: boldTextStyle,),
                                          ],
                                        ),
                                        Text('${currencyFormat.format(order.menus[index].price)}',style: boldTextStyle,),
                                        // Text(currencyFormat.format(totalPrice),style: boldTextStyle,)
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          SizedBox(height: 10,),
                          Text("Detail Pembayaran",style: boldTextStyle,),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Potongan Harga",style: boldTextStyle,),
                              Text(controller.getVoucherText(order),style: boldTextStyle,),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total",style: boldTextStyle,),
                              Text(controller.calculateTotalPrice(order).toString(),style: boldTextStyle,),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Metode Pemesanan",style: boldTextStyle,),
                              Text(order.orderMethod.toString(),style: boldTextStyle,),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Metode Pembayaran",style: boldTextStyle,),
                              Text(order.paymentMethod.toString(),style: boldTextStyle,),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: (){
                        controller.onButtonPressed(order);
                      },
                      child: Text(controller.getButtonText(order),style: whiteboldTextStyle15,),style: dynamicButtonStyle(order.status.value),),
                )
              ],
            ),
        ),
      ),
    );
  }
}
