import 'package:flutter/material.dart';
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
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  void _initializeController() async {
    _controller = VideoPlayerController.asset('assets/valentine.mp4');
    await _controller.initialize();
    _controller.setLooping(true);
    _controller.play();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
