import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Yes extends StatefulWidget {
  const Yes({Key? key}) : super(key: key);

  @override
  State<Yes> createState() => _YesState();
}

class _YesState extends State<Yes> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _initializeController() async {
    _controller = VideoPlayerController.asset(
      'assets/yes.mp4',
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    await _controller.initialize();
    _controller.setLooping(true);

    // Ensure the state is updated after controller is initialized.
    if (mounted) {
      setState(() {});
    }

    _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : const CircularProgressIndicator(), // Show a loading indicator while initializing.
        ),
      ),
    );
  }
}
