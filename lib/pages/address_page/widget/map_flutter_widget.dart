import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:warmindo_user_ui/common/model/address_model.dart';
import 'package:warmindo_user_ui/pages/address_page/shimmer/map_flutter_widget_shimmer_.dart';
import 'package:warmindo_user_ui/pages/address_page/widget/map_flutter_controller.dart';
import 'package:warmindo_user_ui/utils/themes/buttonstyle_themes.dart';
import '../../../utils/themes/textstyle_themes.dart';
import '../../edit-profile/widget/textform.dart';

class FlutterMapWidget extends StatelessWidget {
  final controller = Get.put(MapFlutterController());
  final double longtitude;
  final double lagtitude;
  final bool isAdd;
  final AddressModel? addressModel;
  FlutterMapWidget({super.key, required this.longtitude, required this.lagtitude, required this.isAdd, required this.addressModel}) {
    controller.selectedLocation.value = LatLng(lagtitude, longtitude);
    controller.updatePlacemarks(); // Update placemarks when the location is set
    if (addressModel != null) {
      controller.addressTextController.text = addressModel!.catatanAddress!;
      controller.kostTextController.text = addressModel?.namaKost ?? '';
      controller.namaAddressTextController.text = addressModel!.nameAddress!;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Obx(
          () {
          return Scaffold(
            backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: screenHeight * 0.64,
                    child: FlutterMap(
                      options: MapOptions(
                        keepAlive: true,
                        initialCenter: controller.selectedLocation.value,
                        initialZoom: 17.0,
                        onPositionChanged: (mapPosition, hasGesture) {
                          if (hasGesture) {
                            controller.updateLocation(mapPosition.center);
                          }
                        },
                      ),
                      children: [
                        TileLayer(
                          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        ),
                        Obx(
                              () => MarkerLayer(
                            rotate: true,
                            markers: [
                              Marker(
                                width: 80.0,
                                height: 80.0,
                                point: controller.selectedLocation.value,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Stack(
                                    children: [
                                      Icon(
                                        Icons.location_pin,
                                        color: Colors.red,
                                        size: controller.changed.value ? 60 : 40.0,
                                      ),
                                      Positioned(
                                        top: 13,
                                        right: 20,
                                        child: Obx(
                                              () => controller.changed.value
                                              ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 1.6,
                                            ),
                                          )
                                              : const SizedBox(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: screenHeight * 0.56,
                    left: 20,
                    child: InkWell(
                      onTap: () {
                        Get.back(closeOverlays: true);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(100)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 0,
                              blurRadius: 4,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.arrow_back_ios_new),
                      ),
                    ),
                  ),
                ],
              ),
              Obx((){
                if(controller.changed.value == true){
                  return const MapFlutterWidgetShimmer();
                }else{
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 0,
                              blurRadius: 4,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                          ),
                        ),
                        child: Column(
                          children: [
                            Obx(
                                  () => Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 0,
                                      blurRadius: 4,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: controller.selectedPlacemarks.isNotEmpty // Check if the list is not empty
                                    ? RichText(
                                  text: TextSpan(
                                    style: const TextStyle(color: Colors.black, fontSize: 14), // Default style
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: '${controller.selectedPlacemarks[0].subLocality ?? ''}\n',
                                        style: boldTextStyle,
                                      ),
                                      const TextSpan(
                                        text: '\n', // Newline or space for additional spacing
                                      ),
                                      TextSpan(
                                        text: '${controller.selectedPlacemarks[0].name ?? ''}, ',
                                        style: regulargreyText,
                                      ),
                                      TextSpan(
                                        text: '${controller.selectedPlacemarks[0].street ?? ''}, ',
                                        style: regulargreyText,
                                      ),
                                      TextSpan(
                                        text: '${controller.selectedPlacemarks[0].thoroughfare ?? ''}, ',
                                        style: regulargreyText,
                                      ),
                                      TextSpan(
                                        text: '${controller.selectedPlacemarks[0].locality ?? ''}, ',
                                        style: regulargreyText,
                                      ),
                                      TextSpan(
                                        text: '${controller.selectedPlacemarks[0].subAdministrativeArea ?? ''}, ',
                                        style: regulargreyText,
                                      ),
                                      TextSpan(
                                        text: '${controller.selectedPlacemarks[0].administrativeArea ?? ''}, ',
                                        style: regulargreyText,
                                      ),
                                      TextSpan(
                                        text: '${controller.selectedPlacemarks[0].postalCode ?? ''}, ',
                                        style: regulargreyText,
                                      ),
                                      TextSpan(
                                        text: controller.selectedPlacemarks[0].country ?? '',
                                        style: regulargreyText,
                                      ),
                                    ],
                                  ),
                                )
                                    : const Text('Silahkan Pencet Tombol ini'), // Fallback message if the list is empty
                              ),
                            ),
                            myTextFormField(
                              TextInputType.text,
                              'Nama Alamat',
                              controller.namaAddressTextController,
                              regulargreyText,
                              3,
                            ),
                            myTextFormField(
                              TextInputType.text,
                              'Catatan Lokasi',
                              controller.addressTextController,
                              regulargreyText,
                              3,
                            ),
                            myTextFormField(
                              TextInputType.text,
                              'Kost (opsional)',
                              controller.kostTextController,
                              regulargreyText,
                              3,
                            ),
                            const SizedBox(height: 10,),
                            Obx(()=>
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(onPressed: () {
                                    if(isAdd == true){
                                      if (controller.namaAddressTextController.text == '' || controller.addressTextController.text == '') {
                                        Get.snackbar('Pesan', 'Tolong lengkapi data alamat terlebih dahulu');
                                        return;
                                      }
                                      controller.addLocation(latitude: controller.selectedLocation.value.latitude,longtitude: controller.selectedLocation.value.longitude, nameAddress: controller.namaAddressTextController.text, catatanAddress: controller.addressTextController.text, namaKost: controller.kostTextController.text);
                                    }else{
                                      if (controller.namaAddressTextController.text == '' || controller.addressTextController.text == '') {
                                        Get.snackbar('Pesan', 'Tolong lengkapi data alamat terlebih dahulu');
                                        return;
                                      }
                                      controller.confirmLocationUpdate(
                                        id: addressModel?.id ?? 0,
                                        nameAddress: controller.namaAddressTextController.text,
                                        catatanAddress: controller.addressTextController.text,
                                        namaKost: controller.kostTextController.text,
                                        latitude: controller.selectedLocation.value.latitude,
                                        longtitude: controller.selectedLocation.value.longitude,
                                      );
                                    }
                                  },style: redeembutton() ,child: controller.confirmLoading.value
                                      ? const Center(
                                    child: SizedBox(
                                      width: 20, // Adjust the width to your preference
                                      height: 20, // Adjust the height to your preference
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 3, // Adjust the stroke width if needed
                                      ),
                                    ),
                                  ):Center(child: Text(isAdd? 'Tambah' : 'Konfirmasi',style: whiteboldTextStyle15,))),
                                ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }
              }),
            ],
          ),
        ),
      );
          }
    );
  }
}
