import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import 'package:warmindo_user_ui/widget/unordered_list.dart';

class PolicyPage extends StatelessWidget {
  const PolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Get.back(),
          ),
        title: Text(
          'Kebijakan Privasi',
          style: appBarTextStyle,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 22), // Padding on left and right sides
            child: SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Terakhir diperbarui: 22 Maret 2024',
                    style: normalPolicyTextStyle,
                  ),
                  const SizedBox(height: 20), // Add some space between the texts
                  Text(
                    'Kebijakan Privasi ini',
                    style: boldPolicyTextStyle,
                  ),
                  Text(
                    'menjelaskan kebijakan dan prosedur Kami tentang pengumpulan, penggunaan, dan pengungkapan informasi Anda saat Anda menggunakan Layanan dan memberi tahu Anda tentang hak-hak privasi Anda dan bagaimana hukum melindungi Anda.',
                    style: normalPolicyTextStyle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Kami menggunakan data Pribadi Anda untuk menyediakan dan meningkatkan Layanan. Dengan menggunakan Layanan, Anda menyetujui pengumpulan dan penggunaan informasi sesuai dengan Kebijakan Privasi ini.',
                    style: normalPolicyTextStyle,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Data Pribadi',
                    style: boldPolicyTextStyle,
                  ),
                  const Text(
                      'Saat menggunakan Layanan Kami, Kami dapat meminta Anda untuk memberikan informasi pengenal pribadi tertentu kepada Kami yang dapat digunakan untuk menghubungi atau mengidentifikasi Anda. Informasi yang dapat diidentifikasi secara pribadi dapat mencakup, tetapi tidak terbatas pada:'),
                  const SizedBox(
                    height: 5 ,
                  ),
                  UnorderedList([
                    "Alamat email",
                    "Nama Lengkap",
                    "Nomor telepon",
                    "Alamat",
                    "Data Penggunaan"
                  ])
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
