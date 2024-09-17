

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/widget/myRatingPopUp/rating_controller.dart';

import '../../common/model/history2_model.dart';
import '../../pages/history_page/controller/history_controller.dart';


import '../../utils/themes/buttonstyle_themes.dart';
import '../../utils/themes/textstyle_themes.dart';

class RatingCard extends StatelessWidget {
  final HistoryController controller = Get.find<HistoryController>();
  final RatingController ratingController = Get.put(RatingController());
  final Order2 order;
  late List<double> ratingsList = []; // Declare ratingsList here

  RatingCard({super.key, required this.order}) {
    ratingsList = List<double>.filled(order.orderDetails.length, 0.0); // Initialize ratingsList
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
      decoration: const BoxDecoration(
          color: Colors.white,
        borderRadius:  BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
      ),
      height: screenHeight * 0.6,
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.back(closeOverlays: true);
                  },
                  icon: const Icon(Icons.arrow_back_ios, size: 20),
                ),
                Text(
                  "Beri Rating",
                  style: boldTextStyle,
                ),
              ],
            ),
            SizedBox(
              height: 300,
              child: _buildRatingWidget(screenWidth, screenHeight),
            ),

            const SizedBox(height: 20),
            InkWell(
              onTap: () async {
    bool isRatingGreaterThanZero = checkIfRatingIsGreaterThanZero(ratingsList);
    if (isRatingGreaterThanZero) {
    for (int i = 0; i < ratingsList.length; i++) {
    double rating = ratingsList[i];

    // Extract menuId and orderDetailID from the orderDetails
    int menuId = order.orderDetails[i].menuId;
    int orderDetailID = order.orderDetails[i].orderDetailId;
    // Call the addRating method with the appropriate parameters
    await ratingController.addRating(menuId, rating, orderDetailID,order);
    controller.orders2.refresh();
    }
    Get.back(closeOverlays: true);
    order.isRatingDone.value = true;
    } else {
      if(Get.isSnackbarOpen != true) {
        Get.snackbar(
            "Pesan", "Anda Harus Mengisi Nilai Semua Menu Terlebih Dahulu",
            backgroundColor: Colors.white);
      }
    }
    },
              child: Obx(()=>
                  Container(
                    height: 40,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: ratingController.isLoadingButton.value
                        ? const Center(
                      child: SizedBox(
                        width: 20, // Adjust the width to your preference
                        height: 20, // Adjust the height to your preference
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3, // Adjust the stroke width if needed
                        ),
                      ),
                    ):Center(
                      child: Text("Selesai", style: categoryMenuTextStyle, textAlign: TextAlign.center,
                      ),
                    ),
                  ),
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
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: order.orderDetails.length,
      itemBuilder: (BuildContext context, int index) {
        final menu = order.orderDetails[index];
        return Row(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: screenWidth / 4,
              height: screenHeight * 0.12,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.network(menu.image, fit: BoxFit.cover),
              ),
            ),
            Container(
              height: screenHeight * 0.12,
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(menu.nameMenu, style: vouchertextStyle),
                  Visibility(
                    visible: menu.selectedVarian?.nameVarian != null,
                    child: Text(menu.selectedVarian?.nameVarian ?? "-"),
                  ),
                  Visibility(
                    visible: menu.toppings!.isNotEmpty,
                    child: Container(
                    width: screenWidth * 0.6,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text.rich(
                          TextSpan(
                            children: List.generate( menu.toppings!.length, (index) {
                              final topping =  menu.toppings![index];
                              final isLast = index ==  menu.toppings!.length - 1;
                              return TextSpan(
                                text: isLast ? topping.nameTopping : '${topping.nameTopping} + ',
                                style: const TextStyle(overflow: TextOverflow.ellipsis),
                              );
                            }),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  RatingBar(
                    initialRating: 0,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    ratingWidget: RatingWidget(
                      full: const Icon(Icons.star_rounded, color: Colors.orange),
                      half: const Icon(Icons.star_half_rounded, color: Colors.orange),
                      empty:const Icon(Icons.star_border_rounded, color: Colors.orange),
                    ),
                    onRatingUpdate: (rating) {
                      ratingsList[index] = rating;
                      controller.isRating2.value = checkIfRatingIsGreaterThanZero(ratingsList);
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

