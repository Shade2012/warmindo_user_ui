import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/detail-voucher-page/controller/detail_voucher_controller.dart';

class DetailVoucherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailVoucherController>(() => DetailVoucherController());
  }
}