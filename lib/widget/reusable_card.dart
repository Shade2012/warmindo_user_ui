import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_user_ui/pages/detail-menu_page/view/detail_menu_page.dart';
import 'package:warmindo_user_ui/common/model/menu_list_API_model.dart';
import 'package:warmindo_user_ui/common/model/menu_model.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';

import '../pages/home_page/controller/home_controller.dart';
import '../routes/AppPages.dart';
import '../utils/themes/color_themes.dart';
import '../utils/themes/image_themes.dart';
import 'cart.dart';
import 'myCustomPopUp/myPopup_controller.dart';

class ReusableCard extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  final popUpcontroller = Get.put(MyCustomPopUpController());
  final BuildContext context;
  final MenuList product;
  final double width;
  final bool isGuest;

  ReusableCard({
    Key? key,
    required this.context,
    required this.product, required this.width, required this.isGuest,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return  GestureDetector(
      onTap: (){
        // Get.to(DetailMenuPage(menu: product, isGuest: isGuest,));
        Get.toNamed(
          Routes.DETAIL_MENU_PAGE,
          arguments: {
            'menu': product,
            'isGuest': isGuest,
          },
        );
      },
      child: Container(
        width: width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: ColorResources.backgroundCardColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity, // Use the screen width
                  height: 104,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: FadeInImage(
                      image: NetworkImage(product.image),
                      fit: BoxFit.cover,
                      placeholder: AssetImage(Images.placeholder),
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                Visibility(
                  visible: !isGuest,
                  child: Positioned(
                    top: 5,
                    right: 8,
                    child: Container(
                      child: GestureDetector(
                        onTap: (){},
                        child: Cart(context: context, product: product,),

                      ),
                    ),
                  ),
                ),
              ],
            ),
            ListTile(
              title: Text(product.nameMenu, style: regularInputTextStyle,maxLines: 1,overflow: TextOverflow.ellipsis,),
              subtitle:
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 3,),
                  Text(product.description,  maxLines: 2,
                      overflow: TextOverflow.ellipsis, style: descriptionTextStyle),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(Icons.star_rounded, color: Colors.orange, size: 20,),
                          Text(product.ratings.toString(), style: ratingTextStyle),
                        ],
                      ),
                      Text(currencyFormat.format(product.price), style: priceTextStyle),
                    ],
                  ),
                  SizedBox(height: 10,)
                ],
              ),
              // Add more fields to display as needed
            ),
          ],
        ),
      ),
    );
  }
}
