import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:warmindo_user_ui/pages/cart_page/model/cartmodel.dart';
import 'package:warmindo_user_ui/pages/menu_page/model/menu_model.dart';
import 'package:warmindo_user_ui/widget/counter/counter.dart';
import 'package:get/get.dart';
import '../../pages/cart_page/controller/cart_controller.dart';
import '../../routes/AppPages.dart';
import '../../utils/themes/color_themes.dart';
import '../../utils/themes/image_themes.dart';
import '../../utils/themes/textstyle_themes.dart';
import '../counter/counter_controller.dart';
import 'myPopup_controller.dart';

class MyCustomPopUp extends StatelessWidget {
  final Menu product;

  MyCustomPopUp({required this.product});
  final MyCustomPopUpController controller = Get.put(MyCustomPopUpController());
  final CounterController controllerCounter = Get.put(CounterController());
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: MediaQuery.of(context).size.height  / 1.2, // Adjust the percentage as needed
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
      ),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                    child:Container(
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(

                        child: FadeInImage(
                          placeholder: AssetImage(Images.logo),
                          image:AssetImage(product.imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),


              ),
              SizedBox(height: 10,),
              Text(
                product.name,
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
              Text(product.description,style: onboardingskip,),
              SizedBox(height: 20,),
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() => Container(
                          child: Text(
                            "Rp " + (controllerCounter.quantity.value * product.price).toString(),
                            style: onboardingHeaderTextStyle,
                          ),
                        ),
                        ),
                        CounterWidget()
                      ],
                    ),
                    SizedBox(height: 15,),
                    GestureDetector(
                      onTap: (){
                        controller.addToCart(product);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorResources.btnonboard,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),

                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 14,
                          child: Center(child: Text("Tambah Ke Keranjang",style: whiteboldTextStyle, ))
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );

  }
}

