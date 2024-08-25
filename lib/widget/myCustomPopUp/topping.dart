import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/common/model/toppings.dart';

import '../../utils/themes/textstyle_themes.dart';
class ToppingDetail extends StatelessWidget {
   const ToppingDetail({super.key, required this.toppingList});
  final List<ToppingList> toppingList;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final sceenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: const Text('Topping'),leading:InkWell(
        child: Ink(
            child: const Icon(Icons.arrow_back_ios_new)),
        onTap: (){
          Get.back();
        },
      ),),
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: toppingList.length,
          itemBuilder: (context, index) {
            final toppingItem = toppingList[index];
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(toppingItem.nameTopping,style: boldphoneNumberTextStyle,),
                    Row(
                      children: [
                        Text('+${toppingItem.priceTopping}',style: boldTextStyle,),
                        Obx(() => Checkbox(
                          activeColor: Colors.black,
                          value: toppingItem.isSelected.value, // This should be a boolean property in your toppingItem model
                          onChanged: (bool? value) {
                            toppingItem.isSelected.value = value!;
                            int quantity = toppingItem.isSelected.value ? 1 : 0;
                            print('Topping name: ${toppingItem.nameTopping}\nTopping is selected value: ${toppingItem.isSelected.value}\n Topping quantity : $quantity');
                          },
                        ),
                        ),
                      ],
                    )
                  ],
                ),
                const Divider()
              ],
            );
        },),
      ),
    );
  }
}
