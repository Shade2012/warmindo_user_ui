import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:warmindo_user_ui/pages/pembayaran-page/controller/pembayaran_controller.dart';
import 'package:warmindo_user_ui/pages/pembayaran-page/view/pembayaran_complete_view.dart';
import 'package:warmindo_user_ui/pages/profile_page/controller/profile_controller.dart';

import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import 'package:warmindo_user_ui/widget/ReusableTextBox.dart';
import 'package:warmindo_user_ui/widget/map/view/map_view.dart';
import '../../../common/model/cart_model2.dart';
import '../../../utils/themes/image_themes.dart';
import '../../../widget/appBar.dart';
import '../../cart_page/controller/cart_controller.dart';
import '../../../common/model/cartmodel.dart';

class PembayaranPage extends GetView<PembayaranController> {

  final CartController cartController = Get.put(CartController());
  final ProfileController profileController = Get.put(ProfileController());


  @override
  Widget build(BuildContext context) {
    final currencyFormat =
    NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    final CartController cartController = Get.put(CartController());
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppbarCustom(title: 'Pembayaran',style: headerRegularStyle,),
      body: SingleChildScrollView(
        child: Container(
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
                        child: Column(
                          children: [
                            Ink(
                              child: Image.asset(
                                width: screenWidth / 7,
                                height: screenWidth /6.6,
                                Images.cashless,
                                fit: BoxFit.fill,
                                alignment: Alignment.center,
                              ),
                            ),
                            Center(child: Text('Cashless',style: boldTextStyle,),)
                          ],
                        ),
                      ),
                    ),
                    Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              border: controller.selectedButton3.value ? Border.all(
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
                          margin: EdgeInsets.only(left: 10),
                          child: InkWell(
                            onTap: (){
                              controller.button3();
                            },
                            child: Column(
                              children: [
                                Ink(
                                  child: Image.asset(
                                    width: screenWidth / 6,
                                    height: screenWidth /6.6,
                                    Images.tunai,
                                    fit: BoxFit.fill,
                                    alignment: Alignment.center,
                                  ),
                                ),
                                Center(child: Text('Tunai',style: boldTextStyle,),)
                              ],
                            ),
                          ),
                        ),
                  ],
                );
              }),

              SizedBox( height: 20,),
              ReusableTextBox(title: 'Catatan ', controller: controller.ctrCatatan),
              SizedBox( height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total", style: boldTextStyle),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                            '(${cartController.cartItems2.length} Items)'),
                        SizedBox(
                          width: 5,
                        ),
                        Obx(() {
                          double totalPrice = 0;

                          for (CartItem2 cartItem in cartController.cartItems2) {
                            int toppingTotalPrice = 0;
                            if (cartItem.selectedToppings != null) {
                              for (var topping in cartItem.selectedToppings!) {
                                toppingTotalPrice += topping.priceTopping;
                              }
                            }
                            totalPrice += (cartItem.price + toppingTotalPrice) * cartItem.quantity.value;
                          }

                          return Text(
                            currencyFormat.format(totalPrice),
                            style: boldTextStyle,
                          );
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
                    if (!controller.selectedButton2.value && !controller.selectedButton3.value) {
                      Get.snackbar(
                        'Pesan',
                        'Silakan pilih metode pembayaranya terlebih dahulu',
                        backgroundColor: Colors.orange,
                        colorText: Colors.white,
                      );
                    }else if(controller.selectedButton3.value){
                      if(profileController.user_verified.value == '0'){
                        Get.snackbar('Pesan', 'User belum terverifikasi, anda bisa mendapatnya setelah memesan selama 15 kali atau meminta ke Warmindo');
                      }else{
                        if( controller.isLoading.value == false){
                          controller.isLoading.value = true;
                          print('tunai');
                          String fullText = controller.ctrCatatan.text;
                          String catatanValue = fullText.replaceFirst('Catatan : ', '').trim();
                          print(catatanValue);
                          controller.makePayment2(catatan: catatanValue, isTunai: true);
                          // controller.makePayment(catatan: catatanValue);
                        }else{
                          return null;
                        }
                      }
                    }else{
                      print('cashless');
                      if( controller.isLoading.value == false){
                        controller.isLoading.value = true;
                        String fullText = controller.ctrCatatan.text;
                        String catatanValue = fullText.replaceFirst('Catatan : ', '').trim();
                        print(catatanValue);
                        controller.makePayment(catatan: catatanValue);
                        // controller.makePayment2(catatan: catatanValue, isTunai: false);
                      }else{
                        return null;
                      }
                    }

                  },
                  child: Obx(()=>
                      Container(
                        height: 40,
                        width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                        child: controller.isLoading.value
                            ? Center(
                          child: Container(
                            width: 20, // Adjust the width to your preference
                            height: 20, // Adjust the height to your preference
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3, // Adjust the stroke width if needed
                            ),
                          ),
                        ):Center(
                              child: Text("Bayar", style: categoryMenuTextStyle, textAlign: TextAlign.center,
                              ),
                            ),
                      ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
