import '../models/appointment_model.dart';
import '../models/usermodel.dart';

class AppointmentsService {
  static List<AppointmentModel> _mockAppointments = [];

  static Future<List<AppointmentModel>> getAppointments({
    String? userId,
    UserRole? role,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    if (role == UserRole.doctor) {
      return [
        AppointmentModel(
          id: '1',
          patientId: 'p1',
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
          patientId: 'p2',
          patientName: 'Yacine',
          doctorId: userId ?? '',
          doctorName: 'Dr. Smith',
          specialty: 'Cardiology',
          date: 'Wed. 10 Jan. 2025',
          time: '10:30',
          status: AppointmentStatus.pending,
        ),
        ..._mockAppointments.where((a) => a.doctorId == userId),
      ];
    }

    return [
      AppointmentModel(
        id: '1',
        patientId: userId ?? '',
        patientName: 'John',
        doctorId: 'd1',
        doctorName: 'Dr. Stone Gaze',
        specialty: 'ENT',
        date: 'Wed. 10 Dec. 2025',
        time: '11:00',
        status: AppointmentStatus.confirmed,
        hasImage: true,
      ),
      ..._mockAppointments.where((a) => a.patientId == userId),
    ];
  }

  static Future<Map<String, dynamic>> createAppointment({
    required String patientId,
    required String doctorId,
    required String date,
    required String time,
    String? notes,
  }) async {
    await Future.delayed(const Duration(seconds: 2));

    final appointment = AppointmentModel(
      id: 'apt_${DateTime.now().millisecondsSinceEpoch}',
      patientId: patientId,
      patientName: 'Patient Name',
      doctorId: doctorId,
      doctorName: 'Doctor Name',
      specialty: 'General',
      date: date,
      time: time,
      status: AppointmentStatus.pending,
      notes: notes,
    );

    _mockAppointments.add(appointment);

    return {'success': true, 'appointment': appointment};
  }

  static Future<bool> updateAppointmentStatus({
    required String appointmentId,
    required AppointmentStatus status,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}
