class PatientModel {
  final String id;
  final String name;
  final String status;
  final String? lastVisit;
  final String? nextAppointment;
  final String? email;
  final String? phone;

  PatientModel({
    required this.id,
    required this.name,
    required this.status,
    this.lastVisit,
    this.nextAppointment,
    this.email,
    this.phone,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'status': status,
    'lastVisit': lastVisit,
    'nextAppointment': nextAppointment,
    'email': email,
    'phone': phone,
  };

  factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
    id: json['id'],
    name: json['name'],
    status: json['status'],
    lastVisit: json['lastVisit'],
    nextAppointment: json['nextAppointment'],
    email: json['email'],
    phone: json['phone'],
  );
}
