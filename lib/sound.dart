import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:microphone/microphone.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isRecording = false;
  bool _isPlaying = false;
  String _filePath = '';

  final AudioPlayer _audioPlayer = AudioPlayer();
  final MicrophoneRecorder _recorder = MicrophoneRecorder();

  Future<void> _startRecording() async {
    try {
      await _recorder.start();
      setState(() {
        _isRecording = true;
      });
    } catch (err) {
      print('Start recording error: $err');
    }
  }

  Future<void> _stopRecording() async {
    try {
      await _recorder.stop();
      setState(() {
        _isRecording = false;
        _filePath = _recorder.value.recording!.url;
      });
    } catch (err) {
      print('Stop recording error: $err');
    }
  }

  Future<void> _playAudio() async {
    try {
      await _audioPlayer.play(_filePath, isLocal: true);
      setState(() {
        _isPlaying = true;
      });
    } catch (err) {
      print('Play audio error: $err');
    }
  }

  Future<void> _stopAudio() async {
    try {
      await _audioPlayer.stop();
      setState(() {
        _isPlaying = false;
      });
    } catch (err) {
      print('Stop audio error: $err');
    }
  }

  Future<void> _saveRecording() async {
    const fileName = 'recording.wav';
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';

    try {
      final file = File(filePath);
      await file.writeAsBytes(_recorder.audioData!.buffer.asUint8List());
    } catch (err) {
      print('Save recording error: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _isRecording
                ? TextButton(
                    onPressed: _stopRecording,
                    child: const Text('Stop Recording'),
                  )
                : TextButton(
                    onPressed: _startRecording,
                    child: const Text('Record'),
                  ),
            const SizedBox(height: 16),
            _filePath.isNotEmpty
                ? TextButton(
                    onPressed: _playAudio,
                    child: const Text('Play'),
                  )
                : Container(),
            _isPlaying
                ? TextButton(
                    onPressed: _stopAudio,
                    child: const Text('Stop Playing'),
                  )
                : Container(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_filePath.isNotEmpty) {
            await _saveRecording();
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PlayerScreen(filePath: _filePath)),
            );
          }
        },
        tooltip: 'Save Recording',
        child: const Icon(Icons.save),
      ),
    );
  }
}

class PlayerScreen extends StatefulWidget {
  final String filePath;

  const PlayerScreen({Key? key, required this.filePath}) : super(key: key);

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playAudio() async {
    try {
      await _audioPlayer.play(widget.filePath, isLocal: true);
    } catch (err) {
      print('Play audio error: $err');
    }
  }

  Future<void> _stopAudio() async {
    try {
      await _audioPlayer.stop();
    } catch (err) {
      print('Stop audio error: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Player Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: _playAudio,
              child: const Text('Play'),
            ),
            TextButton(
              onPressed: _stopAudio,
              child: const Text('Stop'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Sound Recorder/Player',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Sound Recorder/Player'),
    );
  }
}
