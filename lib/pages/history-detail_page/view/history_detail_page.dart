
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_user_ui/utils/themes/image_themes.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import 'package:warmindo_user_ui/widget/myCustomPopUp/myPopup_controller.dart';

import '../../../common/model/history2_model.dart';
import '../../../common/model/varians.dart';
import '../../../utils/themes/buttonstyle_themes.dart';
import '../../../utils/themes/color_themes.dart';
import '../../../widget/appBar.dart';

import '../../history_page/controller/history_controller.dart';

import '../../../common/model/menu_model.dart';

class HistoryDetailPage extends StatelessWidget {
  final HistoryController controller = Get.put(HistoryController());
  final MyCustomPopUpController popUpController = Get.put(MyCustomPopUpController());
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
 HistoryDetailPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    int totalPrice = int.parse(order.totalprice);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    int totalQuantity = 0;
    for (MenuList menu in order.orderDetails) {
      totalQuantity += menu.quantity;
    }
    return Scaffold(

      appBar: AppbarCustom(title: 'Detail Riwayat',style: headerRegularStyle,),
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
                            String orderStatus = order.status.value;
                              final labelColor = _getLabelColor(order.status.value);
                              return Center(
                                child: Text(
                                  orderStatus.split(' ').map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase()).join(' '),
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
                            itemCount: order.orderDetails.length,
                            separatorBuilder: (BuildContext context, int index) => SizedBox(height: 20),
                            itemBuilder: (context, index) {
                              int toppingTotalPrice = 0;

                              if (order.orderDetails[index].toppings != null) {
                                for (var topping in order.orderDetails[index].toppings!) {
                                  toppingTotalPrice += topping.priceTopping;
                                }
                              }
                              return Row(
                                children: [
                                  Container(
                                    width: screenWidth / 4,
                                    height: screenHeight * 0.11,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      child: Image.network(order.orderDetails[index].image, fit: BoxFit.cover,),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    width: screenWidth * 0.51,
                                    height:screenHeight * 0.11,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Flexible(child: Text(order.orderDetails[index].nameMenu, style: boldTextStyle,maxLines: 2,overflow: TextOverflow.ellipsis,)),
                                                Text('${order.orderDetails[index].quantity}x',style: boldTextStyle,),
                                              ],
                                            ),
                                            Visibility(
                                              visible: order.orderDetails[index].variantId != null,
                                              child: Builder(
                                                builder: (context) {
                                                  final varian = popUpController.varianList.firstWhereOrNull((element) => element.varianID ==order.orderDetails[index].variantId );
                                                  return Text(varian?.nameVarian ?? "Unknown");
                                                },
                                              ),),
                                            Visibility(
                                              visible: order.orderDetails[index].toppings!.isNotEmpty,
                                              child: SizedBox(
                                                height:24,
                                                child: ListView(
                                                    scrollDirection: Axis.horizontal,
                                                    children:[
                                                      Text(
                                                        order.orderDetails[index].toppings!.map((topping) => topping.nameTopping).join(', '),
                                                        overflow: TextOverflow.ellipsis,
                                                        style: const TextStyle(fontSize: 14),
                                                      ),
                                                    ]
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        Text('${currencyFormat.format(order.orderDetails[index].price + toppingTotalPrice)}',style: boldTextStyle,),
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
                              Text(currencyFormat.format(totalPrice),style: boldTextStyle,),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Metode Pemesanan",style: boldTextStyle,),
                              Text(order.orderMethod.toString() ?? '-',style: boldTextStyle,),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Metode Pembayaran",style: boldTextStyle,),
                              Text(order.paymentMethod.toString() ?? '-',style: boldTextStyle,),
                            ],
                          ),
                          SizedBox(height: 20,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Catatan : ',style: boldTextStyle,),
                              Expanded(child: Text('${order.catatan}',maxLines: 5,overflow: TextOverflow.ellipsis,))
                            ],
                          ),
                          SizedBox(height: 20,),
                          Obx(() =>  Visibility(
                            visible: order.alasan_batal != '',
                            child:Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Alasan Batal : ',style: boldTextStyle,),
                                Expanded(child: Text('${order.alasan_batal}',maxLines: 5,overflow: TextOverflow.ellipsis,))
                              ],
                            ),
                          )),
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

