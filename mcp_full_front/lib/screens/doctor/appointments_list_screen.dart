import 'package:flutter/material.dart';
import 'package:mcp_full_front/models/appointment_model.dart';

class AppointmentsListScreen extends StatelessWidget {
  final DateTime selectedDate;
  const AppointmentsListScreen({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    // TODO: Fetch appointments for selected date from backend
    final appointments = [
      AppointmentModel(
        id: '1',
        patientId: 'p1',
        patientName: 'Mahmoud',
        doctorId: 'd1',
        doctorName: 'Dr. Smith',
        specialty: 'Cardiology',
        date: 'JAN 1-31, 2025',
        time: '11:00',
        status: AppointmentStatus.confirmed,
      ),
      AppointmentModel(
        id: '2',
        patientId: 'p2',
        patientName: 'Ayoub',
        doctorId: 'd1',
        doctorName: 'Dr. Smith',
        specialty: 'Cardiology',
        date: 'JAN 1-31, 2025',
        time: '14:00',
        status: AppointmentStatus.confirmed,
      ),
      AppointmentModel(
        id: '3',
        patientId: 'p3',
        patientName: 'Sofiane',
        doctorId: 'd1',
        doctorName: 'Dr. Smith',
        specialty: 'Cardiology',
        date: 'JAN 1-31, 2025',
        time: '16:00',
        status: AppointmentStatus.confirmed,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Appointments',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${selectedDate.day} ${_getMonthName(selectedDate.month)} ${selectedDate.year}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: appointments.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.event_busy,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No appointments for this day',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: appointments.length,
                      itemBuilder: (context, index) {
                        final apt = appointments[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey[200]!),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundColor: const Color(
                                    0xFF6B5B95,
                                  ).withOpacity(0.1),
                                  child: Text(
                                    apt.patientName[0].toUpperCase(),
                                    style: const TextStyle(
                                      color: Color(0xFF6B5B95),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        apt.patientName,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        apt.time,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        apt.status ==
                                            AppointmentStatus.confirmed
                                        ? Colors.green[50]
                                        : Colors.orange[50],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    apt.status == AppointmentStatus.confirmed
                                        ? 'Confirmed'
                                        : 'Pending',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color:
                                          apt.status ==
                                              AppointmentStatus.confirmed
                                          ? Colors.green[700]
                                          : Colors.orange[700],
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}
