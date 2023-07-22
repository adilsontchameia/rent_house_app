import 'dart:developer';

import 'package:flutter/material.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 30.0,
        left: 20.0,
        right: 20.0,
        child: SizedBox(
          height: 50.0,
          child: ElevatedButton(
            onPressed: () {
              log('Navigated');
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0))),
            child: const Text(
              'Iniciar',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ));
  }
}
