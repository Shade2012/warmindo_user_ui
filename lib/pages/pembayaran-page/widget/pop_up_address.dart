import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/common/model/address_model.dart';
import 'package:warmindo_user_ui/pages/pembatalan_page/widget/CustomRadio.dart';
import 'package:warmindo_user_ui/utils/themes/buttonstyle_themes.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import '../../address_page/controller/address_page_controller.dart';

class PopUpAddress extends StatelessWidget {
  final AddressPageController addressPageController = Get.put(AddressPageController());
  final List<AddressModel> addressList;

  PopUpAddress({super.key, required this.addressList});

  @override
  Widget build(BuildContext context) {
    int initialIndex = addressList.indexWhere((element) => element.selected?.value == '1');
    RxInt _value = (initialIndex != -1 ? initialIndex : 0).obs;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.85,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Pilih Lokasi', style: boldTextStyle2),
              InkWell(
                onTap: () async {
                  await addressPageController.checkUserWithinRadar(context, null);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Text('Tambah Alamat', style: whiteboldTextStyle15),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(color: Colors.grey),
          const SizedBox(height: 10),
          Text('List Alamat', style: boldTextStyle),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              itemCount: addressList.length,
              itemBuilder: (context, index) {
                final address = addressList[index];
                return Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.location_on),
                              const SizedBox(width: 10),
                              Text(address.nameAddress ?? ''),
                            ],
                          ),
                          CustomRadio(
                            value: index.obs,
                            groupValue: _value,
                            icons: const Icon(Icons.check_circle_outline, size: 30),
                            selectIcons: const Icon(Icons.check_circle, size: 29),
                            onChanged: (RxInt? value) {
                              _value.value = value!.value;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(address.detailAddress ?? ''),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10);
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: double.infinity,
            child: Obx(()=> ElevatedButton(
                onPressed: () async {
                  final selectedAddress = addressList[_value.value];
                  await addressPageController.selectAddress(selectedAddress.id ?? 0);
                  Get.back();
                  print(selectedAddress);
                },
                style: redeembutton(),
                child: addressPageController.isLoading.value
                    ? const Center(
                  child: SizedBox(
                    width: 20, // Adjust the width to your preference
                    height: 20, // Adjust the height to your preference
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3, // Adjust the stroke width if needed
                    ),
                  ),
                ): Text('Konfirmasi', style: whiteboldTextStyle15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
