import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mcp_full_front/models/user_mode..dart';

class AuthService {
  static UserModel? _currentUser;

  static UserModel? get currentUser => _currentUser;
  static bool get isLoggedIn => _currentUser != null;
  static UserRole? get userRole => _currentUser?.role;

  static get SharedPreferences => null;

  // ==========================================================================
  // BACKEND INTEGRATION - STEP 1: Sign Up
  // ==========================================================================
  static Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
    required String name,
    required UserRole role,
    String? specialization, // Required for doctors
    String? phoneNumber,
  }) async {
    try {
      // TODO: BACKEND INTEGRATION
      // Replace with your actual API endpoint

      final response = await http.post(
        Uri.parse('YOUR_API_URL/api/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'name': name,
          'role': role.toString(),
          'specialization': specialization,
          'phoneNumber': phoneNumber,
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'message': 'Account created successfully',
          'data': data,
        };
      } else {
        final error = jsonDecode(response.body);
        return {
          'success': false,
          'message': error['message'] ?? 'Sign up failed',
        };
      }

      // MOCK IMPLEMENTATION - Remove this in production
      await Future.delayed(const Duration(seconds: 2));

      if (email.isEmpty || password.isEmpty || name.isEmpty) {
        return {'success': false, 'message': 'Please fill all fields'};
      }

      // Simulate successful registration
      final userId = 'user_${DateTime.now().millisecondsSinceEpoch}';

      return {
        'success': true,
        'message': role == UserRole.doctor
            ? 'Account created! Waiting for admin approval.'
            : 'Account created successfully!',
        'data': {
          'id': userId,
          'email': email,
          'name': name,
          'role': role.toString(),
          'isApproved': role == UserRole.patient, // Patients auto-approved
        },
      };
    } catch (e) {
      return {'success': false, 'message': 'Error: ${e.toString()}'};
    }
  }

  // ==========================================================================
  // BACKEND INTEGRATION - STEP 2: Login
  // ==========================================================================
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      // TODO: BACKEND INTEGRATION

      final response = await http.post(
        Uri.parse('YOUR_API_URL/api/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Store token securely
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', data['token']);

        // Create user from response
        _currentUser = UserModel.fromJson(data['user']);

        return {'success': true, 'user': _currentUser};
      } else {
        return {'success': false, 'message': 'Invalid credentials'};
      }

      // MOCK IMPLEMENTATION - Remove this in production
      await Future.delayed(const Duration(seconds: 2));

      // Simulate different user types
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
      } else if (email == 'pending@test.com' && password == 'password') {
        return {
          'success': false,
          'message': 'Your account is pending admin approval',
        };
      } else {
        return {'success': false, 'message': 'Invalid email or password'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: ${e.toString()}'};
    }
  }

  // ==========================================================================
  // BACKEND INTEGRATION - STEP 3: Logout
  // ==========================================================================
  static Future<void> logout() async {
    // TODO: BACKEND INTEGRATION

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');

    // Optional: Call logout endpoint
    await http.post(
      Uri.parse('YOUR_API_URL/api/auth/logout'),
      headers: {'Authorization': 'Bearer ${prefs.getString('auth_token')}'},
    );

    _currentUser = null;
  }

  // ==========================================================================
  // BACKEND INTEGRATION - STEP 4: Check Auth Status
  // ==========================================================================
  static Future<bool> checkAuthStatus() async {
    // TODO: BACKEND INTEGRATION

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) return false;

    try {
      final response = await http.get(
        Uri.parse('YOUR_API_URL/api/auth/me'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _currentUser = UserModel.fromJson(data);
        return true;
      }
    } catch (e) {
      return false;
    }

    return _currentUser != null;
  }
}
