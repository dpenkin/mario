import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mario/button.dart';
import 'package:mario/jumping_mario.dart';
import 'package:mario/mario.dart';
import 'dart:async';

import 'package:mario/shrooms.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double marioX = 0;
  static double marioY = 1;
  double shroomX = 0.5;
  double shroomY = 1.05;
  double marioSize = 50;
  double time = 0;
  double height = 0;
  double initialHeight = marioY;
  String direction = 'right';
  bool midrun = false;
  bool midjump = false;
  var gameFont = GoogleFonts.pressStart2p(
    textStyle: const TextStyle(color: Colors.white, fontSize: 20),
  );

  void checkIfAteShrooms() {
    if ((marioX - shroomX).abs() < 0.05 && (marioY - shroomY).abs() < 0.05) {
      setState(() {
        shroomX == 2;
        marioSize == 100;
      });
    }
  }

  void preJamp() {
    time = 0;
    initialHeight = marioY;
  }

  void jump() {
    if (midjump == false) {
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
  }

  void moveRight() {
    direction = 'right';
    checkIfAteShrooms();
    Timer.periodic(const Duration(microseconds: 35000), (timer) {
      checkIfAteShrooms();
      time += 0.05;
      height = -4.9 * time * time + 5 * time;

      if (MyButton().userIsHoldingButton() == true && marioX + 0.02 < 1) {
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
    checkIfAteShrooms();
    Timer.periodic(const Duration(microseconds: 35000), (timer) {
      checkIfAteShrooms();
      time += 0.05;
      height = -4.9 * time * time + 5 * time;

      if (MyButton().userIsHoldingButton() == true && marioX - 0.02 > -1) {
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
            child: Stack(
              children: [
                const Text('MARIO'),
                Container(
                  color: Colors.blue,
                  child: AnimatedContainer(
                    alignment: Alignment(marioX, marioY),
                    duration: const Duration(milliseconds: 0),
                    child: midjump
                        ? JumpingMario(
                            direction: direction,
                            size: marioSize,
                          )
                        : MyMario(
                            direction: direction,
                            midrun: midrun,
                            size: marioSize,
                          ),
                  ),
                ),
                Container(
                  alignment: Alignment(shroomX, shroomY),
                  child: MyShroom(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text('MARIO', style: gameFont),
                          const SizedBox(height: 10),
                          Text('0000', style: gameFont),
                        ],
                      ),
                      Column(
                        children: [
                          Text('WORLD', style: gameFont),
                          const SizedBox(height: 10),
                          Text('1-1', style: gameFont),
                        ],
                      ),
                      Column(
                        children: [
                          Text('TIME', style: gameFont),
                          const SizedBox(height: 10),
                          Text('9999', style: gameFont),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
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
                    function: moveLeft,
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
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
