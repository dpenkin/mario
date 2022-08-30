import 'package:flutter/material.dart';
import 'package:mario/button.dart';
import 'package:mario/jumping_mario.dart';
import 'package:mario/mario.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double marioX = 0;
  static double marioY = 1;
  double time = 0;
  double height = 0;
  double initialHeight = marioY;
  String direction = 'right';
  bool midrun = false;
  bool midjump = false;

  void preJamp() {
    time = 0;
    initialHeight = marioY;
  }

  void jump() {
    midjump = true;
    preJamp();
    Timer.periodic(const Duration(microseconds: 35000), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 5 * time;

      if (initialHeight - height > 1) {
        midjump = false;
        setState(() {
          marioY = 1;
          timer.cancel();
        });
      } else {
        setState(() {
          marioY = initialHeight - height;
        });
      }
    });
  }

  void moveRight() {
    direction = 'right';

    Timer.periodic(const Duration(microseconds: 35000), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 5 * time;

      if (MyButton().userIsHoldingButton() == true) {
        setState(() {
          marioX += 0.02;
          midrun = !midrun;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void moveLeft() {
    direction = 'left';
        Timer.periodic(const Duration(microseconds: 35000), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 5 * time;

      if (MyButton().userIsHoldingButton() == true) {
        setState(() {
          marioX -= 0.02;
          midrun = !midrun;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.blue,
              child: AnimatedContainer(
                alignment: Alignment(marioX, marioY),
                duration: const Duration(milliseconds: 0),
                child: midjump
                    ? JumpingMario(
                        direction: direction,
                      )
                    : MyMario(
                        direction: direction,
                        midrun: midrun,
                      ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.brown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButton(
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    function: moveLeft,
                  ),
                  MyButton(
                    function: jump,
                    child: const Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
                    ),
                  ),
                  MyButton(
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                    function: moveRight,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
