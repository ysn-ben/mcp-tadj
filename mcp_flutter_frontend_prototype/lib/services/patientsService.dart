
import 'package:mcp_flutter_frontend_prototype/models/patientmodel.dart';

class PatientsService {
  static Future<List<PatientModel>> getPatients({String? search}) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final allPatients = [
      PatientModel(id: '1', name: 'Mahmoud', status: 'Active'),
      PatientModel(id: '2', name: 'Ayoub', status: 'Active'),
      PatientModel(id: '3', name: 'Sofiane', status: 'Active'),
      PatientModel(id: '4', name: 'Ahmed', status: 'Active'),
      PatientModel(id: '5', name: 'Yacine', status: 'Active'),
      PatientModel(id: '6', name: 'Eya', status: 'Active'),
      PatientModel(id: '7', name: 'Abderaman', status: 'Active'),
      PatientModel(id: '8', name: 'Sarah', status: 'Active'),
    ];

    if (search != null && search.isNotEmpty) {
      return allPatients
          .where((p) => p.name.toLowerCase().contains(search.toLowerCase()))
          .toList();
    }
    return allPatients;
  }
}
