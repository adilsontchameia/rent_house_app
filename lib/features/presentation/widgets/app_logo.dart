import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: 110.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        children: const [
          Positioned(
            left: 10.0,
            right: 10.0,
            child: Icon(
              Icons.home_filled,
              size: 80.0,
              color: Colors.black,
            ),
          ),
          Positioned(
            left: 30.0,
            right: 5.0,
            top: 70.0,
            child: Text(
              'Mô Cúbico',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
