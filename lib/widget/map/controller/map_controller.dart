import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MapController extends GetxController {
  Future<void> openMap() async {
    final uriString = Uri.parse('https://www.google.com/maps/search/?api=1&query=-6.7526224,110.842861');
launchUrl(uriString,mode: LaunchMode.externalApplication);
  }
}
