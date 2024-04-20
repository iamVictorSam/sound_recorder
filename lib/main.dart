import 'package:flutter/material.dart';

import 'sound.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Sound Recorder/Player'),
    );
  }
}

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   final AudioPlayer _audioPlayer = AudioPlayer();

//   Future<void> _playAudio() async {
//     try {
//       await _audioPlayer.play(filePath, isLocal: true);
//     } catch (err) {
//       print('Play audio error: $err');
//     }
//   }

//   Future<void> _stopAudio() async {
//     try {
//       await _audioPlayer.stop();
//     } catch (err) {
//       print('Stop audio error: $err');
//     }
//   }

//   @override
//   void dispose() {
//     _audioPlayer?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               RaisedButton(
//                 child: const Text('Record'),
//                 onPressed: () async {
//                   await _startRecording();
//                   Fluttertoast.showToast(
//                       msg: 'Recording started',
//                       toastLength: Toast.LENGTH_SHORT);
//                 },
//               ),
//               RaisedButton(
//                 child: const Text('Stop Recording'),
//                 onPressed: () async {
//                   await _stopRecording();
//                   await _saveRecording();
//                   Fluttertoast.showToast(
//                       msg: 'Recording saved', toastLength: Toast.LENGTH_SHORT);
//                 },
//               ),
//               RaisedButton(
//                 child: const Text('Play'),
//                 onPressed: () async {
//                   await _playAudio();
//                 },
//               ),
//               RaisedButton(
//                 child: const Text('Stop Playing'),
//                 onPressed: () async {
//                   await _stopAudio();
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
