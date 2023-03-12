class UserModel {
  final String id;
  final String name;
  final String phoneNumber;
  final String address;
  final String email;

  const UserModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.email,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? address,
    String? email,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'address': address,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      address: map['address'],
      email: map['email'],
    );
  }
}
