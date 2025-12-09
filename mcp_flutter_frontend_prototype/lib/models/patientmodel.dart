class PatientModel {
  final String id, name, status;
  final String? lastVisit, nextAppointment, email, phone;

  PatientModel({
    required this.id,
    required this.name,
    required this.status,
    this.lastVisit,
    this.nextAppointment,
    this.email,
    this.phone,
  });
}
