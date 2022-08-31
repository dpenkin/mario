import 'dart:math';

import 'package:flutter/material.dart';

class MyMario extends StatelessWidget {
  final direction;
  final midrun;
  final size;

  const MyMario({Key? key, this.direction, this.midrun, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (direction == 'right') {
      return SizedBox(
        width: size,
        height: size,
        child: midrun
            ? Image.asset('images/stey.png')
            : Image.asset('images/running.png'),
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: SizedBox(
          width: size,
          height: size,
          child: midrun
            ? Image.asset('images/stey.png')
            : Image.asset('images/running.png'),
        ),
      );
    }
  }
}
