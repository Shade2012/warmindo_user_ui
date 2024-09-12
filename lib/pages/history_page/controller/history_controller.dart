import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:warmindo_user_ui/common/model/cart_model2.dart';
import 'package:warmindo_user_ui/pages/navigator_page/controller/navigator_controller.dart';
import 'package:warmindo_user_ui/pages/pembatalan_page/view/pembatalan_page_view.dart';
import 'package:warmindo_user_ui/routes/AppPages.dart';
import 'package:warmindo_user_ui/utils/themes/image_themes.dart';
import '../../../common/global_variables.dart';
import '../../../common/model/history2_model.dart';
import '../../../widget/myRatingPopUp/rating_popup.dart';
import '../../../widget/reusable_dialog.dart';
import '../../cart_page/controller/cart_controller.dart';
import '../widget/popup_choose_payment.dart';

class HistoryController extends GetxController {
  late final SharedPreferences prefs;
  RxBool isConnected = false.obs;
  RxBool isLoadingButton = false.obs;
  RxString token = "".obs;
  final CartController cartController = Get.put(CartController());
  final NavigatorController navigatorController = Get.put(NavigatorController());
  final currencyFormat = NumberFormat.currency(
      locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  // final RxList<Order> orders = <Order>[].obs;
  final RxList<Order2> orders2 = <Order2>[].obs;
  RxString status = ''.obs;
  var selectedCategory = 'Semua'.obs;
  var selectedTimes = 'Terbaru'.obs;
  final RxBool isLoading = true.obs;
  final RxBool isRating2 = false.obs;
  bool keepPolling = true;
  // var order = Order2(id: null, totalprice: '', orderDetails: [], status: null,).obs;

  @override
  Future<void> onInit() async {
    // Call super.onInit() first
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    checkConnectivity();
    fetchHistory();
  }

  void checkConnectivity() async {


    var connectivityResult = await Connectivity().checkConnectivity();
    isConnected.value = connectivityResult != ConnectivityResult.none;

    // Listen for connectivity changes
    Connectivity().onConnectivityChanged.listen((
        ConnectivityResult result) async {
      isConnected.value = result != ConnectivityResult.none;
      if (isConnected.value) {
        await fetchHistory();
      }
    });
  }
  Future<void> fetchHistory() async {
    token.value = prefs.getString('token') ?? '';
    try {
      isLoading.value = true; // Set loading state to true
      final response = await http.get(
        Uri.parse(GlobalVariables.apiHistory),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${token.value}',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['orders'];
        orders2.clear();
        orders2.assignAll(data.map((item) => Order2.fromJson(item)).toList());
        orders2.refresh();
        isLoading.value = false;
      } else {
        // Handle other status codes if needed
        print('Failed to fetch history: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false; // Reset loading state
    }
  }

  Future<void> fetchHistorywithoutLoading() async {
    token.value = prefs.getString('token') ?? '';
    try {
      final response = await http.get(
        Uri.parse(GlobalVariables.apiHistory),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${token.value}',
        },
      ).timeout(const Duration(seconds: 10));
      print('mulai fetch');
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['orders'];
        orders2.clear();
        orders2.assignAll(data.map((item) => Order2.fromJson(item)).toList());
        orders2.refresh();
        isLoading.value = false;
        print('selesai fetch');
      } else {
        // Handle other status codes if needed
        print('Failed to fetch history: ${response.statusCode}');
      }
    } catch (e) {
      print('berhasil fetch history tanpa loading');
      print('Error: $e');
    }
  }
  void changeCategory(String newCategory) {
    selectedCategory.value = newCategory;
  }

  void changeTime(String newTimes) {
    selectedTimes.value = newTimes;
  }

  void saveOrderToHistory(Order2 order) {
    orders2.add(order);
  }

  List<Order2> filteredHistory() {
    if (selectedCategory.value == null || selectedCategory.value == 'Semua') {
      return orders2;
    } else {
      return orders2
          .where((order) => order.status == selectedCategory.value)
          .toList();
    }
  }


  String getButtonText(Order2 order) {
    if (order.status.value.toLowerCase() == 'selesai' ||
        order.status.value.toLowerCase() == "batal") {
      return "Pesan Lagi";
    } else if (order.status.value.toLowerCase() == 'menunggu pembayaran') {
      return 'Bayar';
    } else if(order.status.value.toLowerCase() == 'menunggu batal' && order.cancelMethod?.value == '' || order.status.value.toLowerCase() == 'konfirmasi pesanan'){
      return 'Konfirmasi Batal';
    }else{
      return 'Menunggu';
    }
  }

  String imageChange(String status) {
    if (status == 'Selesai') //1
        {
      return Images.pesanan_selesai;
    }else if(status == 'Konfirmasi Pesanan'){
      return Images.konfirmasi_pesanan;
    } else if (status == 'Sedang Diproses') {
      return Images.pesanan_sedang_diproses;
    } else if (status == 'Batal') {
      return Images.pesanan_batal;
    } else if (status == 'Menunggu Batal') {
      return Images.pesanan_menunggu_batal;
    } else if (status == 'Menunggu Pembayaran') {
      return Images.menunggu_pembayaran;
    } else if (status == 'Menunggu Pengembalian Dana'){
      return Images.refund;
    } else if (status == 'Sedang Diantar'){
      return Images.sedang_diantar;
    } else {
      return Images.pesanan_siap_diambil;
    }
  }



  Future<void> goToCart(Order2 order,BuildContext context) async {

    List<CartItem2> itemsToAdd = order.orderDetails
        .where((element) => element.statusMenu != '0').where((element) => element.stock != '0')
        .map((menu) {
      return CartItem2(
        productName: menu.nameMenu,
        productImage: menu.image,
        price: menu.price,
        quantity: menu.quantity.obs,
        productId: menu.menuId,
        selectedToppings: menu.toppings,
        selectedVarian: menu.selectedVarian,
      );
    }).toList();
    if(itemsToAdd.isNotEmpty){
      if(order.orderDetails.any((element) => element.statusMenu == "0") ){
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return ReusableDialog(
                  title: 'Pesan',
                  content: 'Menu yang ingin anda pesan saat ini ada yang dinonaktifkan. Apakah anda ingin tetap memesan ini?',
                  cancelText: 'Tidak',
                  confirmText: 'Iya',
                  onCancelPressed: () {
                    Get.back(closeOverlays: true);
                  },
                  onConfirmPressed: () async {
                    Get.back(closeOverlays: true);
                    isLoadingButton.value = true;
                    if (itemsToAdd.isNotEmpty) {
                      for (CartItem2 item2 in itemsToAdd) {
                        final existingItem = cartController.cartItems2.firstWhereOrNull((item) {
                          bool sameMenuId = item.productId == item2.productId;
                          bool sameVarian = (item2.selectedVarian?.varianID == item.selectedVarian?.varianID);
                          bool sameToppings = const DeepCollectionEquality().equals(item2.selectedToppings, item.selectedToppings);
                          return sameMenuId && sameVarian && sameToppings;
                        });

                        if (existingItem == null) {
                          await cartController.postCartItems2(
                            productId: item2.productId,
                            quantity: item2.quantity.value,
                            selectedVarian: item2.selectedVarian,
                            selectedToppings: item2.selectedToppings,
                            productName: item2.productName,
                            productImage: item2.productImage,
                            price: item2.price,
                            cartid: 0.obs,
                          );
                          cartController.cartItems2.refresh();
                        }  else {
                          existingItem.quantity.value += item2.quantity.value;
                          CartItem2 newItem = existingItem;
                          await cartController.editCart(
                            idCart: newItem.cartId?.value ?? 0,
                            quantity: newItem.quantity.value,
                            menuID: newItem.productId,
                          );
                          cartController.cartItems2.refresh();
                        }
                      }
                      navigatorController.currentIndex.value = 2;
                      Get.toNamed(Routes.BOTTOM_NAVBAR);
                      isLoadingButton.value = false;
                    }
                  });
            });
      }else{
        isLoadingButton.value = true;
        if (itemsToAdd.isNotEmpty) {
          for (CartItem2 item2 in itemsToAdd) {
            final existingItem = cartController.cartItems2.firstWhereOrNull((item) {
              bool sameMenuId = item.productId == item2.productId;
              bool sameVarian = (item2.selectedVarian?.varianID == item.selectedVarian?.varianID);
              bool sameToppings = const DeepCollectionEquality()
                  .equals(item2.selectedToppings, item.selectedToppings);

              return sameMenuId && sameVarian && sameToppings;
            });

            if (existingItem == null) {
              await cartController.postCartItems2(
                productId: item2.productId,
                quantity: item2.quantity.value,
                selectedVarian: item2.selectedVarian,
                selectedToppings: item2.selectedToppings,
                productName: item2.productName,
                productImage: item2.productImage,
                price: item2.price,
                cartid: 0.obs,
              );
              cartController.cartItems2.refresh();
            }  else {

              existingItem.quantity.value += item2.quantity.value;
              CartItem2 newItem = existingItem;
              await cartController.editCart(
                idCart: newItem.cartId?.value ?? 0,
                quantity: newItem.quantity.value,
                menuID: newItem.productId,
              );
              cartController.cartItems2.refresh();
            }
          }
          navigatorController.currentIndex.value = 2;
          Get.toNamed(Routes.BOTTOM_NAVBAR);
        }
      }
      isLoadingButton.value = false;
    }else{
      Get.snackbar('Pesan', 'Pesanan anda tidak bisa di prosest');
    }
  }


  void onButtonPressed(Order2 order, BuildContext context) {
    if (order.status.value.toLowerCase() == 'selesai' ||
        order.status.value.toLowerCase() == "batal") {
      goToCart(order,context);
    } else if (order.status.value.toLowerCase() == 'menunggu pembayaran') {
      showCustomModalForPayment(order.id, context);
    } else if(order.status.value.toLowerCase() == 'menunggu batal' && order.cancelMethod?.value == '' || order.status.value == 'konfirmasi pesanan'){
      Get.to(() => PembatalanPage(order: order,));
    }else {
      return;
    }
  }
  // Get.to(() => PembatalanPage(order: order,));
  void showCustomModalForRating(Order2 product, BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      elevation: 0,
      builder: (BuildContext context) => RatingCard(order: product,),
    );
  }
  void showCustomModalForPayment(int order, BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      elevation: 0,
      builder: (BuildContext context) => PopUpChoosePayment(orderID: order,),
    );
  }
  void makePayment2({required bool isTunai,required int orderid}) async {
    isLoading.value = true;
    const url = GlobalVariables.postPayment;
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${cartController.token.value}'
    };
    final body = {
      'order_id': orderid.toString(),
    };

    final urlTunai = '${GlobalVariables.editPaymentOrder}${orderid.toString()}';
    final headersTunai = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${cartController.token.value}'
    };
    final bodyTunai = {
      '_method': 'put',
      'payment_method':'tunai'
    };
    try{
      if(isTunai == true){
        final response = await http.post(Uri.parse(urlTunai),headers: headersTunai, body:bodyTunai);
        fetchHistory();
        Get.back(closeOverlays: true);

      }else{
        final response = await http.post(Uri.parse(url),headers: headers, body:body);
        final responseBody = jsonDecode(response.body);
        if(response.statusCode == 201){
          if(responseBody['status'] == 'success'){
            final uriString = Uri.parse(responseBody['checkout_link']);
            launchUrl(uriString,mode: LaunchMode.inAppWebView);
            Get.back();
            Get.back();
            Get.back();
            isLoading.value = false;
            // keepPolling = true;
            // longPollingFetchHistory();
            // Future.delayed(Duration(seconds: 20), () => stopPolling());
          }else if(responseBody['status'] == 'failed'){
            Get.snackbar('Pesan', 'Pesanan sudah di bayar');
            isLoading.value = false;
            fetchHistory();
          }else{
            print('ada error ');
          }
        }else if(response.statusCode == 400){
          Get.snackbar('Pesan', 'Pesanan sudah di bayar');
          isLoading.value = false;
          fetchHistory();
        }
      }
    }catch(e){
      print('ada error di catch $e');
    }
}

 }


