import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/map_controller.dart';



class MapScreen extends StatelessWidget {
  final MapController mapController = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async{
        await mapController.openMap();
      },
      child: Ink(
        child: Container(
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 0,
                blurRadius: 2,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Center(
                  child:Icon(Icons.location_pin,color: Colors.black,size: 20,),
            ),
        ),
      ),
    );
  }
}
