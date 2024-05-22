import 'package:flutter/material.dart';

class DetailVoucherPage extends StatelessWidget {
  const DetailVoucherPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Voucher'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selamat datang di keluarga kami!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Dapatkan pengalaman berbelanja yang lebih menyenangkan dengan voucher eksklusif untuk Anda, pengguna baru kami! Gunakan kode voucher "NEWUSER5K" saat checkout dan nikmati potongan harga sebesar Rp 5000 untuk pembelian pertama Anda.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Syarat & Ketentuan:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '1. Hanya berlaku untuk pengguna baru yang baru pertama kali mendaftar dan melakukan pembelian di platform kami.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                '2. Minimal pembelanjaan sebesar Rp 20.000 untuk bisa menggunakan voucher ini.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                '3. Kode voucher hanya berlaku satu kali penggunaan per akun.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                '4. Berlaku untuk semua produk kecuali yang telah dikecualikan.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Jangan lewatkan kesempatan spesial ini! Mulai jelajahi produk kami sekarang juga dan nikmati pengalaman berbelanja yang lebih hemat dan menyenangkan. Terima kasih atas kunjungan Anda dan selamat berbelanja!',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
