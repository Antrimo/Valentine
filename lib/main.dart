import 'dart:math';
import 'package:valentine/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:valentine/values.dart';
import 'package:valentine/yes.dart';
import 'package:video_player/video_player.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: VideoApp(),
  ));
}

class VideoApp extends StatefulWidget {
  const VideoApp({Key? key}) : super(key: key);

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  final Random _random = Random();

  double _getRandomPosition(double max) {
    return _random.nextDouble() * max;
  }

  late VideoPlayerController _controller;

  bool noButtonVisible = true;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  void _initializeController() async {
    _controller = VideoPlayerController.asset('assets/valentine.mp4');
    await _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(0.0);
    _controller.play();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Add your desired emojis

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: _controller.value.isInitialized
                  ? VideoPlayer(_controller)
                  : Container(),
            ),
            const Align(
              widthFactor: 3,
              heightFactor: 10,
              child: Text(
                'Will you be my valentine?',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Align(
              heightFactor: 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Yes()),
                      );
                    },
                    child: const Text('Yes'),
                  ),
                  const SizedBox(width: 20),
                  if (noButtonVisible)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          noButtonVisible = false;
                        });
                      },
                      child: const Text('No'),
                    ),
                ],
              ),
            ),
            if (!noButtonVisible)
              Align(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      emojis[_random.nextInt(emojis.length)],
                      style: const TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        messages[_random.nextInt(messages.length)],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (!noButtonVisible)
              Positioned(
                left: _getRandomPosition(screenWidth - 100),
                top: _getRandomPosition(screenHeight - 100),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: const Text('NO'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
