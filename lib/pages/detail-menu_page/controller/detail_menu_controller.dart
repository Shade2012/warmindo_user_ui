import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/common/model/menu_list_API_model.dart';
import 'package:http/http.dart' as http;
import '../../../common/global_variables.dart';
import '../../../common/model/menu_model.dart';

class DetailMenuController extends GetxController {
  RxList<MenuList> menu = <MenuList>[].obs;
  RxBool isConnected = true.obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    checkConnectivity();
  }

  Future<void> fetchProduct(int menuId) async {
    try {
      isLoading.value = true;

      final response = await http.get(
        Uri.parse(GlobalVariables.apiMenuUrl),
      );

      if (response.statusCode == 200) {
        var fetchedMenu = menuListFromJson(response.body);
        // Filter the menu based on the provided menuId
        menu.value = fetchedMenu.where((item) => item.menuId == menuId).toList();
        print("Fetched and filtered menu list: ${menu.length} items");
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void checkConnectivity() async {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      isConnected.value = result != ConnectivityResult.none;
      if (isConnected.value) {
        // fetchProduct();
      }
    });

    var connectivityResult = await Connectivity().checkConnectivity();
    isConnected.value = connectivityResult != ConnectivityResult.none;
    if (isConnected.value) {
      // fetchProduct();
    }
  }
}
