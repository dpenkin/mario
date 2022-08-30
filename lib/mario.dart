import 'dart:math';

import 'package:flutter/material.dart';

class MyMario extends StatelessWidget {
  final direction;
  final midrun;

  const MyMario({Key? key, this.direction, this.midrun}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (direction == 'right') {
      return SizedBox(
        width: 50,
        height: 50,
        child: midrun
            ? Image.asset('images/stey.png')
            : Image.asset('images/running.png'),
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: SizedBox(
          width: 50,
          height: 50,
          child: midrun
            ? Image.asset('images/stey.png')
            : Image.asset('images/running.png'),
        ),
      );
    }
  }
}
