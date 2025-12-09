// ============================================================================
// PATIENTS SERVICE (For Doctors)
// ============================================================================

import 'package:mcp_full_front/models/patient_model.dart';

class PatientsService {
  // ==========================================================================
  // BACKEND INTEGRATION - STEP 8: Get Patients List
  // ==========================================================================
  static Future<List<PatientModel>> getPatients({String? searchQuery}) async {
    try {
      // TODO: BACKEND INTEGRATION
      /*
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      
      String url = 'YOUR_API_URL/api/patients';
      if (searchQuery != null && searchQuery.isNotEmpty) {
        url += '?search=$searchQuery';
      }
      
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => PatientModel.fromJson(json)).toList();
      }
      */

      // MOCK DATA
      await Future.delayed(const Duration(milliseconds: 500));

      final allPatients = [
        PatientModel(id: '1', name: 'Mahmoud', status: 'Active Patient'),
        PatientModel(id: '2', name: 'Ayoub', status: 'Active Patient'),
        PatientModel(id: '3', name: 'Sofiane', status: 'Active Patient'),
        PatientModel(id: '4', name: 'Ahmed', status: 'Active Patient'),
        PatientModel(id: '5', name: 'Yacine', status: 'Active Patient'),
        PatientModel(id: '6', name: 'Eya', status: 'Active Patient'),
        PatientModel(id: '7', name: 'Abderaman', status: 'Active Patient'),
        PatientModel(id: '8', name: 'Sarah', status: 'Active Patient'),
      ];

      if (searchQuery != null && searchQuery.isNotEmpty) {
        return allPatients
            .where(
              (p) => p.name.toLowerCase().contains(searchQuery.toLowerCase()),
            )
            .toList();
      }

      return allPatients;
    } catch (e) {
      return [];
    }
  }
}
