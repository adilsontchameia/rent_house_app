import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SmoothDotsIndicator extends StatelessWidget {
  const SmoothDotsIndicator({
    super.key,
    required PageController controller,
    required this.titlesList,
  }) : _controller = controller;

  final PageController _controller;
  final List<Widget> titlesList;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: _controller,
      count: titlesList.length,
      effect: JumpingDotEffect(
        activeDotColor: Colors.brown.shade200,
        dotColor: Colors.grey,
        dotHeight: 10.0,
        dotWidth: 10.0,
        jumpScale: 2.0,
      ),
    );
  }
}
