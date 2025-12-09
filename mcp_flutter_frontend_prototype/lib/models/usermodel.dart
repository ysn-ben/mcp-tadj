class UserModel {
  final String id, email, name;
  final UserRole role;
  final bool isApproved;
  final String? specialization, phoneNumber;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    this.isApproved = false,
    this.specialization,
    this.phoneNumber,
    required this.createdAt,
  });
}

enum UserRole { patient, doctor, admin }
