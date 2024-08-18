import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:warmindo_user_ui/common/model/schedule_model.dart';
import 'package:http/http.dart' as http;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../../common/global_variables.dart';

class ScheduleController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isOpen = false.obs;
  tz.Location? asiaJakarta; // Make asiaJakarta nullable
  late String hariIni;
  RxList<ScheduleList> jadwalElement = <ScheduleList>[].obs;
  RxList<ScheduleList> scheduleElement = <ScheduleList>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await _initializeSchedule();
  }

  Future<void> _initializeSchedule() async {
    try {
      await initializeDateFormatting('id_ID', null);
      tz.initializeTimeZones();
      asiaJakarta = tz.getLocation('Asia/Jakarta'); // Initialize asiaJakarta
      await fetchSchedule(); // Call fetchSchedule only after initialization
    } catch (e) {
      print('Error initializing schedule: $e');
    }
  }

  Future<void> fetchSchedule() async {
    isLoading.value = true;

    if (asiaJakarta == null) {
      print('asiaJakarta is not initialized.');
      isLoading.value = false;
      return; // Stop execution if asiaJakarta is not initialized
    }

    final now = tz.TZDateTime.now(asiaJakarta!); // Use the non-null value
    hariIni = DateFormat('EEEE', 'id_ID').format(now);
    print('hariIni updated to: $hariIni');

    try {
      final response = await http.get(
        Uri.parse(GlobalVariables.apiSchedule),
      );
      if (response.statusCode == 200) {
        scheduleElement.value = scheduleListFromJson(response.body);
        final List<ScheduleList> jadwalHariIni = scheduleElement.where((item) => item.days == hariIni).toList();
        if (jadwalHariIni.isNotEmpty) {
          jadwalElement.value = jadwalHariIni;
        } else {
          print('Tidak ada jadwal untuk hari ini');
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    } finally {
      isLoading.value = false;
    }
  }
}


