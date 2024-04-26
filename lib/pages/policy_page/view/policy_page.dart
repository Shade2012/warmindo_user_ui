import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import 'package:warmindo_user_ui/widget/unordered_list.dart';

class PolicyPage extends StatelessWidget {
  const PolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () => Get.back(),
          ),
        title: Text(
          'Kebijakan Privasi',
          style: appBarTextStyle,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 22), // Padding on left and right sides
          child: Container(
            width: screenWidth,
            height: screenHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Terakhir diperbarui: 22 Maret 2024',
                  style: normalPolicyTextStyle,
                ),
                SizedBox(height: 20), // Add some space between the texts
                Text(
                  'Kebijakan Privasi ini',
                  style: boldPolicyTextStyle,
                ),
                Text(
                  'menjelaskan kebijakan dan prosedur Kami tentang pengumpulan, penggunaan, dan pengungkapan informasi Anda saat Anda menggunakan Layanan dan memberi tahu Anda tentang hak-hak privasi Anda dan bagaimana hukum melindungi Anda.',
                  style: normalPolicyTextStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Kami menggunakan data Pribadi Anda untuk menyediakan dan meningkatkan Layanan. Dengan menggunakan Layanan, Anda menyetujui pengumpulan dan penggunaan informasi sesuai dengan Kebijakan Privasi ini.',
                  style: normalPolicyTextStyle,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Data Pribadi',
                  style: boldPolicyTextStyle,
                ),
                Text(
                    'Saat menggunakan Layanan Kami, Kami dapat meminta Anda untuk memberikan informasi pengenal pribadi tertentu kepada Kami yang dapat digunakan untuk menghubungi atau mengidentifikasi Anda. Informasi yang dapat diidentifikasi secara pribadi dapat mencakup, tetapi tidak terbatas pada:'),
                SizedBox(
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
    );
  }
}
