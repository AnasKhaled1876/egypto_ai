import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';

class VoiceRecordingController extends ChangeNotifier {
  final _recorder = AudioRecorder();
  double amplitude = 0.0;
  bool isRecording = false;

  String? _recordingPath;

  Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/recording_${DateTime.now().millisecondsSinceEpoch}.m4a';
    return filePath;
  }

  Future<void> start() async {
    if (!await _recorder.hasPermission()) return;

    _recordingPath = await _getFilePath();
    await _recorder.start(const RecordConfig(), path: _recordingPath!);

    isRecording = true;
    notifyListeners();

    _recorder.onAmplitudeChanged(const Duration(milliseconds: 200)).listen((amp) {
      amplitude = amp.current;
      notifyListeners();
    });
  }

  Future<void> pause() async {
    await _recorder.pause();
    isRecording = false;
    notifyListeners();
  }

  Future<void> resume() async {
    if (_recordingPath != null) {
      await _recorder.resume();
      isRecording = true;
      notifyListeners();
    }
  }

  Future<void> stop() async {
    await _recorder.stop();
    isRecording = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _recorder.dispose();
    super.dispose();
  }
}
