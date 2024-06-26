import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:confetti/confetti.dart';
import 'package:foryou/txtBuilder.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Funny Birthday Wish',
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
  final AudioCache _audioCache = AudioCache();
  final ConfettiController _confettiController = ConfettiController();
  final List<String> _funnyWishes = [
    'Janam din ki dher saari shubhkaamnayein! Har pal aapke liye khushiyan lekar aaye! ❤️😊',
    'Aapko janamdin ki bahut sari shubhkamnayein! Aapka din har pal special ho! 🎉😄',
    'Janamdin ki hardik badhaiyan! Aapki har khwahish poori ho! 🎂🌟',
    'Aapke janamdin par dher saari khushiyan aur pyaar! 💕🎈',
    'Janamdin mubarak ho! Aapko hamesha khush rakhne wali shakti mile! 💪😊',
    'Aapke janamdin par yeh dua hai ki aapka har sapna sach ho! ✨🌠',
    'Janamdin ke is khubsurat din par aapko dher saari pyaar aur shubh kamnayein! 💖😊',
    'Aapke janamdin par aapko dher saari khushiyan aur samriddhi mile! 🎁🌟',
    'Janamdin ki dher saari shubh kamnayein! Aapka har din aapke liye anmol ho! 💎😄',
    'Aapko janamdin ki dher saari shubh kamnayein! Aapki umar lambi ho! 🌼🎂',
    'Janamdin mubarak ho! Aapko hamesha yeh khushi mile ki aap sab ke liye khaas ho! 🌟😊',
    'Aapke janamdin par dher saari shubh kamnayein! Aapka har din khushi se bhara ho! 😄🎉',
    'Janamdin ki hardik badhai! Aapke har sapne sach ho! 🎈✨',
    'Aapko janamdin ki dher saari shubh kamnayein! Aap hamesha muskurayein! 😊🌸',
    'Janamdin mubarak ho! Aapka har din itna khubsurat ho ki sab hairaan ho jayein! 🎉🌟',
    'Aapke janamdin par yeh dua hai ki aapka har din aapko nayi khushiyan lekar aaye! 😊✨',
    'Janamdin ki bahut bahut shubhkamnayein! Aapka har pal aapke sapno se bhara ho! 💫🌈',
    'Aapko janamdin ki dher saari shubh kamnayein! Aapka har din khushiyon se bhara ho! 😄💐',
    'Janamdin mubarak ho! Aapko har pal aapke sapno tak pahunchne ki shakti mile! 🌠🎈',
    'Aapke janamdin par yeh dua hai ki aapka har din aapke liye anmol ho! 💖😊'
  ];



  String _selectedWish = '';
  Timer? _timer;
  int _currentWishIndex = 0;
  int _timerValue = 5;

  @override
  void initState() {
    super.initState();
    _playAudio();
    _startTimer();
  }

  void _playAudio() {
    _audioCache.load('bday.mp3'); // Load the audio into cache
  }

  void _generateFunnyWish() {
    final random = Random();
    setState(() {
      _selectedWish = _funnyWishes[random.nextInt(_funnyWishes.length)];
      _confettiController.play();
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timerValue > 0) {
          _timerValue--;
        } else {
          _timerValue = 5;
          _currentWishIndex = (_currentWishIndex + 1) % _funnyWishes.length;
          _selectedWish = _funnyWishes[_currentWishIndex];
          _confettiController.play();
        }
      });
    });
  }

  @override
  void dispose() {
    _audioCache.clear('bday.mp3'); // Clear cache if necessary
    _confettiController.dispose();
    _timer?.cancel();
    super.dispose();
  }
   bool val = true;
  void _showWishesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            height: 500.0, // Initial height, will expand as wishes are typed
            width: 300.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              gradient: LinearGradient(
                colors: [Colors.pinkAccent, Colors.redAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextBuilder(text: "Heartfull Wishes",fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white,),
                SizedBox(height: 10.0),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: _funnyWishes.map((wish) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              TyperAnimatedText(
                                wish,
                                textStyle: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                                speed: Duration(milliseconds: 100),
                              ),
                            ],
                            isRepeatingAnimation: false,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      val = !val;
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextBuilder(text: "For yoy",fontWeight: FontWeight.bold,),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText(
                      val ? 'Happy Birthday beta':"Love Uhh Baccha",
                      textStyle: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                    ),
                  ],
                  isRepeatingAnimation: true,
                ),
                SizedBox(height: 20),
                // _selectedWish.isNotEmpty
                //     ? Column(
                //   children: [
                //     Text(
                //       '$_timerValue seconds left',
                //       style: TextStyle(
                //         fontSize: 18.0,
                //         fontWeight: FontWeight.bold,
                //         color: Colors.blue,
                //       ),
                //     ),
                //     SizedBox(height: 10),
                //     Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: AnimatedTextKit(
                //         animatedTexts: [
                //           ColorizeAnimatedText(
                //             _selectedWish,
                //             textStyle: TextStyle(
                //               fontSize: 26.0,
                //               fontWeight: FontWeight.bold,
                //             ),
                //             colors: [
                //               Colors.pink,
                //               Colors.purple,
                //               Colors.yellow,
                //               Colors.blue,
                //             ],
                //           ),
                //         ],
                //         isRepeatingAnimation: true,
                //       ),
                //     ),
                //   ],
                // )
                //     : Container(),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // _generateFunnyWish();
                    _showWishesDialog(context); // Show wishes dialog
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: 180,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent, // Use your custom color
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        'Open my heart',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: -pi / 2,
              shouldLoop: true,
              colors: const [
                Colors.pink,
                Colors.purple,
                Colors.yellow,
                Colors.blue,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
