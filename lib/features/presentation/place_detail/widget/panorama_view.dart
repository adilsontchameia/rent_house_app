import 'package:flutter/material.dart';
import 'package:rent_house_app/features/presentation/image_view.dart';
import 'loading_widget.dart';

class PanoramaScreen extends StatefulWidget {
  const PanoramaScreen({super.key});

  @override
  PanoramaScreenState createState() => PanoramaScreenState();
}

class PanoramaScreenState extends State<PanoramaScreen> {
  Future<void> _loadPanoramaImage() {
    // Simulate loading the panorama image with a delay of 2 seconds.
    return Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<void>(
          future: _loadPanoramaImage(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingWidget();
            } else if (snapshot.hasError) {
              return const Text('Error loading panorama image.');
            } else {
              return const PanoramaImageScreen(
                imageUrl: 'assets/home_view.jpg',
              );
            }
          },
        ),
      ),
    );
  }
}
