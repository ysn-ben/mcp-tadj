enum AppointmentStatus { pending, confirmed, completed, cancelled }

class AppointmentModel {
  final String id;
  final String patientId;
  final String patientName;
  final String doctorId;
  final String doctorName;
  final String specialty;
  final String date;
  final String time;
  final AppointmentStatus status;
  final String? notes;
  final bool hasImage;
  final String? imageUrl;

  AppointmentModel({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.doctorId,
    required this.doctorName,
    required this.specialty,
    required this.date,
    required this.time,
    required this.status,
    this.notes,
    this.hasImage = false,
    this.imageUrl,
  });

  // Helper getters
  String get displayTime => time;
  String get displayDate => date;

  // Convert to JSON (for API calls)
  Map<String, dynamic> toJson() => {
    'id': id,
    'patientId': patientId,
    'patientName': patientName,
    'doctorId': doctorId,
    'doctorName': doctorName,
    'specialty': specialty,
    'date': date,
    'time': time,
    'status': status.toString(),
    'notes': notes,
    'hasImage': hasImage,
    'imageUrl': imageUrl,
  };

  // Create from JSON (for API responses)
  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      AppointmentModel(
        id: json['id'],
        patientId: json['patientId'],
        patientName: json['patientName'],
        doctorId: json['doctorId'],
        doctorName: json['doctorName'],
        specialty: json['specialty'],
        date: json['date'],
        time: json['time'],
        status: AppointmentStatus.values.firstWhere(
          (e) => e.toString() == json['status'],
          orElse: () => AppointmentStatus.pending,
        ),
        notes: json['notes'],
        hasImage: json['hasImage'] ?? false,
        imageUrl: json['imageUrl'],
      );
}
