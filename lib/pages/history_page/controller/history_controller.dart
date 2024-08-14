import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_rx/get_rx.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_user_ui/common/model/menu_list_API_model.dart';
import 'package:warmindo_user_ui/pages/cart_page/view/cart_page.dart';
import 'package:warmindo_user_ui/common/model/history.dart';
import 'package:warmindo_user_ui/utils/themes/image_themes.dart';
import 'package:warmindo_user_ui/widget/batal_popup.dart';
import '../../../common/global_variables.dart';
import '../../../common/model/history2_model.dart';
import '../../../widget/myRatingPopUp/rating_popup.dart';
import '../../cart_page/controller/cart_controller.dart';
import '../../../common/model/cartmodel.dart';


class HistoryController extends GetxController {
  RxBool isConnected = false.obs;
  final CartController cartController = Get.put(CartController());
  final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
  // final RxList<Order> orders = <Order>[].obs;
  final RxList<Order2> orders2 = <Order2>[].obs;
  RxString status = ''.obs;
  var selectedCategory = 'Semua'.obs;
  var selectedTimes = 'Terbaru'.obs;
  final RxBool isLoading = true.obs;
  final RxBool isRating2 = false.obs;

  @override
  void onInit() {
    // Call super.onInit() first
    super.onInit();
    Future.delayed(Duration(seconds: 4),(){
      isLoading.value = false;
    });
    // Initialize orders with order001 and order002
    checkConnectivity();
    // initializeOrders();

  }
  void checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    isConnected.value = connectivityResult != ConnectivityResult.none;

    // Listen for connectivity changes
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      isConnected.value = result != ConnectivityResult.none;
      if (isConnected.value) {
        await fetchHistory();
        // fetchProduct();
      }
    });
  }
  // void initializeOrders() async{
  //   orders.assignAll(orderList);
  // }

  Future<void> fetchHistory() async {
    print('history');
    try {
      isLoading.value = true;  // Set loading state to true
      final response = await http.get(
        Uri.parse('${GlobalVariables.apiHistory}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${cartController.token.value}',
        },
      ).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['orders'];
        orders2.clear();
        for (var item in data) {
          orders2.add(Order2.fromJson(item));
        }
      } else {
        // Handle other status codes if needed
        print('Failed to fetch history: ${response.statusCode}');
      }
      print(orders2);
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false;  // Reset loading state
    }
  }


  void changeCategory(String newCategory) {
    selectedCategory.value = newCategory;
  }
  void changeTime(String newTimes) {
    selectedTimes.value = newTimes;
  }
  void updateOrderStatus(Order order, String newStatus) {
    order.status.value = newStatus;
  }
  void saveOrderToHistory(Order2 order) {
    orders2.add(order);
  }

  List<Order2> getOrdersByStatus(String status) {
    return orders2.where((o) => o.status.value.toLowerCase() == status.toLowerCase()).toList();
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
    if(order.status == 'Selesai' || order.status == "Batal")
    {
      return "Pesan Lagi";
    } else if (order.status == 'Sedang Diproses'){
      return 'Batalkan';
    } else{
      return 'Menunggu';
    }

  }
  String imageChange(String status){
    if(status == 'Selesai') //1
    {
      return Images.pesanan_selesai;
    } else if(status == 'Sedang Diproses'){
      return Images.pesanan_sedang_diproses;
    }else if(status == 'Batal'){
      return Images.pesanan_batal;
    }else if(status == 'Menunggu Batal'){
      return Images.pesanan_menunggu_batal;
    }else if(status == 'Menunggu Pembayaran')
      {
        return Images.menunggu_pembayaran;
      }else{
      return Images.pesanan_siap_diambil;
    }
  }

  void goToCart(Order2 order) {
    List<CartItem> itemsToAdd = order.orderDetails.map((menu) {
      return CartItem(
        productName: menu.nameMenu,
        productImage: menu.image,
        price: menu.price,
        quantity: menu.quantity.obs,
        productId: menu.menuId,
      );
    }).toList();

    // Add the CartItem objects to the cartItems list
    cartController.cartItems.addAll(itemsToAdd);

    // Navigate to the cart screen
    Get.to(CartPage());
  }

  void onButtonPressed(Order2 order,BuildContext context) {
    if(order.status == 'Selesai' || order.status == "Batal")
      {
        goToCart(order);
      } else if (order.status == 'Sedang Diproses'){
      showDialog(context: context,  builder: (BuildContext context) {
        return BatalPopup(order: order,);
      },);
    } else{
      return null;
    }
  }
  void showCustomModalForRating(Order2 product, BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) => RatingCard(order: product,),
    );
  }


}


