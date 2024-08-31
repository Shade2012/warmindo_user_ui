import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:warmindo_user_ui/pages/cart_page/controller/cart_controller.dart';
import 'package:warmindo_user_ui/pages/history_page/controller/history_controller.dart';
import 'package:warmindo_user_ui/pages/pembayaran-page/view/pembayaran_complete_view.dart';
import '../../../common/global_variables.dart';
import '../../../common/model/cart_model2.dart';
import '../../../common/model/history2_model.dart';



class PembayaranController extends GetxController{
  late final TextEditingController ctrCatatan = TextEditingController(text: 'Catatan :');
  final HistoryController historyController = Get.put(HistoryController());
  final CartController cartController = Get.put(CartController());
  bool keepPolling = true;
RxBool isLoading = false.obs;
RxBool selected = false.obs;
RxString orderID = ''.obs;

RxBool selectedButton2 = false.obs;
RxBool selectedButton3 = false.obs;

void button2 (){
  selectedButton2.value = true;
  selectedButton3.value = false;
}
  void button3 (){
    selectedButton2.value = false;
    selectedButton3.value = true;
  }
  void stopPolling() {
    keepPolling = false;
  }
int generateOrderId() {
  return DateTime.now().millisecondsSinceEpoch; // Example: Using timestamp as order ID
}

  Future<void> longPollingFetchHistory() async {
    while (keepPolling) {
      try {
        final response = await http.get(
          Uri.parse(GlobalVariables.apiHistory),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${cartController.token.value}',
          },
        ).timeout(const Duration(seconds: 10));

        if (response.statusCode == 200) {
          List<dynamic> data = jsonDecode(response.body)['orders'];
          historyController.orders2.clear();
          for (var item in data) {
            historyController.orders2.add(Order2.fromJson(item));
          }
        } else {
          // Handle other status codes if needed
        }
        historyController.orders2.refresh();
        await Future.delayed(const Duration(seconds: 3));
      } catch (e) {
        print('Error occurred: $e');
        await Future.delayed(const Duration(seconds: 5));
      }
    }
  }
Future<void> postOrder({required String catatan}) async{
    String payment_method =  selectedButton3.value == true ? 'tunai' : '';
    // String takeaway =  selected.value == true ? 'take-away' : '';
    const url = GlobalVariables.postOrder;
  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${cartController.token.value}',};
  final body = jsonEncode({
    'status': selectedButton3.value ? 'sedang diproses' : 'menunggu pembayaran',
    'payment_method': payment_method,
    'order_method': 'take-away',
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
    required String catatan,required bool isTunai}) async {
    isLoading.value = true;
    const url = GlobalVariables.postPayment;
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${cartController.token.value}'
    };
    await postOrder(catatan: catatan);
    await postOrderDetail(catatan: catatan);
    final body = {
      'order_id': orderID.value,
    };
    try{
      if(isTunai == true){
        await historyController.fetchHistory();
          Get.off(PembayaranComplate());
      }else{
        final response = await http.post(Uri.parse(url),headers: headers, body:body);
        final responseBody = jsonDecode(response.body);
        if(response.statusCode == 201){
          if(responseBody['status'] == 'success'){
            final uriString = Uri.parse(responseBody['checkout_link']);
            launchUrl(uriString,mode: LaunchMode.inAppWebView);
            // keepPolling = true;
            // longPollingFetchHistory();
            // Future.delayed(const Duration(seconds: 30), () => stopPolling());
            Future.delayed(const Duration(seconds:1 ),(){
              Get.off(PembayaranComplate());
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
    //
    // for (int i = 0; i < cartController.cartItems2.length; i++) {
    //   CartItem2 item = cartController.cartItems2[i];
    //   await cartController.removeCart(idCart: item.cartId!.value);
    // }

    // //
    // cartController.cartItems2.clear();
    isLoading.value = false;
  }
}



