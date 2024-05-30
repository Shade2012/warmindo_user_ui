import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_user_ui/pages/cart_page/view/cart_page.dart';
import 'package:warmindo_user_ui/common/model/history.dart';
import 'package:warmindo_user_ui/widget/batal_popup.dart';
import 'package:warmindo_user_ui/widget/cart.dart';

import '../../../widget/myRatingPopUp/rating_popup.dart';
import '../../cart_page/controller/cart_controller.dart';
import '../../../common/model/cartmodel.dart';
import '../../../common/model/menu_model.dart';
import '../../../common/model/voucher_model.dart';

class HistoryController extends GetxController {
  final CartController cartController = Get.put(CartController());
  final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
  final RxList<Order> orders = <Order>[].obs;
  RxString status = ''.obs;
  var selectedCategory = 'Semua'.obs;
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
  void updateOrderStatus(Order order, String newStatus) {
    order.status.value = newStatus;
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

  String getVoucherText(Order order) {
    if (order.vouchers != null && order.vouchers!.isNotEmpty) {
      final voucherPrice = calculateTotalDiscount(order);
      final formattedPrice = currencyFormat.format(voucherPrice);
      return "- $formattedPrice"; // Assuming 'Potongan Harga' is the title and formattedPrice is the price
    } else {
      return "-";
    }
  }

  int calculateTotalDiscount(Order order) {
    if (order.vouchers == null) return 0;

    int totalDiscount = 0;
    for (Voucher voucher in order.vouchers!) {
      totalDiscount += voucher.discount;
    }
    return totalDiscount;
  }

  String calculateTotalPrice(Order order) {
    int totalPrice = 0;
    for (Menu menu in order.menus) {
      totalPrice += menu.price * menu.quantity;
    }

    // Check if the order has a voucher
    if (order.vouchers != null && order.vouchers!.isNotEmpty) {
      // Calculate total discount from vouchers
      int totalDiscount = 0;
      for (Voucher voucher in order.vouchers!) {
        totalDiscount += voucher.discount;
      }

      // Reduce total price by total discount
      totalPrice -= totalDiscount;
    }

    return currencyFormat.format(totalPrice) ;
  }
  String getButtonText(Order order) {
    if(order.status == 'Selesai' || order.status == "Batal")
    {
      return "Pesan Lagi";
    } else if (order.status == 'In Progress' || order.status == 'Pesanan Siap'){
      return 'Batalkan';
    } else{
      return 'Menunggu';
    }

  }
  Color getButtonColor(Order order) {
    switch (order.status) {
      case 'Selesai':
      case 'Batal':
        return Colors.green;
      case 'In Progress':
      case 'Pesanan Siap':
        return Colors.red;
      case 'Menunggu Batal':
        return Colors.grey;
      default:
        return Colors.transparent; // Default color if status is unknown
    }
  }
  void gotoRating(Order order){

  }
  void goToCart(Order order) {
    List<CartItem> itemsToAdd = order.menus.map((menu) {
      return CartItem(
        productName: menu.name,
        productImage: menu.imagePath,
        price: menu.price,
        quantity: menu.quantity,
        productId: menu.id,
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
      } else if (order.status == 'In Progress' || order.status == 'Pesanan Siap'){
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

