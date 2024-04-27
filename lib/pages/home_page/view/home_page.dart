import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:warmindo_user_ui/pages/home_page/controller/home_controller.dart';
import 'package:warmindo_user_ui/widget/cart.dart';
import 'package:warmindo_user_ui/widget/makanan_widget.dart';

import '../../../utils/themes/color_themes.dart';
import '../../../utils/themes/icon_themes.dart';
import '../../../utils/themes/image_themes.dart';
import '../../../utils/themes/textstyle_themes.dart';
import '../../../widget/minuman_widget.dart';
import '../../../widget/rounded_image.dart';
import '../../../widget/snack_widget.dart';
import '../../navigator_page/view/navigator_page.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Selamat Pagi", style: regularTextStyle),
                    Container(
                      margin: EdgeInsets.only(bottom: 40),
                      child: Text("User", style: boldTextStyle2),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MakananWidget(),
                        MinumanWidget(),
                        SnackWidget(),
                      ],
                    ),
                    SizedBox(height: 20,),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          viewportFraction: 1,
                          autoPlay: true,
                        ),
                        items: [
                          RoundedImage(imageUrl: Images.promo1, padding: EdgeInsets.all(10.0)),
                          RoundedImage(imageUrl: Images.promo2, padding: EdgeInsets.all(10.0)),
                          RoundedImage(imageUrl: Images.promo3, padding: EdgeInsets.all(10.0)),
                        ],
                      ),
                    ),
                    Text("Favorite Makanan dan Minuman", style: LoginboldTextStyle),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Container(
                            width: 170,
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
                                          image: AssetImage(Images.onboard1),
                                          fit: BoxFit.cover,
                                          placeholder: AssetImage(Images.onboard2),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 5,
                                      right: 8,
                                      child: Container(
                                        child: GestureDetector(
                                          onTap: (){},
                                          child: Cart(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                ListTile(
                                  title: Text("Good Day", style: regularInputTextStyle),
                                  subtitle:
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 3,),
                                      Text("bubuk kopi dengan air panas langsung dalam gelas atau cangkir.", style: descriptionTextStyle),
                                      SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Wrap(
                                            crossAxisAlignment: WrapCrossAlignment.center,
                                            children: [
                                              Icon(Icons.star_rounded, color: Colors.orange, size: 20,),
                                              Text('4.6', style: ratingTextStyle),
                                            ],
                                          ),
                                          Text("Rp4.000", style: priceTextStyle),
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
                        Container(
                            width: 170,
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
                                          image: AssetImage(Images.onboard1),
                                          fit: BoxFit.cover,
                                          placeholder: AssetImage(Images.onboard2),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 5,
                                      right: 8,
                                      child: Container(
                                        child: GestureDetector(
                                          onTap: (){},
                                          child: Cart(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                ListTile(
                                  title: Text("Mie Ayam Penyet", style: regularInputTextStyle),
                                  subtitle: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 3,),
                                      Text("Ayam goreng dengan sambal penyet dan mi indomie", style: descriptionTextStyle),
                                      SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Wrap(
                                            crossAxisAlignment: WrapCrossAlignment.center,
                                            children: [
                                              Icon(Icons.star_rounded, color: Colors.orange, size: 20,),
                                              Text('4.6', style: ratingTextStyle),
                                            ],
                                          ),
                                          Text("Rp14.000", style: priceTextStyle),
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
                      ],
                    ),
                    SizedBox(height: 20,),
                    Text("Favorite Snack", style: LoginboldTextStyle),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.only(left: 10),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10,),
                                Text("Mendoan", style: regularInputTextStyle),
                                SizedBox(height: 3,),
                                Text(
                                  "adonan tepung teriguyang di goreng krispi dan taburi gula dan kayumanis ",
                                  style: descriptionTextStyle,
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Wrap(
                                      crossAxisAlignment: WrapCrossAlignment.center,
                                      children: [
                                        Icon(Icons.star_rounded, color: Colors.orange, size: 20,),
                                        Text('4.6', style: ratingTextStyle),
                                      ],
                                    ),
                                    Spacer(),
                                    Text("Rp14.000", style: priceTextStyle),
                                  ],
                                ),
                                SizedBox(height: 10,),
                              ],
                            ),
                          ),
                          SizedBox(width: 10,),
                          Container(
                            width: 122, // Use the screen width
                            height: 104,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topRight: (Radius.circular(20)),
                                bottomRight: (Radius.circular(20)),
                              ),
                              child: FadeInImage(
                                image: AssetImage(Images.onboard1),
                                fit: BoxFit.cover,
                                placeholder: AssetImage(Images.onboard2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),


                    SizedBox(height: 20,)
                  ],
              ),

        ),
      ),
    );
  }
}



