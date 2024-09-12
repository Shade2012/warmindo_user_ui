import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:warmindo_user_ui/pages/cart_page/controller/cart_controller.dart';
import 'package:warmindo_user_ui/pages/history-detail_page/view/history_detail_page.dart';
import 'package:warmindo_user_ui/pages/history_page/controller/history_controller.dart';
import 'package:warmindo_user_ui/pages/pembayaran-page/view/pembayaran_complete_view.dart';
import 'package:warmindo_user_ui/service/locationService.dart';
import '../../../common/global_variables.dart';
import '../../../common/model/cart_model2.dart';
import '../../../common/model/history2_model.dart';



class PembayaranController extends GetxController{
  LocationService locationService = LocationService();
  late final TextEditingController ctrCatatan = TextEditingController(text: 'Catatan :');
  final HistoryController historyController = Get.put(HistoryController());
  final CartController cartController = Get.put(CartController());
  bool keepPolling = true;
  RxBool isLoading = false.obs;
  RxBool selectedOrderMethodTakeaway = false.obs;
  RxBool selectedOrderMethodDelivery = false.obs;
  RxDouble distanceBetween = 0.0.obs;
  RxInt deliveryFee = 0.obs;
  RxString orderID = ''.obs;
  final double radarLatitude = -6.7524781;
  final double radarLongitude = 110.8427672;

  RxBool isWithinRadar = false.obs;

RxBool selectedButton2 = false.obs;
RxBool selectedButton3 = false.obs;

void button2 (){
  selectedButton2.value = true;
  selectedButton3.value = false;
}
Future<void> calculateDeliveryFee () async {
  print('dipnaggil');
  double distanceInMeters = distanceBetween.value;
  int fee = 3000;
  deliveryFee.value = fee;
  if(distanceInMeters > 1500){
    double additionalDistance = distanceInMeters - 1500;
    int increments = (additionalDistance / 5).ceil();

    // Add 1000 for each 5-meter increment
    fee += increments * 1000;
    deliveryFee.value = fee;
    print('ini delivery fee di calculate ${deliveryFee.value}');
    print('ini distance in meter $distanceInMeters');
  }
}
  void delivery(BuildContext context) async {

  await checkUserWithinRadar(context);
    print("After location check, isWithinRadar: ${isWithinRadar.value}");

    if (isWithinRadar.value) {
       await calculateDeliveryFee();
       print(deliveryFee.value);
      print('User is within the radar: ${isWithinRadar.value}');
      selectedOrderMethodDelivery.value = true;
      selectedOrderMethodTakeaway.value = false;
    } else {
      print('User is outside the radar: ${isWithinRadar.value}');
      Get.snackbar('Pesan', 'Maaf Anda diluar jangkauan radar');
    }

  }

  Future<void> checkUserWithinRadar (BuildContext context) async{
  try{
    Position position = await locationService.getCurrentPosition();
    double distance = locationService.calculateDistance(
        radarLatitude,
        radarLongitude,
        position.latitude,
        position.longitude,
    );
    print("Calculated Distance: $distance meters");
    distanceBetween.value = distance;
    isWithinRadar.value = distance <= 12000;
    print(radarLongitude);
    print(radarLatitude);
    print(position.longitude);
    print(position.latitude);
    print("Is Within Radar: ${isWithinRadar.value}");
  }catch(e){
    if (e.toString().contains('permanently denied')) {
      // Show an alert dialog to guide the user to app settings
      showSettingsDialog(context);
    }
    Get.snackbar('Pesan', '$e');
  }
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
  void button3 (){
    selectedButton2.value = false;
    selectedButton3.value = true;
  }
int generateOrderId() {
  return DateTime.now().millisecondsSinceEpoch; // Example: Using timestamp as order ID
}
Future<void> postOrder({required String catatan,required int alamatID}) async{
    String payment_method =  selectedButton3.value == true ? 'tunai' : '';
    String order_method = selectedOrderMethodDelivery.value == true ? 'delivery' : 'take-away';
    const url = GlobalVariables.postOrder;
  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${cartController.token.value}',};
  final body = jsonEncode({
    'status': selectedButton3.value ? 'konfirmasi pesanan' : 'menunggu pembayaran',
    'payment_method': payment_method,
    'order_method': order_method,
    'alamat_users_id': alamatID,
    'note': catatan,
  });
  try{
    final response = await http.post(Uri.parse(url),headers: headers, body:body);
  final responseBody = jsonDecode(response.body);
    if (responseBody['success'] == true) {
      orderID.value = responseBody['data']['id'].toString();
    } else {
      print('Error: ${responseBody['message']}');
    }
  }catch(e){
    print(e);
  }
}

Future<void> postOrderDetail({required String catatan}) async{
  const url = GlobalVariables.postOrderDetail;
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'};
    Map<String, dynamic> toRequestBody() {
      return {
        'datas': cartController.cartItems2.map((item) {
          return {
            'quantity': item.quantity.value,
            'menu_id': item.productId,
            'order_id': orderID.value, // Assuming a static order_id for now
            'variant_id': item.selectedVarian?.varianID,
            'notes': catatan, // Assuming static notes for now
            'toppings': item.selectedToppings?.map((topping) => {
              'topping_id': topping.toppingID,
              'quantity': item.quantity.value,
            }).toList() ?? [],
          };
        }).toList(),
      };
    }
    try{
      final response = await http.post(Uri.parse(url),headers: headers, body: jsonEncode(toRequestBody()),);
      final responseBody = jsonDecode(response.body);
      print('bikin order detail');
    }catch(e){
      print('ada error disini $e');
    }
  }
  void removeNotiftoken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.remove('notif_token');
    prefs.remove('orderID');
  }
  void makePayment2({
    required String catatan,required bool isTunai, required int alamatID}) async {
    isLoading.value = true;

    const url = GlobalVariables.postPayment;
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${cartController.token.value}'
    };
    await postOrder(catatan: catatan, alamatID: alamatID);
    await postOrderDetail(catatan: catatan);
    final body = {
      'order_id': orderID.value,
    };
    try{
      if(isTunai == true){
        await historyController.fetchHistory();
        final order = historyController.orders2.firstWhere((order) => order.id.toString() == orderID.value,);
        Get.off(HistoryDetailPage(initialOrder: order));
      }else{
        final response = await http.post(Uri.parse(url),headers: headers, body:body);
        final responseBody = jsonDecode(response.body);
        if(response.statusCode == 201){
          print(responseBody['status']);
          if(responseBody['status'] == 'success'){
            final uriString = Uri.parse(responseBody['checkout_link']);
            launchUrl(uriString,mode: LaunchMode.inAppWebView);
            await historyController.fetchHistory();
              final order = historyController.orders2.firstWhere((order) => order.id.toString() == orderID.value,);
            Future.delayed(const Duration(seconds: 2), () {
              Get.off(HistoryDetailPage(initialOrder: order));
            });

          }else{
            print('ada error ');
          }
        }else{
          print(responseBody);
        }
      }
    }catch(e){
      print('ada error di catch2 $e');
    }
    cartController.fetchCart();
    isLoading.value = false;
  }

}




