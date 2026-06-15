import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:posture_pal/core/services/helper.dart';
import 'package:posture_pal/core/services/monitoring_service.dart';
import 'package:posture_pal/features/stretch/stretch_screen.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen>
    with WidgetsBindingObserver {
  bool isReminderShowing = false;
  bool dialogOpen = false;
  bool serviceRunning = false;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this as WidgetsBindingObserver);

    checkNotificationLaunch();
    loadServiceStatus();
  }

  Future<void> loadServiceStatus() async {
    final running = await ServiceController.serviceStatus();

    if (!mounted) return;

    setState(() {
      serviceRunning = running;
    });
  }

  Future<void> checkNotificationLaunch() async {
    final openStretch = await ServiceController.openStretch();

    print("OPEN STRETCH = $openStretch");

    if (!mounted) return;

    if (openStretch) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const StretchScreen()),
      );
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      checkNotificationLaunch();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this as WidgetsBindingObserver);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimateGradient(
        primaryBeginGeometry: const AlignmentDirectional(0, 1),
        primaryEndGeometry: const AlignmentDirectional(0, 2),
        secondaryBeginGeometry: const AlignmentDirectional(2, 0),
        secondaryEndGeometry: const AlignmentDirectional(0, -0.8),
        textDirectionForGeometry: TextDirection.rtl,
        primaryColors: const [Colors.black, Colors.black, Colors.black],
        secondaryColors: const [
          Color(0xFF152331),
          Colors.black,
          Color.fromARGB(255, 28, 43, 58),
        ],
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .05,
                        ),
                        Text(
                          "PosturePal",
                          style: GoogleFonts.elmsSans(
                            color: Colors.blueAccent,
                            fontSize: MediaQuery.of(context).size.height * .125,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .05,
                        ),
                        Text(
                          serviceRunning
                              ? '🟢 Monitoring Active'
                              : '🔴 Monitoring Stopped',
                          style: GoogleFonts.elmsSans(
                            color: serviceRunning
                                ? Colors.greenAccent
                                : Colors.redAccent,
                            fontSize: MediaQuery.of(context).size.height * .05,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .05,
                        ),
                        ElevatedButton(
                          
                          onPressed: () async {
                            if (serviceRunning) {
                              await ServiceController.stop();

                              setState(() {
                                serviceRunning = false;
                              });
                            } else {
                              await ServiceController.start();

                              setState(() {
                                serviceRunning = true;
                              });
                            }
                          },
                          child: Text(
                            serviceRunning
                                ? "Stop"
                                : "Start",
                            style: GoogleFonts.elmsSans(
                              color: serviceRunning
                                  ? Colors.redAccent
                                  : Colors.greenAccent,
                              fontSize:
                                  MediaQuery.of(context).size.height * .05,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
