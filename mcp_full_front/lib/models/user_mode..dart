class UserModel {
  final String id;
  final String email;
  final String name;
  final UserRole role;
  final bool isApproved; // For doctor approval by admin
  final String? specialization; // For doctors
  final String? phoneNumber;
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

  // Convert to JSON for API calls
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role.toString(),
      'isApproved': isApproved,
      'specialization': specialization,
      'phoneNumber': phoneNumber,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Create from JSON response
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      role: UserRole.values.firstWhere(
        (e) => e.toString() == json['role'],
        orElse: () => UserRole.patient,
      ),
      isApproved: json['isApproved'] ?? false,
      specialization: json['specialization'],
      phoneNumber: json['phoneNumber'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

enum UserRole { patient, doctor, admin }
