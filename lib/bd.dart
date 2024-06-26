import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class BirthdayWishScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Happy Birthday!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: RiveAnimation.asset(
                'assets/cute_cake.riv',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
