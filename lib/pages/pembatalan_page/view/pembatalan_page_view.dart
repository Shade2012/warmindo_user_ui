import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/pembatalan_page/controller/pembatalan_controller.dart';
import 'package:warmindo_user_ui/pages/pembatalan_page/widget/CustomRadio.dart';
import 'package:warmindo_user_ui/pages/pembatalan_page/widget/orderBox.dart';
import '../../../common/model/history2_model.dart';
import '../../../utils/themes/textstyle_themes.dart';
import '../../../widget/ReusableTextBox.dart';
import '../../../widget/appBar.dart';
import '../../edit-profile/widget/textform.dart';
class PembatalanPage extends StatelessWidget {
  final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
  final PembatalanController controller = Get.put(PembatalanController());
  final Order2 order;
   PembatalanPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {

    RxInt _value = 0.obs;

    return Scaffold(
         appBar: AppbarCustom(title: 'Pembatalan', style: headerRegularStyle),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OrderPembatalan(order: order),
              const SizedBox(height: 20,),
               Text('Metode Pengembalian',style: boldTextStyle,),
              const SizedBox(height: 10,),

              InkWell(
                onTap: () {
                  controller.selectedBanks.value = 'Belum Dipilih';
                  _value.value = 2;  // Update the reactive variable
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: const BorderRadius.all(Radius.circular(5))
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.account_balance_wallet_rounded,size: 30,),
                          const SizedBox(width: 5,),
                          Text('Tunai',style: boldTextStyle,)
                        ],
                      ),
                      CustomRadio(
                        value: 2.obs,
                        groupValue: _value,  // Same here
                        icons: const Icon(Icons.check_circle_outline, size: 30),
                        selectIcons: const Icon(Icons.check_circle, size: 29),
                        onChanged: (RxInt? value) {
                          controller.selectedBanks.value = 'Belum Dipilih';
                          _value.value = value!.value;  // Update the reactive variable
                          print('in the payment page $_value');  // This should print the updated value
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Obx(() {
                int totalprice = int.parse(order.totalprice);
                return AnimatedSize( duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: _value.value == 2
                      ? Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          border: Border( bottom: BorderSide(color: Colors.black),
                            left: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black),),
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(5),bottomLeft: Radius.circular(5))
                      ),
                      child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Pengembalian uang jika memakai tunai 100% tanpa biaya admin',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          Text(
                            '*Uang pengembalian ${currencyFormat.format(controller.calculatePriceCancel(order.paymentMethod ?? 'tunai', totalprice))}',
                              style: boldTextStyle
                          ),
                          const  SizedBox(height: 10,),
                        ],
                      )

                  )
                      : const SizedBox.shrink(), // Return an empty container if not selected
                );
              }),
              const SizedBox( height: 10,),
              ReusableTextBox(title: 'Alasan Batal : ', controller: controller.ctrAlasanBatal),
              const SizedBox(height: 10,),
              Obx((){
                return InkWell(
                  onTap: () async {
                    String fullText = controller.ctrAlasanBatal.text;
                    String alasanValue = fullText.replaceFirst('Alasan Batal :', '').trim();
                    controller.isLoadingButton.value = true;
                    Future.delayed(const Duration(seconds: 3),(){
                      controller.isLoadingButton.value = false;
                      if(controller.isLoadingButton.value == false){
                        print('ini alasan batal value $alasanValue');
                        if(alasanValue == ''){
                          Get.snackbar('Pesan', 'Berikan alasan pembatalan terlebih dahulu');
                          return;
                        } if(_value == 0){
                          Get.snackbar('Pesan', 'Pilih metode pengembalian terlebih dahulu');
                          return;
                        }else{
                          if(_value.value == 1){
                            if(controller.NoRek.text != ''){
                            int totalPrice = int.parse(order.totalprice);
                            if(totalPrice >= 20000){
                            controller.postCancelOrder(orderid: order.id.toString(), noRek: int.parse(controller.NoRek.text), cancelMethod: controller.selectedBanks.value, alasanBatal: alasanValue);
                            }else{
                              Get.snackbar('Pesan', 'Pembatalan tidak memenuhi syarat');
                            }
                            }else{
                              Get.snackbar('Pesan', 'Tolong isi no rekening terlebih dahulu');
                            }
                          }else if(_value.value == 2){
                           controller.postCancelOrder(orderid: order.id.toString(), noRek: 0, cancelMethod: 'tunai', alasanBatal: alasanValue);
                          }
                        }
                      }else{
                        return;
                      }
                    });

                  },
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius:
                        BorderRadius.all(Radius.circular(10))),
                    padding: const EdgeInsets.all(10),
                    child: controller.isLoadingButton.value
                        ? const Center(
                      child: SizedBox(
                        width: 20, // Adjust the width to your preference
                        height: 20, // Adjust the height to your preference
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3, // Adjust the stroke width if needed
                        ),
                      ),
                    ): Text(
                      "Batalkan",
                      style: whitevoucherTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}


