import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/widget/myRatingPopUp/rating_controller.dart';

import '../../pages/history_page/controller/history_controller.dart';
import '../../pages/history_page/model/history.dart';
import '../../pages/menu_page/model/menu_model.dart';
import '../../utils/themes/buttonstyle_themes.dart';
import '../../utils/themes/textstyle_themes.dart';

class RatingCard extends StatelessWidget {
  final HistoryController controller = Get.find<HistoryController>();
  final RatingController ratingController = Get.put(RatingController());
  final Order order;
  late List<double> ratingsList = []; // Declare ratingsList here

  RatingCard({Key? key, required this.order}) : super(key: key) {
    ratingsList = List<double>.filled(order.menus.length, 0.0); // Initialize ratingsList
  }

  bool checkIfRatingIsGreaterThanZero(List<double> ratingsList) {
    for (double rating in ratingsList) {
      if (rating <= 0) {
        return false; // Return false if any rating is not greater than 0
      }
    }
    return true; // Return true if all ratings are greater than 0
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.6,
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back_ios, size: 20),
                ),
                Text(
                  "Beri Rating",
                  style: boldTextStyle,
                ),
              ],
            ),
            Container(
              height: 300,
              child: _buildRatingWidget(screenWidth, screenHeight),
            ),

            SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  bool isRatingGreaterThanZero = checkIfRatingIsGreaterThanZero(ratingsList);
                  if (isRatingGreaterThanZero) {
                    for (int i = 0; i < ratingsList.length; i++) {
                      double rating = ratingsList[i];
                      ratingController.addRating(i, rating);
                    }
                   Get.back();
                   order.isRatingDone.value = true;
                  } else {
                    Get.snackbar("Pesan", "Anda Harus Mengisi Nilai Semua Menu Terlebih Dahulu",backgroundColor: Colors.white);
                  }
                },
                child: Text("Done", style: whiteboldTextStyle15),
                style: redeembutton(),
              ),
            ),


          ],
        ),
      ),
    );
  }

  Widget _buildRatingWidget(double screenWidth, double screenHeight) {
    return ListView.builder(
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: order.menus.length,
      itemBuilder: (BuildContext context, int index) {
        final menu = order.menus[index];
        return Row(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              width: screenWidth / 4,
              height: screenHeight * 0.12,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Image.asset(menu.imagePath, fit: BoxFit.cover),
              ),
            ),
            Container(
              height: screenHeight * 0.12,
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(menu.name, style: vouchertextStyle),
                  RatingBar(
                    initialRating: 0,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    ratingWidget: RatingWidget(
                      full: Icon(Icons.star_rounded, color: Colors.orange),
                      half: Icon(Icons.star_half_rounded, color: Colors.orange),
                      empty: Icon(Icons.star_border_rounded, color: Colors.orange),
                    ),
                    onRatingUpdate: (rating) {
                      ratingsList[index] = rating;
                      controller.isRating2.value = checkIfRatingIsGreaterThanZero(ratingsList);
                      print('Updated ratings list: $ratingsList');
                    },
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

