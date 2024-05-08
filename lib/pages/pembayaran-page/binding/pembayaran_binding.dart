import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/cart_page/controller/cart_controller.dart';
import 'package:warmindo_user_ui/pages/pembayaran-page/controller/pembayaran_controller.dart';

class PembayaranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PembayaranController>(() => PembayaranController());
  }
}
