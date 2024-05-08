
import 'package:get/get.dart';



class CounterController extends GetxController {

  RxInt quantity = 1.obs;
  RxInt totalPrice = 0.obs;



  void add() {
    quantity.value++;
    update();
  }
  void reset() {
    quantity.value = 1; // Reset the value to 1
  }
  void subtract() {
    if(quantity.value  > 1){
      quantity.value--;
      update();
    }


  }
}
