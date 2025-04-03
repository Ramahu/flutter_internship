class UserModel {

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.address,
    this.serialNumber,
    this.image,
    this.parentId,
    this.role,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['data']['id'],
      name: json['data']['name'],
      email: json['data']['email'],
      phone: json['data']['phone'],
      address: json['data']['address'],
      serialNumber: json['data']['serial_number'],
      image: json['data']['image'],
      parentId: json['data']['parent_id'],
      role: json['data']['role'],
      token: json['token'],
    );
  }
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String? address;
  final String? serialNumber;
  final String? image;
  final int? parentId;
  final String? role;
  final String token;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'serial_number': serialNumber,
      'image': image,
      'parent_id': parentId,
      'role': role,
      'token': token,
    };
  }
}
