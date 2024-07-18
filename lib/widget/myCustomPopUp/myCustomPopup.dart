import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_user_ui/common/model/cartmodel.dart';
import 'package:warmindo_user_ui/common/model/menu_list_API_model.dart';
import 'package:warmindo_user_ui/common/model/menu_model.dart';
import 'package:warmindo_user_ui/widget/counter/counter.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/widget/myCustomPopUp/shimmer.dart';
import 'package:warmindo_user_ui/widget/shimmer/shimmer.dart';
import '../../pages/cart_page/controller/cart_controller.dart';
import '../../routes/AppPages.dart';
import '../../utils/themes/color_themes.dart';
import '../../utils/themes/image_themes.dart';
import '../../utils/themes/textstyle_themes.dart';
import '../counter/counter_controller.dart';
import 'myPopup_controller.dart';

class MyCustomPopUp extends StatelessWidget {
  final MenuList product;
  final RxInt quantity;
  final int cartid;
  MyCustomPopUp({required this.product, required this.quantity, required this.cartid,});
  final MyCustomPopUpController controller = Get.put(MyCustomPopUpController());
  final CounterController controllerCounter = Get.put(CounterController());
  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return SingleChildScrollView(
      child: Container(
          height: MediaQuery.of(context).size.height  / 1.2, // Adjust the percentage as needed
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
          ),
          child: Obx(() {
            if(controller.isLoading.value == true){
              return MyPopupShimmer();
            }else{
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child:Container(
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                child: FadeInImage(
                                  width: double.infinity,height: 250,
                                  placeholder: AssetImage(Images.logo),
                                  image:NetworkImage(product.image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            product.nameMenu,
                            style: onboardingHeaderTextStyle,
                          ),
                          SizedBox(height: 10,),
                          Text(
                            product.category,
                            style: onboardingskip,
                          ),
                          SizedBox(height: 10,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.star_rounded, color: Colors.orange, size: 20,),
                              Text('4.6', style: ratingTextStyle),
                            ],
                          ),
                          Divider(),
                          Text("Deskripsi",style: boldTextStyle,),
                          SizedBox(height: 10,),
                          Text(product.description,style: onboardingskip,maxLines: 3,overflow: TextOverflow.ellipsis,),
                          SizedBox(height: 20,),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 4,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Harga",style: onboardingskip,),

                            CounterWidget( quantity: quantity, menu: product, cartId: cartid, ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          })
      ),
    );

  }
}

