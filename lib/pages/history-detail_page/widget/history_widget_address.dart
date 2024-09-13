import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/common/model/address_model.dart';
import 'package:warmindo_user_ui/pages/address_page/controller/address_page_controller.dart';
import 'package:warmindo_user_ui/pages/address_page/widget/map_flutter_widget.dart';
import 'package:warmindo_user_ui/utils/themes/buttonstyle_themes.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
class HistoryWidgetAddress extends StatelessWidget {
  final AddressModel addressModel;
  HistoryWidgetAddress ({Key? key, required this.addressModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 0,
              blurRadius: 2,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nama Alamat : ',
                    style: regularInputTextStyle,
                  ),
                  Text(
                    addressModel.nameAddress ?? '',
                    style: regularInputTextStyle,
                  ),
                ],
              ),
              Text(
                style: regularInputTextStyle,
                addressModel.detailAddress ?? '', maxLines: 5,
                overflow: TextOverflow.ellipsis,)
            ],
          ),
          const SizedBox(height: 10,),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Color.fromARGB(255 ,244, 244, 244),
                borderRadius: BorderRadius.all(Radius.circular(5))
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Catatan Alamat',style: boldTextStyle,),
                  Text(addressModel.catatanAddress ?? '',style: regularInputTextStyle,),
                  // Text(addressModel.catatanAddress ?? '',style: regularInputTextStyle,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
