
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_user_ui/utils/themes/image_themes.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import 'package:warmindo_user_ui/widget/myCustomPopUp/myPopup_controller.dart';
import '../../../common/model/history2_model.dart';
import '../../../utils/themes/buttonstyle_themes.dart';
import '../../../utils/themes/color_themes.dart';
import '../../../widget/appBar.dart';
import '../../history_page/controller/history_controller.dart';


class HistoryDetailPage extends StatelessWidget {
  static const route ='/history-detail-page';
  final HistoryController controller = Get.put(HistoryController());
  final MyCustomPopUpController popUpController = Get.put(MyCustomPopUpController());
  late Rx<Order2> order;
  Color _getLabelColor(String status) {
    switch (status.toLowerCase()) {
      case 'selesai':
        return ColorResources.labelcomplete;
      case 'sedang diproses':
        return ColorResources.labelinprogg;
      case 'menunggu pembayaran':
      case 'menunggu pengembalian dana':
        return Colors.grey;
      case 'menunggu batal':
      case 'batal':
        return ColorResources.labelcancel;
      case 'pesanan siap':
        return ColorResources.labelcomplete;
      default:
        return Colors.black;
    }
  }


  HistoryDetailPage({super.key, required Order2 initialOrder}) {
    order = initialOrder.obs; // Make order reactive
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    int totalPrice = int.parse(order.value.totalprice);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    int totalQuantity = 0;
    for (MenuList menu in order.value.orderDetails) {
      totalQuantity += menu.quantity;
    }
    return Obx(() {
      order.value = controller.orders2.firstWhere((element) => element.id == order.value.id,);
      return Scaffold(
        appBar: AppbarCustom(
          title: 'Detail Riwayat', style: headerRegularStyle,),
        body: Stack(
          children: [
            RefreshIndicator(
              onRefresh: () async {
                await controller.fetchHistory();
                // order.value = index;
                // print('selesai fetch');
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image.asset(Images.history),
                          ),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(10)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  offset: const Offset(1, 1),
                                  blurRadius: 7.0,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(() {
                                  String orderStatus = order.value.status.value;
                                  final labelColor = _getLabelColor(
                                      order.value.status.value);
                                  return Center(
                                    child: Text(
                                      orderStatus.split(' ').map((word) =>
                                      word[0].toUpperCase() +
                                          word.substring(1).toLowerCase()).join(
                                          ' '),
                                      style: TextStyle(
                                        fontFamily: GoogleFonts
                                            .oxygen()
                                            .fontFamily,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: labelColor,
                                      ),
                                    ),
                                  );
                                },
                                ),
                                const SizedBox(height: 10,),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text("Rincian Pemesanan",
                                      style: boldTextStyle,),
                                    Text('#${order.value.id}')
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                Text('$totalQuantity Items',
                                  style: boldTextStyle,),
                                const SizedBox(height: 10,),
                                Obx(() {
                                  return Visibility(
                                    visible: order.value.status.value
                                        .toLowerCase() == 'selesai' &&
                                        order.value.orderDetails.any((detail) =>
                                        detail.ratings.value != 0.0) == false,
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Text("Rating", style: boldTextStyle,),
                                          const SizedBox(height: 10,),
                                          GestureDetector(
                                            onTap: () {
                                              controller
                                                  .showCustomModalForRating(
                                                  order.value, context);
                                            },
                                            child: const Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,
                                              children: [
                                                Icon(Icons.star_border_rounded,
                                                  size: 50,),
                                                Icon(Icons.star_border_rounded,
                                                    size: 50),
                                                Icon(Icons.star_border_rounded,
                                                    size: 50),
                                                Icon(Icons.star_border_rounded,
                                                    size: 50),
                                                Icon(Icons.star_border_rounded,
                                                    size: 50)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                                const SizedBox(height: 20,),
                                ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: order.value.orderDetails.length,
                                  separatorBuilder: (BuildContext context,
                                      int index) => const SizedBox(height: 20),
                                  itemBuilder: (context, index) {
                                    int toppingTotalPrice = 0;

                                    if (order.value.orderDetails[index]
                                        .toppings != null) {
                                      for (var topping in order.value
                                          .orderDetails[index].toppings!) {
                                        toppingTotalPrice +=
                                            topping.priceTopping;
                                      }
                                    }
                                    return Row(
                                      children: [
                                        SizedBox(
                                          width: screenWidth / 4,
                                          height: screenHeight * 0.11,
                                          child: ClipRRect(
                                            borderRadius: const BorderRadius
                                                .all(Radius.circular(10)),
                                            child: Image.network(
                                              order.value.orderDetails[index]
                                                  .image, fit: BoxFit.cover,),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        SizedBox(
                                          width: screenWidth * 0.51,
                                          height: screenHeight * 0.11,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Flexible(child: Text(
                                                        order.value
                                                            .orderDetails[index]
                                                            .nameMenu,
                                                        style: boldTextStyle,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,)),
                                                      Text('${order.value
                                                          .orderDetails[index]
                                                          .quantity}x',
                                                        style: boldTextStyle,),
                                                    ],
                                                  ),
                                                  Visibility(
                                                    visible: order.value.orderDetails[index].variantId != null,
                                                    child: Builder(
                                                      builder: (context) {
                                                        final varian = popUpController.varianList.firstWhereOrNull((element) => element.varianID ==
                                                            order.value
                                                                .orderDetails[index]
                                                                .variantId);
                                                        return Text(varian
                                                            ?.nameVarian ??
                                                            "Unknown");
                                                      },
                                                    ),),
                                                  Visibility(
                                                    visible: order.value
                                                        .orderDetails[index]
                                                        .toppings!.isNotEmpty,
                                                    child: SizedBox(
                                                      height: 24,
                                                      child: ListView(
                                                          scrollDirection: Axis
                                                              .horizontal,
                                                          children: [
                                                            Text(
                                                              order.value
                                                                  .orderDetails[index]
                                                                  .toppings!
                                                                  .map((
                                                                  topping) =>
                                                              topping
                                                                  .nameTopping)
                                                                  .join(', '),
                                                              overflow: TextOverflow
                                                                  .ellipsis,
                                                              style: const TextStyle(
                                                                  fontSize: 14),
                                                            ),
                                                          ]
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Text(
                                                    currencyFormat.format(order
                                                        .value
                                                        .orderDetails[index]
                                                        .price +
                                                        toppingTotalPrice),
                                                    style: boldTextStyle,),
                                                  Obx(() =>
                                                      Visibility(
                                                          visible: order.value
                                                              .orderDetails[index]
                                                              .ratings?.value !=
                                                              0.0,
                                                          child: Wrap(
                                                            crossAxisAlignment: WrapCrossAlignment
                                                                .center,
                                                            children: [
                                                              const Icon(Icons
                                                                  .star_rounded,
                                                                  color: Colors
                                                                      .orange,
                                                                  size: 23),
                                                              Text(order.value
                                                                  .orderDetails[index]
                                                                  .ratings
                                                                  .toString(),
                                                                  style: descriptionratingTextStyle),
                                                            ],
                                                          )),),
                                                  //   Visibility(
                                                  //     visible: order.orderDetails[index].ratings != null ,
                                                  //     child: Wrap(
                                                  //       crossAxisAlignment: WrapCrossAlignment.center,
                                                  //       children: [
                                                  //         Icon(Icons.star_rounded,
                                                  //             color: Colors.orange, size: 23),
                                                  //         Text(order.orderDetails[index].ratings.toString(),
                                                  //             style: descriptionratingTextStyle),
                                                  //       ],
                                                  //     ),),
                                                ],
                                              ),
                                              // Text(currencyFormat.format(totalPrice),style: boldTextStyle,)
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                const SizedBox(height: 10,),
                                Text(
                                  "Detail Pembayaran", style: boldTextStyle,),
                                const SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text("Total", style: boldTextStyle,),
                                    Text(currencyFormat.format(totalPrice),
                                      style: boldTextStyle,),
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text("Metode Pemesanan",
                                      style: boldTextStyle,),
                                    Text(order.value.orderMethod!.toLowerCase()
                                        .substring(0, 1)
                                        .toUpperCase() +
                                        order.value.orderMethod!
                                            .toLowerCase()
                                            .substring(1) ?? '-',
                                      style: boldTextStyle,),
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text("Metode Pembayaran",
                                      style: boldTextStyle,),
                                    Text(order.value.paymentMethod == 'tunai'
                                        ? order.value.paymentMethod!
                                        .toLowerCase()
                                        .substring(0, 1)
                                        .toUpperCase() +
                                        order.value.paymentMethod!
                                            .toLowerCase()
                                            .substring(1) ?? '-'
                                        : order.value.paymentMethod
                                        ?.toUpperCase() ?? '-',
                                      style: boldTextStyle,),
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                Obx(() =>
                                    Visibility(
                                      visible: order.value.status ==
                                          'menunggu batal' ||
                                          order.value.status == 'batal' ,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text('Metode Pembatalan : ',
                                            style: boldTextStyle,),
                                          Text(order.value.cancelMethod == 'tunai'
                                                ? 'Tunai'
                                                : '${order.value.cancelMethod} ' ,
                                            maxLines: 5,
                                            overflow: TextOverflow.ellipsis,)
                                        ],
                                      ),
                                    )),
                                const SizedBox(height: 10,),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('Catatan : ', style: boldTextStyle,),
                                    Expanded(child: Text(
                                      order.value.catatan, maxLines: 5,
                                      overflow: TextOverflow.ellipsis,))
                                  ],
                                ),
                                const SizedBox(height: 20,),
                                Obx(() =>
                                    Visibility(
                                      visible: order.value.alasan_batal != '',
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: [
                                          Text('Alasan Batal : ',
                                            style: boldTextStyle,),
                                          Expanded(child: Text(
                                            '${order.value.alasan_batal}',
                                            maxLines: 5,
                                            overflow: TextOverflow.ellipsis,))
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Obx(() =>
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.onButtonPressed(
                                    order.value, context);
                              },
                              style: dynamicButtonStyle(
                                  order.value.status.value,order.value.noRekening!.value),
                              child: controller.isLoadingButton.value ?
                              const Center(
                                child: SizedBox(
                                  width: 20,
                                  // Adjust the width to your preference
                                  height: 20,
                                  // Adjust the height to your preference
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3, // Adjust the stroke width if needed
                                  ),
                                ),
                              )
                                  : Text(controller.getButtonText(order.value),
                                style: whiteboldTextStyle15,),),
                          ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.black,),
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
          ],
        ),
      );
    });
  }
}

