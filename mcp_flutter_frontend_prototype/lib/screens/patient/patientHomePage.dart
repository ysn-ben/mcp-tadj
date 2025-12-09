import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mcp_flutter_frontend_prototype/models/appointment_model.dart';
import 'package:mcp_flutter_frontend_prototype/models/usermodel.dart';
import 'package:mcp_flutter_frontend_prototype/screens/patient/audioBookingScreen.dart';
import 'package:mcp_flutter_frontend_prototype/services/appointmentServices.dart';
import 'package:mcp_flutter_frontend_prototype/services/authServices.dart';
import 'package:mcp_flutter_frontend_prototype/widgets/actionCard.dart';
import 'package:mcp_flutter_frontend_prototype/widgets/covidBanner.dart';
import 'package:mcp_flutter_frontend_prototype/widgets/patientAppointmentCard.dart';

class PatientHomePage extends StatefulWidget {
  const PatientHomePage({super.key});
  @override
  State<PatientHomePage> createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  List<AppointmentModel> appointments = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadAppointments();
  }

  Future<void> _loadAppointments() async {
    setState(() => _loading = true);
    final user = AuthService.currentUser;
    if (user != null) {
      final result = await AppointmentsService.getAppointments(
        userId: user.id,
        role: UserRole.patient,
      );
      setState(() {
        appointments = result;
        _loading = false;
      });
    }
  }

  Future<void> _navigateToBooking(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AudioBookingScreen()),
    );
    if (result != null && result is AppointmentModel) {
      setState(() => appointments.insert(0, result));
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthService.currentUser;
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi ${user?.name ?? 'User'}!',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Text(
              'May you always be in good health',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => _showLogoutDialog(context),
            icon: const Icon(Icons.logout, color: Colors.black87),
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadAppointments,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _buildAppointmentsList(),
                    const SizedBox(height: 24),
                    _buildActionCards(context),
                    const SizedBox(height: 24),
                    _buildCovidBanners(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildAppointmentsList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Appointments',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          if (appointments.isEmpty)
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 48,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'No appointments yet',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Book your first appointment',
                      style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
            )
          else
            ...appointments.map(
              (apt) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: PatientAppointmentCard(appointment: apt),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActionCards(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => _navigateToBooking(context),
              child: ActionCard(
                icon: Icons.calendar_month,
                title: 'Book an\nAppointment',
                subtitle: 'Find a Doctor or\nspecialist',
                backgroundColor: Colors.purple[50]!,
                iconColor: Colors.purple[700]!,
                iconBackgroundColor: Colors.purple[200]!,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ActionCard(
              icon: Icons.qr_code_scanner,
              title: 'Appointment\nwith QR',
              subtitle: 'Queuing without\nthe hustle',
              backgroundColor: Colors.teal[50]!,
              iconColor: Colors.teal[700]!,
              iconBackgroundColor: Colors.teal[200]!,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCovidBanners() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          CovidBanner(
            gradient: LinearGradient(
              colors: [Colors.blue[500]!, Colors.blue[400]!],
            ),
          ),
          const SizedBox(height: 16),
          CovidBanner(
            gradient: LinearGradient(
              colors: [Colors.red[500]!, Colors.red[400]!],
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await AuthService.logout();
              if (!context.mounted) return;
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
