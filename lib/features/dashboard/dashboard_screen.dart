import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  void showReminderDialog() {
    isReminderShowing = true;
    showDialog(
      context: context,
      builder: (_) {
        return SingleChildScrollView(
          child: Dialog(
            child: Container(
              width: 280,
              height: 280,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Time For A Check',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'You have been inactive for 20 minutes.',
                    textAlign: TextAlign.center,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        dialogOpen = false;
                        isReminderShowing = false;
                        Navigator.pop(context);
                      },
                      child: const Text("I'm Fine"),
                    ),
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const StretchScreen(),
                          ),
                        );
                      },
                      child: const Text("Stretch"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this as WidgetsBindingObserver);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  SizedBox(height: 5),
                  const Text(
                    "PosturePal",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    serviceRunning ? 'Monitoring Active' : 'Monitoring Stopped',
                    style: TextStyle(
                      color: serviceRunning
                          ? Colors.greenAccent
                          : Colors.orangeAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20,),
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
                      serviceRunning ? "Stop Monitoring" : "Start Monitoring",
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
