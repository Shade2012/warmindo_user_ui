import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MapController extends GetxController {
  Future<void> openMap() async {
    final uriString = Uri.parse('https://www.google.com/maps/place/WARMINDO+Anggrek+Muria/@-6.7525374,110.8415385,18z/data=!3m1!4b1!4m6!3m5!1s0x2e70db3502ccada7:0xb9e4c00fec07306b!8m2!3d-6.7525374!4d110.842826!16s%2Fg%2F11kt8s9vk4?hl=id&entry=ttu&g_ep=EgoyMDI0MDkwNC4wIKXMDSoASAFQAw%3D%3D');

launchUrl(uriString,mode: LaunchMode.externalApplication);
  }
}
