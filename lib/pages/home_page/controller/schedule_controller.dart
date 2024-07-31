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
  RxBool isopen = false.obs;
  late final tz.Location asiaJakarta;
  late final tz.TZDateTime now;
  late final String hariIni;
  List<ScheduleList> jadwalElement = <ScheduleList>[];
  RxList<ScheduleList> scheduleElement = <ScheduleList>[].obs;


  @override
  void onInit() {
    super.onInit();
    initializeDateFormatting('id_ID', null).then((_) {
      tz.initializeTimeZones();
      asiaJakarta = tz.getLocation('Asia/Jakarta');
      now = tz.TZDateTime.now(asiaJakarta);
      hariIni = DateFormat('EEEE', 'id_ID').format(now);

      // Memanggil fetchSchedule di sini untuk memastikan dijalankan setelah inisialisasi selesai
      fetchSchedule();
    }).catchError((e) {
      print('Error initializing date formatting: $e');
    });
  }

  Future<void> fetchSchedule() async {
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse(GlobalVariables.apiSchedule),
      );

      if (response.statusCode == 200) {
        scheduleElement.value = scheduleListFromJson(response.body);
        final List<ScheduleList> jadwalHariIni = scheduleElement.where((item) => item.days == hariIni).toList();

        if (jadwalHariIni.isNotEmpty) {
          // Filter the scheduleElement list to only include today's schedule
          jadwalElement = jadwalHariIni;
          print('Jadwal hari ini ditemukan. Jumlah jadwal: ${jadwalHariIni}');
        } else {
          print('Tidak ada jadwal untuk hari ini');
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Di catch saat ini: $hariIni');
      print('Exception: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
