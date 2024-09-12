import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warmindo_user_ui/pages/pembayaran-page/controller/pembayaran_controller.dart';
import 'package:warmindo_user_ui/pages/pembayaran-page/widget/pop_up_address.dart';

import '../../../common/global_variables.dart';
import '../../../common/model/address_model.dart';
import '../../../service/locationService.dart';
import '../../../widget/reusable_dialog.dart';
import '../widget/map_flutter_widget.dart';

class AddressPageController extends GetxController {
  final PembayaranController pembayaranController = Get.put(PembayaranController());
  late final SharedPreferences prefs;
  RxString token = "".obs;
  LocationService locationService = LocationService();
  final RxList<AddressModel> address = <AddressModel>[].obs;
  final selectedLocation = const LatLng(-6.7524335, 110.8400653).obs;
  final double radarLatitude = -6.7524781;
  RxBool isConnected = true.obs;
  final double radarLongitude = 110.8427672;
  RxBool isWithinRadar = false.obs;
  int lagtitude = 0;
  int logtitude = 0;
  RxBool isLoading = true.obs;
  RxBool addLoading = false.obs;
  RxBool changed = false.obs;

  void confirm(){
    selectedLocation.value = LatLng(0.0, 0.0);
    Get.back();
    print(selectedLocation.value);
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(Duration(seconds: 3), () {
      isLoading.value = false;
    });
    checkConnectivity();
    print(selectedLocation.value);
  }
  void checkConnectivity() async {
    prefs = await SharedPreferences.getInstance();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      isConnected.value = result != ConnectivityResult.none;
      if (isConnected.value) {
        isLoading.value = true;
        await fetchAddress();
      }
    });

    var connectivityResult = await Connectivity().checkConnectivity();
    isConnected.value = connectivityResult != ConnectivityResult.none;
    if (isConnected.value) {
      await fetchAddress();
    }
  }

  Future<void> fetchAddress() async {
    token.value = prefs.getString('token') ?? '';
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse(GlobalVariables.apiAddressAll), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['data'];
        address.clear();
        address.value = data.map((json) => AddressModel.fromJson(json)).where((element) => element.statusAlamat?.value == '1',).toList();

      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> selectAddress(int id) async {
    isLoading.value = true;
    try {
      final response = await http.put(Uri.parse('${GlobalVariables.apiAddressSelected}$id'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        await fetchAddress();
        await pembayaranController.calculateDeliveryFee();
      }else{
        print(response.body);
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', '$e');
    } finally {
      isLoading.value = false;
    }
  }
  void showBottomSheetModal(int id,BuildContext context)async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ReusableDialog(
          title: 'Pesan',
          content:
          'Apakah anda yakin untuk menghapus alamat ini dari daftar alamat?',
          cancelText: "Tidak",
          confirmText: "Iya",
          onCancelPressed: () {
            Get.back();
          },
          onConfirmPressed: () async {
            deleteAddress(id);
            Get.back();
          },
        );
      },
    );

  }
  Future<void> deleteAddress(int id) async {
    isLoading.value = true;
    try {
      final response = await http.put(Uri.parse('${GlobalVariables.apiAddressDeleted}$id'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        await fetchAddress();
      }else{
        print(response.body);
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', '$e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkUserWithinRadar (BuildContext context,AddressModel? addressModel) async{
    addLoading.value = true;
    try{
      Position position = await locationService.getCurrentPosition();
      double distance = locationService.calculateDistance(
        radarLatitude,
        radarLongitude,
        position.latitude,
        position.longitude,
      );
      print("Calculated Distance: $distance meters");
      isWithinRadar.value = distance <= 12000;
      Get.to(()=>FlutterMapWidget(lagtitude: position.latitude,longtitude: position.longitude, isAdd: true, addressModel: addressModel,));
    }catch(e){
      if (e.toString().contains('permanently denied')) {
        // Show an alert dialog to guide the user to app settings
        showSettingsDialog(context);
      }
      print("Error: $e");
    }
    addLoading.value = false;
  }
  void showSettingsDialog(BuildContext context){
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Permission Required'),
        content: Text('Izin lokasi dilarang, silahkan pergi ke setting dan pilih enable '),
        actions: [
          TextButton(onPressed: () {
            locationService.openAppSettings();
            Get.back(closeOverlays: true);
          }, child: Text('Buka Settings')),
          TextButton(onPressed: () {
            Get.back(closeOverlays: true);
          }, child: Text('Nanti')),
        ],
      );
    },);
  }
  void showCustomModalForItem(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54, // Set a semi-transparent barrier color
      builder: (BuildContext context) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.of(context).pop();
          },
          child: PopUpAddress(
            addressList: address,
          ),
        );
      },
    );
  }

}

