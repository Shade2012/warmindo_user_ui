import 'dart:convert';
import 'dart:ffi';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:warmindo_user_ui/common/model/history2_model.dart';
import 'package:warmindo_user_ui/common/model/toppings.dart';
import 'package:warmindo_user_ui/common/model/varians.dart';

import 'package:warmindo_user_ui/pages/cart_page/controller/cart_controller.dart';
import 'package:warmindo_user_ui/pages/history_page/controller/history_controller.dart';
import 'package:warmindo_user_ui/pages/login_page/controller/login_controller.dart';
import 'package:warmindo_user_ui/pages/pembayaran-page/view/pembayaran_complete_view.dart';
import 'package:warmindo_user_ui/routes/AppPages.dart';

import '../../../common/global_variables.dart';
import '../../../common/model/cart_model2.dart';
import '../../../common/model/history.dart';
import '../../../common/model/menu_model.dart';



class PembayaranController extends GetxController{
  late final TextEditingController ctrCatatan = TextEditingController(text: 'Catatan: ');
  final HistoryController historyController = Get.put(HistoryController());
  final CartController cartController = Get.put(CartController());
RxBool isLoading = false.obs;
RxBool selected = false.obs;
RxString orderID = ''.obs;

RxBool selectedButton2 = false.obs;
RxBool selectedButton3 = false.obs;

  void button1 (){

    selectedButton2.value = false;
    selectedButton3.value = false;
  }
void button2 (){
  selectedButton2.value = true;
  selectedButton3.value = false;
}
  void button3 (){
    selectedButton2.value = false;
    selectedButton3.value = true;
  }
int generateOrderId() {
  return DateTime.now().millisecondsSinceEpoch; // Example: Using timestamp as order ID
}
  String getPaymentMethod() {
    if (selectedButton2.value) {
      return 'OVO';
    } else if (selectedButton3.value) {
        return 'Tunai';
  } else {
      // Default payment method if neither button is selected
      return 'Default Payment Method';
    }
  }
void makePayment({required String catatan}) async  {
  int totalPrice2 = 0;
  isLoading.value = true;
  for (CartItem2 cartItem in cartController.cartItems2) {
    int toppingTotalPrice = 0;
    if (cartItem.selectedToppings != null) {
      for (var topping in cartItem.selectedToppings!) {
        toppingTotalPrice += topping.priceTopping;
      }
    }
    totalPrice2 += (cartItem.price + toppingTotalPrice) * cartItem.quantity.value;
  }
  String paymentMethod = getPaymentMethod();
    List<MenuList> orderedMenus = cartController.cartItems2.map((item) => MenuList(
      menuId: item.productId,
      nameMenu: item.productName,
      price: item.price,
      image: item.productImage,
      quantity: item.quantity.value, category: '', description: '',
      variantId: item.selectedVarian?.varianID,
      toppings: item.selectedToppings
    )).toList();

    Order2 order = Order2(
      id: generateOrderId(),
      orderDetails: orderedMenus,
      status: 'Sedang Diproses'.obs,
      orderMethod: 'Takeaway',
      paymentMethod: paymentMethod,
      catatan: catatan ?? '-', alasan_batal: ''.obs,
      totalprice:  totalPrice2.toString(),

    );

    saveOrderToHistory(order);
  for (CartItem2 item in cartController.cartItems2) {
    await cartController.removeCart(idCart: item.cartId!);
  }

  cartController.cartItems2.clear();
  isLoading.value = false;
    Get.off(PembayaranComplate()); // Navigate to the completion view


}
Future<void> postOrder({required String catatan}) async{
  final url = GlobalVariables.postOrder;
  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${cartController.token.value}',};
  final body = jsonEncode({
    'status': 'sedang diproses',
    'note': '$catatan',
  });
  try{
    final response = await http.post(Uri.parse(url),headers: headers, body:body);
  final responseBody = jsonDecode(response.body);
    if (responseBody['success'] == true) {
      orderID.value = responseBody['data']['id'].toString();
      print('Order ID saat post order: $orderID');
    } else {
      print('Error: ${responseBody['message']}');
    }
  }catch(e){
    print(e);
    print('ada error disini post order');
  }
}

Future<void> postOrderDetail({required String catatan}) async{
  print('Order ID di post order detail atas:${orderID.value}');
    final url = GlobalVariables.postOrderDetail;
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
            'notes': '$catatan', // Assuming static notes for now
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
      print('Order ID di post order detail bawah:${orderID.value}');
      print(response.body);

    }catch(e){
      print(toRequestBody());
      print('ada error disini $e');
    }
  }
  void removeNotiftoken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.remove('notif_token');
    prefs.remove('orderID');
  }
  void makePayment2({
    required String catatan,required bool isTunai}) async{
    print('di makepayment 2 atas ${orderID.value}');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('notif_token');
    isLoading.value = true;
    final url = GlobalVariables.postPayment;
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${cartController.token.value}'
    };
    await postOrder(catatan: catatan);
    await postOrderDetail(catatan: catatan);
    final body = jsonEncode({
      'order_id': orderID.value,
    });
    try{
      print(cartController.token.value);
      print('ini notif token : ${token}');
      if(isTunai == true){
      print('sukses');
      }else{
        final response = await http.post(Uri.parse(url),headers: headers, body:body);
        final responseBody = jsonDecode(response.body);
        if(response.statusCode == 201){
          if(responseBody['status'] == 'success'){
            final uriString = Uri.parse(responseBody['checkout_link']);
            launchUrl(uriString,mode: LaunchMode.inAppWebView);
          }else{
            print('ada error ');
            print(responseBody);
          }
        }else{
          print(orderID.value);
          print('Request Body: $body');
          print('Headers: $headers');
          print(' ada error di sini ${response.body}');
        }
      }
    }catch(e){
      print('ada error di catch $e');
    }
    // for (CartItem2 cartItem in cartController.cartItems2) {
    //   int toppingTotalPrice = 0;
    //   if (cartItem.selectedToppings != null) {
    //     for (var topping in cartItem.selectedToppings!) {
    //       toppingTotalPrice += topping.priceTopping;
    //     }
    //   }
    //   totalPrice2 += (cartItem.price + toppingTotalPrice) * cartItem.quantity.value;
    // }
    // String paymentMethod = getPaymentMethod();
    // List<MenuList> orderedMenus = cartController.cartItems2.map((item) => MenuList(
    //     menuId: item.productId,
    //     nameMenu: item.productName,
    //     price: item.price,
    //     image: item.productImage,
    //     quantity: item.quantity.value, category: '', description: '',
    //     variantId: item.selectedVarian?.varianID,
    //     toppings: item.selectedToppings
    // )).toList();
    //
    // List<VarianList> varianList = cartController.cartItems2
    //     .where((item) => item.selectedVarian != null) // Filter out items with null selectedVarian
    //     .map((item) => item.selectedVarian!) // Extract the VarianList from each CartItem2
    //     .toList();
    //
    // List<ToppingList> toppingList = cartController.cartItems2
    //     .expand((item) => item.selectedToppings ?? [])  // Use 'expand' to flatten the list
    //     .map((topping) => ToppingList(
    //   toppingID: topping.toppingID,
    //   nameTopping: topping.nameTopping,
    //   priceTopping: topping.priceTopping,
    // ))
    //     .toList();
    // Order order = Order(
    //   id: generateOrderId(),
    //   menus: orderedMenus,
    //   status: 'Sedang Diproses'.obs,
    //   orderMethod: 'Takeaway',
    //   paymentMethod: paymentMethod,
    //   selectedToppings: toppingList,
    //   selectedVarian: varianList,
    //
    //   paid: true,
    //   catatan: catatan ?? '-', alasan_batal: ''.obs,
    //   totalprice: totalPrice2,
    //
    // );
    //
    // saveOrderToHistory(order);
    // for (CartItem2 item in cartController.cartItems2) {
    //   await cartController.removeCart(idCart: item.cartId!);
    // }
    //
    // cartController.cartItems2.clear();
    // isLoading.value = false;
    // Get.off(PembayaranComplate()); // Navigate to the completion view


  }
void saveOrderToHistory(Order2 order) {
  final existingItemIndex = historyController.orders2.indexWhere((orderlist) => orderlist.status == order.status);
  historyController.saveOrderToHistory(order);
  // historyController.orders.add(order);
}
}


