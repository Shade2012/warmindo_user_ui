import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/map_controller.dart';



class MapScreen extends StatelessWidget {
  final MapController mapController = Get.put(MapController());

   MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async{
        await mapController.openMap();
      },
      child: Ink(
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 0,
                blurRadius: 2,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: const Center(
                  child:Icon(Icons.location_pin,color: Colors.black,size: 20,),
            ),
        ),
      ),
    );
  }
}
