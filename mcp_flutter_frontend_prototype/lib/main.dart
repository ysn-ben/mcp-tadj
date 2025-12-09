import 'package:flutter/material.dart';
import 'package:mcp_flutter_frontend_prototype/screens/doctor/doctorHomePage.dart';
import 'package:mcp_flutter_frontend_prototype/screens/logInScreen.dart';
import 'package:mcp_flutter_frontend_prototype/screens/patient/patientHomePage.dart';
import 'package:mcp_flutter_frontend_prototype/screens/signUpScreen.dart';

void main() => runApp(const MedicalAppointmentApp());

class MedicalAppointmentApp extends StatelessWidget {
  const MedicalAppointmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medical Appointment',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Inter'),
      home: const LoginScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/patient-home': (context) => const PatientHomePage(),
        '/doctor-home': (context) => const DoctorHomePage(),
      },
    );
  }
}
