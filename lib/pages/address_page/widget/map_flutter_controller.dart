import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:warmindo_user_ui/pages/address_page/controller/address_page_controller.dart';

import '../../../common/global_variables.dart';
import '../../pembayaran-page/controller/pembayaran_controller.dart';

class MapFlutterController extends GetxController {
  final AddressPageController addressPageController = Get.put(AddressPageController());
  final PembayaranController pembayaranController = Get.put(PembayaranController());
  final addressTextController = TextEditingController();
  final kostTextController = TextEditingController();
  final namaAddressTextController = TextEditingController();
  final selectedLocation = const LatLng(0, 0).obs;
  final RxList<Placemark> selectedPlacemarks = <Placemark>[].obs;
  int lagtitude = 0;
  int logtitude = 0;
  RxBool changed = false.obs;
  RxBool confirmLoading = false.obs;
  Timer? _debounceTimer;
  void confirm(){
    selectedLocation.value = LatLng(0.0, 0.0);
    Get.back();
    print(selectedLocation.value);
  }
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
  }
  void updatePlacemarks() async {
    try {
      // Wait for the placemarkFromCoordinates to complete
      List<Placemark> placemarks = await placemarkFromCoordinates(
        selectedLocation.value.latitude,
        selectedLocation.value.longitude,
      );

      // Assign the result to the observable list
      selectedPlacemarks.value = placemarks;
    } catch (e) {
      print("Error fetching placemarks: $e");
    }
  }
  Future<void> confirmLocationUpdate({
    required int id,required double latitude,required double longtitude,
    required String nameAddress,required String catatanAddress,String? namaKost
  }) async {
    confirmLoading.value = true;
    try {
      final response = await http.post(Uri.parse('${GlobalVariables.apiAddressUpdate}$id'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${addressPageController.token.value}'
      },body: jsonEncode({
        'latitude': latitude,
        'longitude': longtitude,
        'nama_alamat': nameAddress,
        'catatan_alamat': catatanAddress,
        'detail_alamat': formatPlacemark(selectedPlacemarks.value),
        '_method': 'put',
        'nama_kost': namaKost,
      })).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        await addressPageController.fetchAddress();
        await pembayaranController.calculateDeliveryFee();
        Get.back();
        Get.snackbar('Pesan', 'Alamat Berhasil diganti');
      }
    } catch (e) {
      Get.snackbar('Error', '$e');
    } finally {
      confirmLoading.value = false;
    }
  }

  Future<void> addLocation({
    required double latitude,
    required double longtitude,
    required String nameAddress,
    required String catatanAddress,
    String? namaKost,
  }) async {
    confirmLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse(GlobalVariables.apiAddressStore),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${addressPageController.token.value}'
        },
        body: jsonEncode({
          'latitude': latitude,
          'longitude': longtitude,
          'nama_alamat': nameAddress,
          'catatan_alamat': catatanAddress,
          'nama_kost': namaKost,
          'detail_alamat': formatPlacemark(selectedPlacemarks.value)
        }),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 201) {
        print('Response: ${response.body}');
        await addressPageController.fetchAddress();
        Get.back();
        Get.snackbar('Pesan', 'Alamat Berhasil ditambah');
      } else {
        print('Failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        Get.snackbar('Error', 'Failed to add location: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e'); // Print the exact error message
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      confirmLoading.value = false;
    }
  }


  void updateLocation(LatLng newLocation) {
    changed.value = true;
    selectedLocation.value = newLocation;
    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 200), () async {
      List<Placemark> placemarks = await placemarkFromCoordinates(newLocation.latitude, newLocation.longitude);
      selectedPlacemarks.value = placemarks;
      changed.value = false;
      selectedLocation.value = newLocation;
      print(selectedLocation.value);
    });
  }
  String formatPlacemark(List<Placemark> placemarks) {
    // If there are no placemarks, return an empty string
    if (placemarks.isEmpty) return '';

    Placemark placemark = placemarks.first;

    // Extract the desired values
    String sublocality = placemark.subLocality ?? '';
    String name = placemark.name ?? '';
    String street = placemark.street ?? '';
    String thoroughfare = placemark.thoroughfare ?? '';
    String locality = placemark.locality ?? '';
    String subAdministrativeArea = placemark.subAdministrativeArea ?? '';
    String administrativeArea = placemark.administrativeArea ?? '';
    String postalCode = placemark.postalCode ?? '';
    String country = placemark.country ?? '';

    // Format the values into a single string
    return '$sublocality, $name, $street, $thoroughfare, $locality, $subAdministrativeArea, $administrativeArea, $postalCode, $country';
  }

}
