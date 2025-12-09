import 'package:flutter/material.dart';
import 'package:mcp_full_front/models/appointment_model.dart';
import 'package:mcp_full_front/models/user_mode..dart';
import 'package:mcp_full_front/services/appointments_service.dart';
import 'package:mcp_full_front/services/auth_service.dart';
import 'package:mcp_full_front/widgets/action_card.dart';
import 'package:mcp_full_front/widgets/appointment_card.dart';
import 'package:mcp_full_front/screens/patient/audio_booking_screen.dart';
import '../../widgets/covid_banner.dart';

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
    //final user = AuthService.currentUser;
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              //  'Hi ${user?.name ?? 'User'}!',
              'HI Yacine,',
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

class CovidBanner extends StatelessWidget {
  final Gradient gradient;
  const CovidBanner({super.key, required this.gradient});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Prevent the spread\nof COVID-19 Virus',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: const [
                  Text(
                    'Find out how',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                ],
              ),
            ],
          ),
          Positioned(
            right: -10,
            bottom: -10,
            child: Icon(
              Icons.coronavirus_outlined,
              size: 80,
              color: Colors.white.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
}
