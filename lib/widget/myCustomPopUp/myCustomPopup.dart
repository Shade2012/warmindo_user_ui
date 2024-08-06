import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import 'package:warmindo_user_ui/widget/myCustomPopUp/shimmer.dart';
import '../../common/model/menu_list_API_model.dart';
import '../../pages/cart_page/controller/cart_controller.dart';
import '../counter/counter.dart';
import '../counter/counter_controller.dart';
import 'myPopup_controller.dart';

import 'topping.dart';

class MyCustomPopUp extends StatelessWidget {
  final MenuList product;
  final RxInt quantity;
  final int cartid;
  final ScrollController scrollController;

  MyCustomPopUp({
    required this.product,
    required this.quantity,
    required this.cartid,
    required this.scrollController,
  });

  final MyCustomPopUpController controller = Get.put(MyCustomPopUpController());
  final CounterController controllerCounter = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Obx(() {
        if (controller.isLoading.value) {
          return SingleChildScrollView(
            controller: scrollController,
            child: MyPopupShimmer(),
          );
        } else {
          return SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: EdgeInsets.all(20),
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
                  ClipRRect(
                    child: FadeInImage(
                      width: double.infinity,
                      height: 250,
                      placeholder: AssetImage('assets/images/logo.png'),
                      image: NetworkImage(product.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(product.nameMenu, style: onboardingHeaderTextStyle),
                  SizedBox(height: 10),
                  Text(product.category, style: onboardingskip),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.star_rounded, color: Colors.orange, size: 20),
                      Text('4.6', style: ratingTextStyle),
                    ],
                  ),
                  Divider(),
                  Text("Deskripsi", style: boldTextStyle),
                  SizedBox(height: 10),
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
                        Divider(),
                        Text('Varian', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Text('Harus Dipilih', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Obx(() {
                          final varianList = controller.varianList.where((element) => element.category == product.nameMenu).toList();
                          return Wrap(
                            spacing: 10.0,
                            runSpacing: 10.0,
                            children: List.generate(varianList.length, (index) {
                              final varian = varianList[index];
                              final isSelected = controller.selectedVarian[product.menuId] == varian;
                              print('Checking varian ${varian.nameVarian}, isSelected: $isSelected');
                              return GestureDetector(
                                onTap: () {
                                  controller.selectedVarian[product.menuId] = varian;
                                  controller.selectedVarian.refresh();
                                  print('Selected varian: ${varian.nameVarian}');
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isSelected ? Colors.white : Colors.grey[300],
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: isSelected ? Colors.black : Colors.transparent,
                                      width: 3.0,
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  child: Text(varian.nameVarian, style: TextStyle(color: Colors.black)),
                                ),
                              );
                            }),
                          );
                        }),
                      ],
                    ),
                  ),
              Visibility(
                visible: product.category == 'Makanan',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(),
                    Text('Topping', style: boldTextStyle),
                    SizedBox(height: 10),
                    Obx(() {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.toppingList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final toppingItem = controller.toppingList[index];
                          return Obx(() {
                            final isSelected = controller.selectedToppings[product.menuId]?.any((topping) => topping.toppingID == toppingItem.toppingID) ?? false;
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(toppingItem.nameTopping, style: boldphoneNumberTextStyle),
                                    Row(
                                      children: [
                                        Text('+${toppingItem.priceTopping}', style: boldTextStyle),
                                        Checkbox(
                                          activeColor: Colors.black,
                                          value: isSelected,
                                          onChanged: (bool? value) {
                                            controller.toggleTopping(product.menuId, toppingItem);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(),
                              ],
                            );
                          });
                        },
                      );
                    }),
                  ],
                ),
              ),

                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 4,
                          offset: Offset(0, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Harga", style: TextStyle(fontSize: 16, color: Colors.grey)),
                        CounterWidget(
                          quantity: quantity,
                          menu: product,
                          cartId: cartid,
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
