import 'package:get/get.dart';

class HistoryController extends GetxController {
  var selectedCategory = 'Semua'.obs;

  void changeCategory(String newCategory) {
    selectedCategory.value = newCategory;
  }
}
