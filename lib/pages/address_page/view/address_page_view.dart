import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/address_page/controller/address_page_controller.dart';
import 'package:warmindo_user_ui/pages/address_page/shimmer/address_page_shimmer.dart';
import '../../../utils/themes/buttonstyle_themes.dart';
import '../../../utils/themes/icon_themes.dart';
import '../../../utils/themes/textstyle_themes.dart';
import '../widget/map_flutter_widget.dart';
class AddressPageView extends GetView<AddressPageController> {
   AddressPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Get.back(),
          ),
          title: Text(
            'Alamat',
            style: appBarTextStyle,
          ),
          centerTitle: true,
        ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.fetchAddress();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Obx((){
            if(controller.isLoading.value == true){
              return const AddressPageShimmer();
            }
            if(controller.isConnected.value == false){
              return Center(
                child: Container(
                  margin: EdgeInsets.only(top: screenHeight * 0.4),
                  child: Text(
                    'Tidak ada koneksi internet mohon check koneksi internet anda',
                    style: boldTextStyle,textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            if(controller.address.isEmpty){
              return Center(
                child: Container(
                  margin: EdgeInsets.only(top: screenHeight * 0.37),
                  child: Column(
                    children: [
                      const Icon(Icons.location_pin,size: 50,),
                      const SizedBox(height: 20,),
                      Text(
                        'Anda belum menambahkan alamat anda',
                        style: boldTextStyle,textAlign: TextAlign.center,
                      ),
                      InkWell(
                        onTap: () async {
                          await controller.checkUserWithinRadar(context,null);
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top: 10),
                          decoration: const BoxDecoration(
                              color: Colors.white,

                          ),
                          child: Container(
                            margin: const EdgeInsets.all(20),
                            padding: const EdgeInsets.all(15),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    spreadRadius: 0,
                                    blurRadius: 2,
                                    offset: const Offset(0, 1), // changes position of shadow
                                  ),
                                ]
                            ),
                            child: controller.addLoading.value
                                ? const Center(
                              child: SizedBox(
                                width: 20, // Adjust the width to your preference
                                height: 20, // Adjust the height to your preference
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3, // Adjust the stroke width if needed
                                ),
                              ),
                            ):Center(child: Text('Tambah Alamat',style: whiteboldTextStyle15,)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  child: SizedBox(
                    height: screenHeight * 0.73,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                      final addressItem = controller.address[index];
                      return Obx(()=>
                        InkWell(
                          onTap: () {
                            controller.selectAddress(addressItem.id ?? 0);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                  color: addressItem.selected?.value == '1' ? Colors.black : Colors.white,
                                ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.6),
                                  spreadRadius: 0,
                                  blurRadius: 4,
                                  offset: const Offset(0, 3),
                                ),
                              ]
                            ),

                            child: Padding(padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [Text(addressItem.nameAddress ?? '',style: boldTextStyle,),
                                    Row(
                                      children: [
                                        Visibility(visible: addressItem.selected?.value == '1' ,child: Text('Alamat Utama',style: boldTextStyle,),),
                                        const SizedBox(width: 10,),
                                        InkWell(
                                            onTap: () {
                                              controller.showBottomSheetModal(addressItem.id ?? 0,context);
                                            },
                                            child: SvgPicture.asset(
                                              IconThemes.icon_trash,
                                              width: 20,
                                              height: 25,
                                              color: Colors.red,)),
                                      ],
                                    )],
                                  ),
                                  Text(addressItem.detailAddress ?? '',style: regularInputTextStyle,),
                                  const SizedBox(height: 50,),
                                  SizedBox(
                                    width: double.infinity,
                                    height: screenHeight * 0.060,
                                    child: ElevatedButton(onPressed: () {
                                      Get.to(()=>FlutterMapWidget( lagtitude: addressItem.lagtitude ?? 0.0,longtitude: addressItem.longtitude ?? 0.0, isAdd: false, addressModel: addressItem,));
                                    },style: redeembutton(), child: Text('Ubah Alamat',style: whiteboldTextStyle15,)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }, itemCount: controller.address.length),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await controller.checkUserWithinRadar(context,null);
                  },
                  child: Container(
                    padding: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: const Offset(0, 1), // changes position of shadow
                          ),
                        ]
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.all(15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 0,
                              blurRadius: 2,
                              offset: const Offset(0, 1), // changes position of shadow
                            ),
                          ]
                      ),
                      child: controller.addLoading.value
                          ? const Center(
                        child: SizedBox(
                          width: 20, // Adjust the width to your preference
                          height: 20, // Adjust the height to your preference
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3, // Adjust the stroke width if needed
                          ),
                        ),
                      ):Center(child: Text('Tambah Alamat',style: whiteboldTextStyle15,)),
                    ),
                  ),
                )
              ],
            );
          }),
        ),
      )
    );
  }
}


