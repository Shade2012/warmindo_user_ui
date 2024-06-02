class User {
  final int? id;
  final String? profile_picture;
  final String? name;
  final String? username;
  final String? phoneNumber;
  final String? email;
  final bool? userVerified;
  final String? role;
  final DateTime? phoneVerifiedAt;
  final DateTime? emailVerifiedAt;
  final DateTime? updatedAt;
  final DateTime? createdAt;

  User( {
     this.id,
     this.name,
     this.username,
     this.phoneNumber,
     this.email,
     this.userVerified,
     this.role,
    this.phoneVerifiedAt,
    this.emailVerifiedAt,
    this.profile_picture,
     this.updatedAt,
     this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      profile_picture: json['profile_picture'],
      id: json['id'],
      name: json['name'],
      username: json['username'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      userVerified: json['user_verified'],
      role: json['role'],
      phoneVerifiedAt: json['phone_verified_at'] != null
          ? DateTime.parse(json['phone_verified_at'])
          : null,
      emailVerifiedAt: json['email_verified_at'] != null
          ? DateTime.parse(json['email_verified_at'])
          : null,
      updatedAt: DateTime.parse(json['updated_at']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profile_picture' : profile_picture,
      'id': id,
      'name': name,
      'username': username,
      'phone_number': phoneNumber,
      'email': email,
      'user_verified': userVerified,
      'role': role,
      'phone_verified_at': phoneVerifiedAt?.toIso8601String(),
      'email_verified_at': emailVerifiedAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
