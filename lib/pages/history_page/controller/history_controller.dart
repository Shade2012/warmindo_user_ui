import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_user_ui/pages/cart_page/view/cart_page.dart';
import 'package:warmindo_user_ui/pages/history_page/model/history.dart';
import 'package:warmindo_user_ui/widget/batal_popup.dart';
import 'package:warmindo_user_ui/widget/cart.dart';

import '../../cart_page/controller/cart_controller.dart';
import '../../cart_page/model/cartmodel.dart';
import '../../voucher_page/model/voucher_model.dart';

class HistoryController extends GetxController {
  final CartController cartController = Get.put(CartController());
  final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
  final RxList<Order> orders = <Order>[].obs;
  RxString status = ''.obs;
  var selectedCategory = 'Semua'.obs;

  @override
  void onInit() {
    // Call super.onInit() first
    super.onInit();
    // Initialize orders with order001 and order002
    initializeOrders();
  }

  void initializeOrders() {
    orders.assignAll([order001, order002]);
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
    switch (order.status) {
      case 'Selesai':
      case 'Batal':
        return "Pesan Lagi";
      case 'In Progress':
      case 'Pesanan Siap':
        return 'Batalkan';
      case 'Menunggu Batal':
        return 'Menunggu';
      default:
        return 'Pesan lagi'; // Default color if status is unknown
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

  void onButtonPressed(Order order) {
    switch (order.status) {
      case 'Selesai':
      case 'Batal':
      goToCart(order);
        break;
      case 'In Progress':
      case 'Pesanan Siap':
        Get.to(BatalPopup());
        break;
      case 'Menunggu Batal':
      // Do nothing or handle accordingly
        break;
      default:
      // For "Pesan Lagi", navigate to cart
        goToCart(order);
        break;
    }
  }

}
