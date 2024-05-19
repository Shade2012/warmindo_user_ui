import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_user_ui/pages/pembayaran-page/controller/pembayaran_controller.dart';
import 'package:warmindo_user_ui/pages/pembayaran-page/view/pembayaran_complete_view.dart';
import 'package:warmindo_user_ui/pages/voucher_page/controller/voucher_controller.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import 'package:warmindo_user_ui/widget/map/view/map_view.dart';
import '../../../utils/themes/image_themes.dart';
import '../../../widget/appBar.dart';
import '../../cart_page/controller/cart_controller.dart';
import '../../cart_page/model/cartmodel.dart';

class PembayaranPage extends GetView<PembayaranController> {
  final CartController cartController = Get.put(CartController());
  final VoucherController voucherController = Get.put(VoucherController());

  @override
  Widget build(BuildContext context) {
    final currencyFormat =
    NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    final CartController cartController = Get.put(CartController());
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppbarCustom(title: 'Pembayaran',),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Metode Pemesanan",style: boldTextStyle,),
            SizedBox(height: 20,),
             Container(
               width: double.infinity,
               child: Obx(() => InkWell(
                 onTap: (){
                   controller.selected.value = true;
                 },
                 child: Ink(
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.all(Radius.circular(10)),
                     border: controller.selected.value ? Border.all(
                       color: Colors.black,
                       width: 2
                     ) : null,

                     boxShadow: [
                       BoxShadow(
                         color: Colors.grey.withOpacity(0.4),
                         spreadRadius: 0,
                         blurRadius: 2,
                         offset: Offset(0, 1), // changes position of shadow
                       ),
                     ],
                   ),
                   padding: EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
                   child: Text("Takeaway",style: boldTextStyle,textAlign: TextAlign.center,),
                 ),
               )),
             ),
            SizedBox( height: 20,),
            Row(
              children: [
                MapScreen(),
                SizedBox( width: 20,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Warmindo Anggrek Muria",
                        style: boldTextStyle,
                      ),
                      Text(
                        "Gg.10,Besito Kulon,Besito,Kec.Gebog,Kabupaten Kudus,",
                        style: boldgreyText,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox( height: 20,),
            Text("Metode Pembayaran",style: boldTextStyle,),
            SizedBox( height: 10,),
            Obx((){
             return Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: controller.selectedButton1.value ? Border.all(
                            color: Colors.black,
                            width: 2
                        ) : null,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 0,
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ]
                    ),
                    child: InkWell(
                      onTap: (){
                        controller.button1();
                      },
                      child: Ink(
                        child: Image.asset(
                          width: screenWidth / 7,
                          height: screenWidth /6.6,
                          Images.ovo,
                          fit: BoxFit.fill,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: controller.selectedButton2.value ? Border.all(
                            color: Colors.black,
                            width: 2
                        ) : null,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 0,
                            blurRadius: 2,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ]
                    ),
                    child:InkWell(
                      onTap: (){
                        controller.button2();
                      },
                      child: Ink(
                        child: Image.asset(
                          width: screenWidth / 7,
                          height: screenWidth /6.6,
                          Images.dana,
                          fit: BoxFit.fill,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),

            SizedBox( height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total", style: boldTextStyle),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                          '(${cartController.cartItems.length} Items)'),
                      SizedBox(
                        width: 5,
                      ),
                      Obx(() {
                        double totalPrice = 0;
                        for (CartItem cartItem in cartController.cartItems) {
                          totalPrice += cartItem.price * cartItem.quantity;
                          totalPrice -= voucherController.appliedVoucher.value?.discount ?? 0;
                        }
                        return Text(
                            currencyFormat.format(totalPrice),
                            style: boldTextStyle);
                      }),
                    ]),
              ],
            ),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                if (!controller.selected.value) {
                  Get.snackbar(
                    'Pesan',
                    'Silakan pilih metode pemesananya terlebih dahulu',
                    backgroundColor: Colors.orange,
                    colorText: Colors.white,
                  );
                  return;
                }


                if (!controller.selectedButton1.value && !controller.selectedButton2.value) {
                  Get.snackbar(
                    'Pesan',
                    'Silakan pilih metode pembayaranya terlebih dahulu',
                    backgroundColor: Colors.orange,
                    colorText: Colors.white,
                  );
                  return; // Return to prevent further execution
                }

                // Make the payment
                controller.makePayment();
              },
              child: Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Text(
                  "Bayar",
                  style: categoryMenuTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
