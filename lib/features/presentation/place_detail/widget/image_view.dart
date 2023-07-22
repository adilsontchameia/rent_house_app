import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:panorama/panorama.dart';

class PanoramaImageScreen extends StatefulWidget {
  final String
      imageUrl; // Replace this with the URL or path of your panorama image

  const PanoramaImageScreen({super.key, required this.imageUrl});

  @override
  PanoramaImageScreenState createState() => PanoramaImageScreenState();
}

class PanoramaImageScreenState extends State<PanoramaImageScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 700,
      ), // Adjust the duration of the fade-in animation
    );

    // Create a fade-in animation
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Start the fade-in animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FadeTransition(
            opacity: _fadeInAnimation,
            child: Panorama(
              child: Image.asset(
                widget.imageUrl,
                fit: BoxFit.cover,
                width: 500,
                height: 500,
              ),
            ),
          ),
          //TODO Exit Button
          Positioned(
            top: 10.0,
            left: 10.0,
            child: FadeTransition(
              opacity: _fadeInAnimation,
              child: SafeArea(
                child: Container(
                  height: 40.0,
                  width: 40.0,
                  color: Colors.black,
                  child: IconButton(
                    iconSize: 20.0,
                    onPressed: () => log('Exited'),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
