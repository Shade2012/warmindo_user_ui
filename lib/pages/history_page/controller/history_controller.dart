import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_user_ui/common/model/menu_list_API_model.dart';
import 'package:warmindo_user_ui/pages/cart_page/view/cart_page.dart';
import 'package:warmindo_user_ui/common/model/history.dart';
import 'package:warmindo_user_ui/utils/themes/image_themes.dart';
import 'package:warmindo_user_ui/widget/batal_popup.dart';
import '../../../widget/myRatingPopUp/rating_popup.dart';
import '../../cart_page/controller/cart_controller.dart';
import '../../../common/model/cartmodel.dart';


class HistoryController extends GetxController {
  RxBool isConnected = false.obs;
  final CartController cartController = Get.put(CartController());
  final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
  final RxList<Order> orders = <Order>[].obs;
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
    initializeOrders();
    checkConnectivity();
  }
  void checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    isConnected.value = connectivityResult != ConnectivityResult.none;

    // Listen for connectivity changes
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      isConnected.value = result != ConnectivityResult.none;
      if (isConnected.value) {
        // Fetch cart or other data
        // fetchProduct();
      }
    });
  }
  void initializeOrders() {
    orders.assignAll(orderList);
  }

  void printOrdersLength() {
    print('Total Orders: ${orders.length}');
    print('Filtered Orders: ${filteredHistory().length}');
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
  void saveOrderToHistory(Order order) {
    orders.add(order);
  }

  List<Order> getOrdersByStatus(String status) {
    return orders.where((o) => o.status.value.toLowerCase() == status.toLowerCase()).toList();
  }
  List<Order> filteredHistory() {
    if (selectedCategory.value == null || selectedCategory.value == 'Semua') {
      return orders;
    } else {
      return orders
          .where((order) => order.status == selectedCategory.value)
          .toList();
    }
  }


  String getButtonText(Order order) {
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
    }else{
      return Images.pesanan_siap_diambil;
    }
  }

  void goToCart(Order order) {
    List<CartItem> itemsToAdd = order.menus.map((menu) {
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

  void onButtonPressed(Order order,BuildContext context) {
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
  void showCustomModalForRating(Order product, BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) => RatingCard(order: product,),
    );
  }


}


