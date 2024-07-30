import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_user_ui/pages/detail-menu_page/view/detail_menu_page.dart';
import 'package:warmindo_user_ui/common/model/menu_list_API_model.dart';
import 'package:warmindo_user_ui/common/model/menu_model.dart';
import 'package:warmindo_user_ui/pages/home_page/controller/schedule_controller.dart';
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
  final scheduleController = Get.find<ScheduleController>();
  final BuildContext context;
  final MenuList product;
  final double width;
  final double? height;
  final bool isGuest;

  ReusableCard({
    Key? key,
    required this.context,
    required this.product,
    required this.width,
    required this.isGuest,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
        locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return
        GestureDetector(
          onTap: () {
            Get.toNamed(
              Routes.DETAIL_MENU_PAGE,
              arguments: {
                'menu': product,
                'isGuest': isGuest,
              },
            );
          },
          child: Container(
              foregroundDecoration: scheduleController.jadwalElement[0].is_open
                  ? null
                  : BoxDecoration(
                color: Colors.grey,
                backgroundBlendMode: BlendMode.saturation,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            width: width,
            height: height,
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
            child:
            Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20), // Apply borderRadius here
                      child: Container(
                        width: double.infinity, // Use the screen width
                        height: 104,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20), // Apply borderRadius here too
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
                        child: GestureDetector(
                          onTap: () {},
                          child: Cart(context: context, product: product),
                        ),
                      ),
                    ),

                  ],
                ),
                Expanded(
                  child: ListTile(
                    title: Text(
                      product.nameMenu,
                      style: regularInputTextStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: descriptionTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  color: scheduleController.jadwalElement[0].is_open ? Colors.orange : Colors.grey,
                                  size: 20,
                                ),
                                Text(
                                  product.ratings.toString(),
                                  style: ratingTextStyle,
                                ),
                              ],
                            ),
                            Text(
                              currencyFormat.format(product.price),
                              style: priceTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ),
        );
  }
}


