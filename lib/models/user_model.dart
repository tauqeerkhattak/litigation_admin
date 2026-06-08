class UserModel {
  final String id;
  String name;
  String email;
  String role;
  String status;
  bool isEnabled;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.role = 'Lawyer',
    this.status = 'Active',
    this.isEnabled = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'status': status,
      'isEnabled': isEnabled ? 1 : 0,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      role: map['role'],
      status: map['status'],
      isEnabled: map['isEnabled'] == 1,
    );
  }
}
