import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/common/model/address_model.dart';
import 'package:warmindo_user_ui/pages/address_page/controller/address_page_controller.dart';
import 'package:warmindo_user_ui/pages/address_page/widget/map_flutter_widget.dart';
import 'package:warmindo_user_ui/utils/themes/buttonstyle_themes.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
class AddressWidget extends StatelessWidget {
  final AddressPageController addressPageController = Get.put(AddressPageController());
  final AddressModel addressModel;
   AddressWidget ({Key? key, required this.addressModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 0,
              blurRadius: 2,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ]
      ),
      child: Obx(()
        {
          if(addressPageController.address.isEmpty){
            return InkWell(
              onTap: () async {
                await addressPageController.checkUserWithinRadar(context,null);
              },
              child: Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: addressPageController.addLoading.value
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
            );
          }
          if(addressPageController.address.any((element) => element.selected != '1',)){
            return InkWell(
              onTap: () async {
                addressPageController.showCustomModalForItem(context);
              },
              child: Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: addressPageController.addLoading.value
                    ? const Center(
                  child: SizedBox(
                    width: 20, // Adjust the width to your preference
                    height: 20, // Adjust the height to your preference
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3, // Adjust the stroke width if needed
                    ),
                  ),
                ):Center(child: Text('Pilih Alamat',style: whiteboldTextStyle15,)),
              ),
            );
          }else{
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      addressModel.nameAddress ?? '',
                      style: regularTextStyle,
                    ),
                    InkWell(onTap: () {
                      addressPageController.showCustomModalForItem(context);
                    },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                            child: Text('Ganti Alamat',style: whiteboldTextStyle15,),
                          ),
                        ))
                  ],
                ),
                const SizedBox(height: 10,),
                Container(
                  width: screenWidth * 0.48,
                    child: Text(
                      style: regularInputTextStyle,
                  addressModel.detailAddress ?? '', maxLines: 5,
                  overflow: TextOverflow.ellipsis,))
              ],
            ),
            const SizedBox(height: 10,),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255 ,244, 244, 244),
                  borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Catatan Alamat',style: boldTextStyle,),
                    Text(addressModel.catatanAddress ?? '',style: regularInputTextStyle,),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
            InkWell(
              onTap: () {
                Get.to(()=>FlutterMapWidget(longtitude: addressModel.longtitude ?? 0, lagtitude: addressModel.lagtitude ?? 0, isAdd: false, addressModel: addressModel,));
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border:Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Row(
                  children: [
                    Icon(Icons.edit),
                    SizedBox(width: 5,),
                    Text('Ubah Alamat',)
                  ],
                ),
              ),
            ),
          ],
        );
          }
      })
      );
  }
}
