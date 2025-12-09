import 'package:flutter/material.dart';
import 'package:mcp_full_front/screens/auth/login_screen.dart';
import 'package:mcp_full_front/screens/auth/signup_screen.dart';
import 'package:mcp_full_front/screens/doctor/doctor_home_page.dart';
import 'package:mcp_full_front/screens/patient/patient_home_page.dart';

void main() {
  runApp(const MedicalAppointmentApp());
}

class MedicalAppointmentApp extends StatelessWidget {
  const MedicalAppointmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medical Appointment',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Inter'),
      // Start with login screen
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
