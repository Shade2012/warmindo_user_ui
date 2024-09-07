import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../common/model/history2_model.dart';
import '../../../utils/themes/color_themes.dart';
import '../../../utils/themes/textstyle_themes.dart';
import '../../../widget/myCustomPopUp/myPopup_controller.dart';
class OrderPembatalan extends StatelessWidget {
  final MyCustomPopUpController popUpController = Get.put(MyCustomPopUpController());
  final Order2 order;
  OrderPembatalan({Key? key, required this.order}) : super(key: key);
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    int totalQuantity = 0;
    for (MenuList menu in order.orderDetails) {
      totalQuantity += menu.quantity;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                offset: const Offset(1,1),
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
              const SizedBox(height: 10,),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Rincian Pemesanan",style: boldTextStyle,),
                  Text('#${order.id}')
                ],
              ),
              const SizedBox(height: 10,),
              Text('$totalQuantity Items',style: boldTextStyle,),
              const SizedBox(height: 20,),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: order.orderDetails.length,
                separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 20),
                itemBuilder: (context, index) {
                  int toppingTotalPrice = 0;

                  if (order.orderDetails[index].toppings != null) {
                    for (var topping in order.orderDetails[index].toppings!) {
                      toppingTotalPrice += topping.priceTopping;
                    }
                  }
                  return Row(
                    children: [
                      SizedBox(
                        width: screenWidth / 4,
                        height: screenHeight * 0.11,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          child: Image.network(order.orderDetails[index].image, fit: BoxFit.cover,),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
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
                                  children: [
                                    Text(order.orderDetails[index].nameMenu, style: boldTextStyle,maxLines: 2,overflow: TextOverflow.ellipsis,),
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

                            Text(currencyFormat.format(order.orderDetails[index].price + toppingTotalPrice),style: boldTextStyle,),
                            // Text(currencyFormat.format(totalPrice),style: boldTextStyle,)
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total",style: boldTextStyle,),
                  Text(currencyFormat.format(totalPrice),style: boldTextStyle,),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Metode Pemesanan",style: boldTextStyle,),
                  Text(order.orderMethod!.toLowerCase().substring(0,1).toUpperCase() + order.orderMethod!.toLowerCase().substring(1) ?? '-',style: boldTextStyle,),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Metode Pembayaran",style: boldTextStyle,),
                  Text(order.paymentMethod == 'tunai'
                      ? order.paymentMethod!
                      .toLowerCase()
                      .substring(0, 1)
                      .toUpperCase() +
                      order.paymentMethod!
                          .toLowerCase()
                          .substring(1) ?? '-'
                      : order.paymentMethod
                      ?.toUpperCase() ?? '-',
                    style: boldTextStyle,),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Catatan : ',style: boldTextStyle,),
                  Expanded(child: Text(order.catatan,maxLines: 5,overflow: TextOverflow.ellipsis,))
                ],
              ),
              Obx(() =>  Visibility(
                visible: order.alasan_batal != '',
                child:Column(
                  children: [
                    const SizedBox(height: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Alasan Batal : ',style: boldTextStyle,),
                        Expanded(child: Text('${order.alasan_batal}',maxLines: 5,overflow: TextOverflow.ellipsis,))
                      ],
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ],
    );
  }
}
