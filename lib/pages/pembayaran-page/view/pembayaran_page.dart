import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_user_ui/pages/address_page/controller/address_page_controller.dart';
import 'package:warmindo_user_ui/pages/pembayaran-page/controller/pembayaran_controller.dart';
import 'package:warmindo_user_ui/pages/profile_page/controller/profile_controller.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import 'package:warmindo_user_ui/widget/ReusableTextBox.dart';
import 'package:warmindo_user_ui/widget/map/view/map_view.dart';
import '../../../common/model/address_model.dart';
import '../../../common/model/cart_model2.dart';
import '../../../utils/themes/image_themes.dart';
import '../../../widget/appBar.dart';
import '../../cart_page/controller/cart_controller.dart';
import '../widget/address_widget.dart';

class PembayaranPage extends GetView<PembayaranController> {


  final ProfileController profileController = Get.put(ProfileController());
  final AddressPageController addressPageController = Get.put(AddressPageController());

  PembayaranPage({super.key});


  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    final CartController cartController = Get.put(CartController());
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarCustom(title: 'Pembayaran',style: headerRegularStyle,),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Metode Pemesanan",style: boldTextStyle,),
              const SizedBox(height: 20,),
               Row(
                 children: [
                   Expanded(
                     child: Obx(() => InkWell(
                       onTap: (){
                         controller.selectedOrderMethodTakeaway.value = true;
                         controller.selectedOrderMethodDelivery.value = false;
                       },
                       child: Ink(
                         decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: const BorderRadius.all(Radius.circular(10)),
                           border: controller.selectedOrderMethodTakeaway.value ? Border.all(
                             color: Colors.black,
                             width: 2
                           ) : null,
                           boxShadow: [
                             BoxShadow(
                               color: Colors.grey.withOpacity(0.4),
                               spreadRadius: 0,
                               blurRadius: 2,
                               offset: const Offset(0, 1), // changes position of shadow
                             ),
                           ],
                         ),
                         padding: const EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
                         child: Text("Takeaway",style: boldTextStyle,textAlign: TextAlign.center,),
                       ),
                     )),
                   ),
                   const SizedBox(width: 10,),
                   Expanded(
                     child: Obx(() => InkWell(
                       onTap: (){
                         controller.delivery(context);
                       },
                       child: Ink(
                         decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: const BorderRadius.all(Radius.circular(10)),
                           border: controller.selectedOrderMethodDelivery.value ? Border.all(
                               color: Colors.black,
                               width: 2
                           ) : null,
                           boxShadow: [
                             BoxShadow(
                               color: Colors.grey.withOpacity(0.4),
                               spreadRadius: 0,
                               blurRadius: 2,
                               offset: const Offset(0, 1), // changes position of shadow
                             ),
                           ],
                         ),
                         padding: const EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
                         child: Text("Delivery",style: boldTextStyle,textAlign: TextAlign.center,),
                       ),
                     )),
                   ),
                 ],
               ),
              const SizedBox( height: 20,),
              Row(
                children: [
                  MapScreen(),
                  const SizedBox( width: 20,),
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
              const SizedBox( height: 20,),
              Text("Metode Pembayaran",style: boldTextStyle,),
              const SizedBox( height: 10,),
              Obx((){
               return Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          border: controller.selectedButton2.value ? Border.all(
                              color: Colors.black,
                              width: 2
                          ) : null,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 0,
                              blurRadius: 2,
                              offset: const Offset(0, 1), // changes position of shadow
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
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              border: controller.selectedButton3.value ? Border.all(
                                  color: Colors.black,
                                  width: 2
                              ) : null,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 0,
                                  blurRadius: 2,
                                  offset: const Offset(0, 1), // changes position of shadow
                                ),
                              ]
                          ),
                          margin: const EdgeInsets.only(left: 10),
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
              const SizedBox( height: 20,),
              Obx(()=> Visibility(
                  visible: controller.selectedOrderMethodDelivery.value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Alamat Pengantaran',style: boldTextStyle,),
                      const SizedBox(height: 20,),
                      AddressWidget(
                          addressModel: addressPageController.address.firstWhere(
                                (element) => element.selected?.value == '1',
                            orElse: () => AddressModel(),
                          ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox( height: 20,),
              ReusableTextBox(title: 'Catatan : ', controller: controller.ctrCatatan),
              const SizedBox( height: 20,),
              Obx(()=>Visibility(
                visible: controller.selectedOrderMethodDelivery.value == true,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Biaya Delivery", style: boldTextStyle),
                    Row(
                      children: [
                        const Text('Biaya Delivery'),
                        const SizedBox(width: 5,),
                        Obx(()=> Text(currencyFormat.format(controller.deliveryFee.value),style: boldTextStyle,)),
                      ],
                    )
                  ],
                ),
              ))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total", style: boldTextStyle),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                            '(${cartController.cartItems2.length} Items)'),
                        const SizedBox(
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
                            currencyFormat.format(controller.selectedOrderMethodDelivery.value ? totalPrice + controller.deliveryFee.value : totalPrice),
                            style: boldTextStyle,
                          );
                        }),
                      ]),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 20),
               InkWell(
                  onTap: () {
                    if(controller.selectedButton3.value == false && controller.selectedButton2.value == false){
                      Get.snackbar('Pesan', 'Silahkan pilih metode pembayaran terlebih dahulu');
                      return;
                    }
                    if (!controller.selectedOrderMethodDelivery.value && !controller.selectedOrderMethodTakeaway.value) {
                      Get.snackbar(
                        'Pesan',
                        'Silakan pilih metode pemesanan terlebih dahulu',
                        backgroundColor: Colors.orange,
                        colorText: Colors.white,
                      );
                      return;
                    }else if(controller.selectedOrderMethodDelivery.value == true){
                      if(controller.isWithinRadar.value != true){
                        Get.snackbar('Pesan', 'anda diluar jangkauan');
                        return;
                      }
                      if(addressPageController.address.isEmpty){
                        Get.snackbar('Pesan', 'Silahkan pilih alamat atau buat alamat terlebih dahulu');
                        return;
                      }
                    }
                      if(controller.selectedButton3.value){
                      if(profileController.user_verified.value == '0'){
                        Get.snackbar('Pesan', 'User belum terverifikasi, anda bisa mendapatnya setelah memesan selama 15 kali atau meminta ke Warmindo');
                        return;
                      }else{
                        if(controller.isLoading.value == false){
                          controller.isLoading.value = true;
                          String fullText = controller.ctrCatatan.text;
                          String catatanValue = fullText.replaceFirst('Catatan :', '').trim();
                          final address = addressPageController.address.firstWhere((element) => element.selected?.value == '1');
                          controller.makePayment2(catatan: catatanValue, isTunai: true, alamatID: address.id ?? 0);
                        }else{
                          return;
                        }
                      }
                    }else{
                      if( controller.isLoading.value == false){
                        controller.isLoading.value = true;
                        String fullText = controller.ctrCatatan.text;
                        String catatanValue = fullText.replaceFirst('Catatan :', '').trim();
                        final address = addressPageController.address.firstWhere((element) => element.selected?.value == '1');
                        controller.makePayment2(catatan: catatanValue, isTunai: false,alamatID: address.id ?? 0);
                      }else{
                        return;
                      }
                    }

                  },
                  child: Obx(()=>
                      Container(
                        height: 40,
                        width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                        child: controller.isLoading.value
                            ? const Center(
                          child: SizedBox(
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
