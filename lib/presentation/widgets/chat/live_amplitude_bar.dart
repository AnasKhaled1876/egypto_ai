import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/services/recorder_service.dart';

class LiveAmplitudeBar extends StatelessWidget {
  const LiveAmplitudeBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<VoiceRecordingController>(
      builder: (context, controller, child) {
        return Column(
          children: [
            Text(controller.isRecording ? "Recording..." : "Not Recording"),
            const SizedBox(height: 10),
            VoiceBars(amplitude: controller.amplitude),
            const SizedBox(height: 10),
            Container(
              width: 200,
              height: 20,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(5),
              ),
              child: FractionallySizedBox(
                widthFactor: (controller.amplitude / 100).clamp(0.0, 1.0),
                child: Container(color: Colors.green),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  onPressed: controller.isRecording ? null : controller.start,
                  child: const Text('Start'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: controller.isRecording ? controller.stop : null,
                  child: const Text('Stop'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class VoiceBars extends StatelessWidget {
  final double amplitude; // 0–120 typically

  const VoiceBars({required this.amplitude, super.key});

  @override
  Widget build(BuildContext context) {
    final normalized = (amplitude / 120).clamp(0.2, 1.0); // Normalize dB

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(7, (i) {
        final scale = (i % 2 == 0) ? 1.0 : 0.7;
        final barHeight = 10 + (40 * normalized * scale);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 6,
          height: barHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
