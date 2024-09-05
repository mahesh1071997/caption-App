import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/text_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed( const Duration(seconds: 3), () {
      Get.offNamed('/home');
    });

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/cherriesamelie.jpg'), // Path to your background image
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Card(
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0), // Set the desired radius here
                    ),
                    elevation: 4,
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 150,
                      height: 150,
                    ),
                  ),
                  const SizedBox(height: 28,),
                  const GradientText(
                    'CaptionCraft',
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue,
                        Colors.purple,
                        Colors.red,
                      ],
                    ),
                    style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
