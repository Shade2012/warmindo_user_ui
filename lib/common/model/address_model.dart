import 'package:get/get.dart';

class AddressModel {
   int? id;
  final String? nameAddress;
  final String? detailAddress;
  final String? namaKost;
  final String? catatanAddress;
  final double? lagtitude;
  final double? longtitude;
  final DateTime? updatedAt;
  final DateTime? createdAt;
   RxString? selected;
   RxString? statusAlamat;

  AddressModel({
    this.catatanAddress,
    this.id,
    this.nameAddress,
    this.detailAddress,
    this.lagtitude,
    this.longtitude,
    this.namaKost,
    this.selected,
    this.statusAlamat,
    this.updatedAt,
    this.createdAt,

  });
   factory AddressModel.fromJson(Map<String, dynamic> json) {
     return AddressModel(
       id: json['id'],
       nameAddress: json['nama_alamat'],
       namaKost: json['nama_kost'],
       catatanAddress: json['catatan_alamat'],
       detailAddress: json['detail_alamat'],
       selected: json['is_selected'] != null ? (json['is_selected'] as String).obs : ''.obs, // Handle potential null
       statusAlamat: json['status_alamat'] != null ? (json['status_alamat'] as String).obs : '0'.obs, // Handle potential null
       lagtitude: double.tryParse(json['latitude'] ?? '0.0'), // Handle potential null
       longtitude: double.tryParse(json['longitude'] ?? '0.0'), // Handle potential null
     );
   }



   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_alamat': nameAddress,
      'nama_kost': namaKost,
      'catatan_alamat': catatanAddress,
      'detail_alamat': detailAddress,
      'is_selected': selected,
      'latitude': lagtitude,
      'longitude': longtitude,
    };
  }
  @override
  String toString() {
    return 'Address{id: $id, lagtitude: $lagtitude, longtitude: $longtitude name_address: $nameAddress, detail_address: $detailAddress, kost: $namaKost, catatan_address: $catatanAddress, selected: $selected update_at: $updatedAt, created_at: $createdAt}';
  }
}

