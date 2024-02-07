import 'package:flutter/material.dart';

class No extends StatefulWidget {
  const No({super.key});

  @override
  State<No> createState() => _NoState();
}

class _NoState extends State<No> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Text(
              "Ohhh",
              style: TextStyle(color: Colors.black, fontSize: 30.0),
            ),
          ),
        ),
      ),
    );
  }
}
