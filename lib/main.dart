import 'dart:math';

import 'package:flutter/material.dart';
import 'package:valentine/values.dart';
import 'package:valentine/yes.dart';
import 'package:video_player/video_player.dart';

void main() {
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
  bool showMessage = false;

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
              heightFactor: 14,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Yes()),
                  );
                },
                child: const Text('Yes'),
              ),
            ),
            if (showMessage) // Show the message only if "No" is clicked
              Align(
                alignment: Alignment.bottomCenter,
                child: Center(
                  child: Text(
                    messages[_random.nextInt(messages.length)],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            Positioned(
              left: _getRandomPosition(screenWidth - 100),
              top: _getRandomPosition(screenHeight - 100),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    showMessage =
                        true; // Update the variable when "No" is clicked
                  });
                },
                child: const Text('No'),
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
