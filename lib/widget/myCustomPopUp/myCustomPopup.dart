import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../common/model/menu_list_API_model.dart';
import '../../pages/home_page/controller/schedule_controller.dart';
import '../../utils/themes/color_themes.dart';
import '../../utils/themes/textstyle_themes.dart';
import '../counter/counter.dart';
import '../counter/counter_controller.dart';
import 'myPopup_controller.dart';
import 'shimmer.dart';

class MyCustomPopUp extends StatelessWidget {
  final MenuList product;
  final RxInt quantity;
  final RxInt cartid;
  final ScrollController scrollController;

  MyCustomPopUp({super.key,
    required this.product,
    required this.quantity,
    required this.cartid,
    required this.scrollController,
  });

  final MyCustomPopUpController controller = Get.put(MyCustomPopUpController());
  final CounterController controllerCounter = Get.put(CounterController());
  final ScheduleController scheduleController = Get.find<ScheduleController>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    void checkAndUpdateCartId() {
      Future.delayed(const Duration(seconds: 4), () {
        final cartItem = controller.cartController.cartItems2.firstWhere((element) => element.productId == product.menuId);
        if (cartItem.cartId?.value != null) {
          cartid.value = cartItem.cartId!.value;
          print('cartid updated: ${cartid.value}');
        } else {
          print('cartid is still null, retrying...');
          checkAndUpdateCartId();
        }
      });
    }

    // Start the loop if the cartid is not set
    if (controller.isLoading.value || cartid.value == 0) {
      checkAndUpdateCartId();
    }

    return Container(
      foregroundDecoration: (product.stock! > 1 && scheduleController.jadwalElement[0].is_open && product.statusMenu != '0')
          ? null
          : const BoxDecoration(
        color: Colors.grey,
        backgroundBlendMode: BlendMode.saturation,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Obx(() {
        if (controller.isLoading.value || cartid.value == 0) {
          return SingleChildScrollView(
            controller: scrollController,
            child: const Column(
              children: [
                MyPopupShimmer(),
              ],
            ),
          );
        } else {
          return SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: screenWidth * 0.6,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  ClipRRect(
                    child: FadeInImage(
                      width: double.infinity,
                      height: 250,
                      placeholder: const AssetImage('assets/images/logo.png'),
                      image: NetworkImage(product.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(product.nameMenu, style: onboardingHeaderTextStyle),
                  const SizedBox(height: 10),
                  Text(product.category, style: onboardingskip),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.star_rounded, color: Colors.orange, size: 20),
                      Text(product.rating.toString(), style: ratingTextStyle),
                    ],
                  ),
                  const Divider(),
                  Text("Deskripsi", style: boldTextStyle),
                  const SizedBox(height: 10),
                  Text(
                    product.description,
                    style: onboardingskip,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Visibility(
                    visible: controller.varianList.any((varian) => varian.category == product.nameMenu),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(),
                        const Text('Varian', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        const Text('Harus Dipilih', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Obx(() {
                          final varianList = controller.varianList.where((element) => element.category == product.nameMenu).toList();
                          final isSelectedVarian = controller.selectedVarian[cartid.value];

                          return Wrap(
                            spacing: 10.0,
                            runSpacing: 10.0,
                            children: List.generate(varianList.length, (index) {
                              final varian = varianList[index];
                              final isSelected = isSelectedVarian == varian;
                              return GestureDetector(
                                onTap: () {
                                  controller.selectedVarian[cartid.value] = varian;
                                  controller.selectedVarian.refresh();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isSelected ? ColorResources.primaryColor : Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: isSelected ? Colors.grey : Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  child: Text(varian.nameVarian, style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
                                ),
                              );
                            }),
                          );
                        }),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: product.category != 'Minuman',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(),
                        Text('Topping', style: boldTextStyle),
                        const SizedBox(height: 10),
                        Obx(() {
                          final isSelectedToppings = controller.selectedToppings[cartid.value] ?? [];
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.toppingList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final toppingItem = controller.toppingList[index];
                              final isSelected = isSelectedToppings.any((topping) => topping.toppingID == toppingItem.toppingID);
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(toppingItem.nameTopping, style: boldphoneNumberTextStyle),
                                      Row(
                                        children: [
                                          Text('+${ toppingItem.priceTopping}', style: boldTextStyle),
                                          Checkbox(
                                            activeColor: Colors.black,
                                            value: isSelected,
                                            onChanged: (bool? value) {
                                              controller.toggleTopping(cartid.value, toppingItem);
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                ],
                              );
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 4,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      borderRadius: const BorderRadius.all( Radius.circular(10)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Harga", style:  TextStyle(fontSize: 16, color: Colors.grey)),
                        CounterWidget(
                          quantity: quantity,
                          menu: product,
                          cartId: cartid.value,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
