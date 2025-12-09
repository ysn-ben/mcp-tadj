import 'package:mcp_full_front/models/appointment_model.dart';
import 'package:mcp_full_front/models/user_mode..dart';

class AppointmentsService {
  // ==========================================================================
  // BACKEND INTEGRATION - STEP 5: Fetch Appointments
  // ==========================================================================
  static Future<List<AppointmentModel>> getAppointments({
    String? userId,
    UserRole? role,
  }) async {
    try {
      // TODO: BACKEND INTEGRATION
      /*
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      
      final response = await http.get(
        Uri.parse('YOUR_API_URL/api/appointments?userId=$userId&role=$role'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => AppointmentModel.fromJson(json)).toList();
      }
      */

      // MOCK DATA - Remove in production
      await Future.delayed(const Duration(seconds: 1));

      if (role == UserRole.doctor) {
        return [
          AppointmentModel(
            id: '1',
            patientId: 'pat_1',
            patientName: 'Ahmed',
            doctorId: userId ?? '',
            doctorName: 'Dr. Smith',
            specialty: 'Cardiology',
            date: 'Wed. 10 Jan. 2025',
            time: '09:30',
            status: AppointmentStatus.confirmed,
          ),
          AppointmentModel(
            id: '2',
            patientId: 'pat_2',
            patientName: 'Yacine',
            doctorId: userId ?? '',
            doctorName: 'Dr. Smith',
            specialty: 'Cardiology',
            date: 'Wed. 10 Jan. 2025',
            time: '10:30',
            status: AppointmentStatus.confirmed,
          ),
        ];
      } else {
        return [
          AppointmentModel(
            id: '1',
            patientId: userId ?? '',
            patientName: 'John Doe',
            doctorId: 'doc_1',
            doctorName: 'Dr. Stone Gaze',
            specialty: 'Ear, Nose & Throat specialist',
            date: 'Wed. 10 Dec. 2025',
            time: 'Morning set: 11:00',
            status: AppointmentStatus.confirmed,
            hasImage: true,
          ),
        ];
      }
    } catch (e) {
      return [];
    }
  }

  // ==========================================================================
  // BACKEND INTEGRATION - STEP 6: Create Appointment
  // ==========================================================================
  static Future<Map<String, dynamic>> createAppointment({
    required String patientId,
    required String doctorId,
    required String date,
    required String time,
    String? notes,
  }) async {
    try {
      // TODO: BACKEND INTEGRATION
      /*
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      
      final response = await http.post(
        Uri.parse('YOUR_API_URL/api/appointments'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'patientId': patientId,
          'doctorId': doctorId,
          'date': date,
          'time': time,
          'notes': notes,
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return {'success': true, 'appointment': AppointmentModel.fromJson(data)};
      }
      */

      // MOCK IMPLEMENTATION
      await Future.delayed(const Duration(seconds: 2));
      return {
        'success': true,
        'appointment': AppointmentModel(
          id: 'apt_${DateTime.now().millisecondsSinceEpoch}',
          patientId: patientId,
          patientName: 'Patient Name',
          doctorId: doctorId,
          doctorName: 'Doctor Name',
          specialty: 'Specialty',
          date: date,
          time: time,
          status: AppointmentStatus.pending,
          notes: notes,
        ),
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // ==========================================================================
  // BACKEND INTEGRATION - STEP 7: Update Appointment Status
  // ==========================================================================
  static Future<bool> updateAppointmentStatus({
    required String appointmentId,
    required AppointmentStatus status,
  }) async {
    try {
      // TODO: BACKEND INTEGRATION
      /*
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      
      final response = await http.patch(
        Uri.parse('YOUR_API_URL/api/appointments/$appointmentId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'status': status.toString()}),
      );

      return response.statusCode == 200;
      */

      // MOCK IMPLEMENTATION
      await Future.delayed(const Duration(seconds: 1));
      return true;
    } catch (e) {
      return false;
    }
  }
}
