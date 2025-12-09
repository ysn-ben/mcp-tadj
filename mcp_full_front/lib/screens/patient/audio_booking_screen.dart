import 'package:flutter/material.dart';
import 'package:mcp_full_front/models/appointment_model.dart';
import 'package:mcp_full_front/screens/patient/appointment_success_screen.dart';
import 'package:mcp_full_front/screens/patient/message_booking_screen.dart';
import 'package:mcp_full_front/services/auth_service.dart';

class AudioBookingScreen extends StatefulWidget {
  const AudioBookingScreen({super.key});

  @override
  State<AudioBookingScreen> createState() => _AudioBookingScreenState();
}

class _AudioBookingScreenState extends State<AudioBookingScreen>
    with SingleTickerProviderStateMixin {
  bool isRecording = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // TODO: BACKEND INTEGRATION - Voice Recognition
  // Integrate with your speech-to-text service
  void _simulateBooking() {
    /* BACKEND INTEGRATION EXAMPLE:
    
    // 1. Record audio
    final audioFile = await recorder.stop();
    
    // 2. Send to speech-to-text API
    final response = await http.post(
      Uri.parse('YOUR_API/api/voice/transcribe'),
      headers: {'Authorization': 'Bearer $token'},
      body: {'audio': base64Encode(audioFile)},
    );
    
    // 3. Parse the transcription
    final transcription = jsonDecode(response.body)['text'];
    
    // 4. Extract appointment details using NLP/AI
    final nlpResponse = await http.post(
      Uri.parse('YOUR_API/api/voice/parse-appointment'),
      body: {'text': transcription, 'userId': AuthService.currentUser!.id},
    );
    
    final appointmentData = jsonDecode(nlpResponse.body);
    
    // 5. Create appointment
    final result = await AppointmentsService.createAppointment(
      patientId: AuthService.currentUser!.id,
      doctorId: appointmentData['doctorId'],
      date: appointmentData['date'],
      time: appointmentData['time'],
      notes: transcription,
    );
    */

    // MOCK IMPLEMENTATION - Replace with real API call
    final newAppointment = AppointmentModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      patientId: AuthService.currentUser?.id ?? '',
      patientName: AuthService.currentUser?.name ?? '',
      doctorId: 'doc_2',
      doctorName: 'Dr. Sarah Williams',
      specialty: 'General Practitioner',
      date: 'Mon. 15 Dec. 2025',
      time: 'Afternoon: 14:00',
      status: AppointmentStatus.pending,
      hasImage: true,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AppointmentSuccessScreen(appointment: newAppointment),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2C3E7A), Color(0xFF4A5B9C), Color(0xFF6B5B95)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildStatusBar(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animated Microphone Circle
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: isRecording ? _scaleAnimation.value : 1.0,
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  const Color(0xFF9B7EDE).withOpacity(0.8),
                                  const Color(0xFF7B5EC4).withOpacity(0.6),
                                  const Color(0xFF5B3FA4).withOpacity(0.4),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF9B7EDE,
                                  ).withOpacity(isRecording ? 0.8 : 0.3),
                                  blurRadius: isRecording ? 80 : 40,
                                  spreadRadius: isRecording ? 30 : 10,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.mic,
                              size: 80,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 60),

                    // Title Text
                    Text(
                      isRecording ? 'Listening...' : 'Book Your appointment',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    // Recording Hint
                    if (isRecording) ...[
                      const SizedBox(height: 12),
                      Text(
                        'Say: "Book Dr. Smith for tomorrow at 2 PM"',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],

                    const SizedBox(height: 60),

                    // Action Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Message Button
                        _buildIconButton(
                          icon: Icons.chat_bubble_outline,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const MessageBookingScreen(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 40),

                        // Mic Button
                        _buildMicButton(),

                        const SizedBox(width: 40),

                        // Close Button
                        _buildIconButton(
                          icon: Icons.close,
                          onTap: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '11:11',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          Row(
            children: const [
              Icon(Icons.signal_cellular_4_bar, color: Colors.white, size: 16),
              SizedBox(width: 4),
              Icon(Icons.wifi, color: Colors.white, size: 16),
              SizedBox(width: 4),
              Icon(Icons.battery_full, color: Colors.white, size: 16),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildMicButton() {
    return GestureDetector(
      onTap: () {
        setState(() => isRecording = !isRecording);

        if (isRecording) {
          // Simulate recording and processing
          Future.delayed(const Duration(seconds: 3), () {
            if (mounted && isRecording) {
              _simulateBooking();
            }
          });
        }
      },
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [Color(0xFF5B9FFF), Color(0xFF3D7EE8)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(
                0xFF5B9FFF,
              ).withOpacity(isRecording ? 0.7 : 0.3),
              blurRadius: 20,
              spreadRadius: isRecording ? 5 : 0,
            ),
          ],
        ),
        child: Icon(
          isRecording ? Icons.mic : Icons.mic_none,
          color: Colors.white,
          size: 36,
        ),
      ),
    );
  }
}
