
import 'package:mcp_flutter_frontend_prototype/models/usermodel.dart';

class AuthService {
  static UserModel? _currentUser;
  static UserModel? get currentUser => _currentUser;

  static Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
    required String name,
    required UserRole role,
    String? specialization,
    String? phoneNumber,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    if (email.isEmpty || password.isEmpty) {
      return {'success': false, 'message': 'Fill all fields'};
    }
    return {
      'success': true,
      'message': role == UserRole.doctor
          ? 'Account created! Waiting for admin approval'
          : 'Account created successfully!',
    };
  }

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 2));

    if (email == 'doctor@test.com' && password == 'password') {
      _currentUser = UserModel(
        id: 'doc_123',
        email: email,
        name: 'Dr. Smith',
        role: UserRole.doctor,
        isApproved: true,
        specialization: 'Cardiology',
        createdAt: DateTime.now(),
      );
      return {'success': true, 'user': _currentUser};
    } else if (email == 'patient@test.com' && password == 'password') {
      _currentUser = UserModel(
        id: 'pat_123',
        email: email,
        name: 'John Doe',
        role: UserRole.patient,
        isApproved: true,
        createdAt: DateTime.now(),
      );
      return {'success': true, 'user': _currentUser};
    }
    return {'success': false, 'message': 'Invalid credentials'};
  }

  static Future<void> logout() async => _currentUser = null;
}
