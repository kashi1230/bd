import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advanced Birthday Wish',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: BirthdayWishScreen(),
    );
  }
}

class BirthdayWishScreen extends StatefulWidget {
  @override
  _BirthdayWishScreenState createState() => _BirthdayWishScreenState();
}

class _BirthdayWishScreenState extends State<BirthdayWishScreen> {
  late RiveAnimationController _cakeController;
  late RiveAnimationController _balloonController;
  final AudioPlayer _audioPlayer = AudioPlayer();

  final List<String> _wishes = [
    'Happy Birthday, my love! You mean the world to me!',
    'Wishing you a day filled with love, joy, and all your favorite things!',
    'To the most wonderful person, Happy Birthday! May your day be as amazing as you are!',
    'May your birthday be filled with laughter and love, Happy Birthday!',
    'On your special day, I just want to say how grateful I am to have you in my life. Happy Birthday!',
    'Sending you all my love on your birthday and wishing you a day filled with happiness and joy!',
  ];

  String _selectedWish = '';

  @override
  void initState() {
    super.initState();
    _cakeController = SimpleAnimation('idle');
    _balloonController = SimpleAnimation('idle');
    _playAudio();
  }

  void _playAudio() async {
    await _audioPlayer.play(AssetSource('audio/birthday_song.mp3'));
  }

  void _generateWish() {
    final random = Random();
    setState(() {
      _selectedWish = _wishes[random.nextInt(_wishes.length)];
    });
  }

  @override
  void dispose() {
    _cakeController.dispose();
    _balloonController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

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
                'assets/birthday_cake.riv',
                controllers: [_cakeController],
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 200,
              height: 200,
              child: RiveAnimation.asset(
                'assets/balloons.riv',
                controllers: [_balloonController],
              ),
            ),
            SizedBox(height: 20),
            _selectedWish.isNotEmpty
                ? AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText(
                  _selectedWish,
                  textStyle: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                  colors: [
                    Colors.pink,
                    Colors.purple,
                    Colors.yellow,
                    Colors.blue,
                  ],
                ),
              ],
              isRepeatingAnimation: false,
            )
                : Container(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateWish,
              child: Text('Generate a Wish!'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _cakeController.isActive = !_cakeController.isActive;
                  _balloonController.isActive = !_balloonController.isActive;
                });
              },
              child: Text('Surprise!'),
            ),
          ],
        ),
      ),
    );
  }
}
