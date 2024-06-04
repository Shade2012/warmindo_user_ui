
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_user_ui/common/model/menu_list_API_model.dart';
import 'package:warmindo_user_ui/utils/themes/image_themes.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';

import '../../../utils/themes/buttonstyle_themes.dart';
import '../../../utils/themes/color_themes.dart';
import '../../../widget/appBar.dart';

import '../../history_page/controller/history_controller.dart';
import '../../../common/model/history.dart';
import '../../../common/model/menu_model.dart';

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
 HistoryDetailPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    int totalQuantity = 0;
    for (MenuList menu in order.menus) {
      totalQuantity += menu.quantity;
    }
    return Scaffold(

      appBar: AppbarCustom(title: 'History Details',style: headerRegularStyle,),
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
                          Obx(() {
                              final labelColor = _getLabelColor(order.status.value);
                              return Center(
                                child: Text(
                                  order.status.value,
                                  style: TextStyle(
                                    fontFamily: GoogleFonts.oxygen().fontFamily,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: labelColor,
                                  ),
                                ),
                              );
                            },
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
                          Obx(() {
                            return Visibility(
                              visible: order.status.value.toLowerCase() == 'selesai' && order.isRatingDone.value == false,
                              child: Center(
                                child: Column(
                                  children: [
                                    Text("Rating", style: boldTextStyle,),
                                    SizedBox(height: 10,),
                                    GestureDetector(
                                      onTap: () {
                                        controller.showCustomModalForRating(order, context);

                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.star_border_rounded, size: 50,),
                                          Icon(Icons.star_border_rounded, size: 50),
                                          Icon(Icons.star_border_rounded, size: 50),
                                          Icon(Icons.star_border_rounded, size: 50),
                                          Icon(Icons.star_border_rounded, size: 50)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                          SizedBox(height: 20,),
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
                                      child: Image.network(order.menus[index].image, fit: BoxFit.cover,),
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
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Flexible(child: Text(order.menus[index].nameMenu, style: boldTextStyle,maxLines: 2,overflow: TextOverflow.ellipsis,)),
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
                          Obx(() =>   Visibility(
                            visible: order.alasan_batal != '',
                            child: Column(
                              children: [
                                SizedBox(height: 20,),
                                Container(
                                  height: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      border: Border.all(color: Colors.black)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(width: 10,),
                                        Text('Alasan Batal : '),
                                        Expanded(child: Text('${order.alasan_batal}',maxLines: 5,overflow: TextOverflow.ellipsis,))
                                      ],
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          )),
                          SizedBox(height: 20,),
                          Container(
                            height: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                border: Border.all(color: Colors.black)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: 10,),
                                  Text('Catatan : '),
                                  Expanded(child: Text('${order.catatan}',maxLines: 5,overflow: TextOverflow.ellipsis,))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Obx(()=> Container(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: (){
                          controller.onButtonPressed(order,context);
                        },
                        child: Text(controller.getButtonText(order),style: whiteboldTextStyle15,),style: dynamicButtonStyle(order.status.value),),
                  ),
                )
              ],
            ),
        ),
      ),
    );
  }
}

