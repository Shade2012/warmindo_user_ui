import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/history_page/model/history.dart';

class HistoryController extends GetxController {
  List<Order> orders = [
    order001,
    order002,
  ];


  void printOrdersLength() {
    print('Total Orders: ${orders.length}');
    print('Filtered Orders: ${filteredHistory().length}');
  }
  var selectedCategory = 'Semua'.obs;

  void changeCategory(String newCategory) {
    selectedCategory.value = newCategory;
  }
    List<Order> filteredHistory(){
  if (selectedCategory.value == null || selectedCategory.value == 'Semua') {
    return orders;
  } else {
    return orders.where((order) => order.status == selectedCategory.value).toList();
  }
}
}
