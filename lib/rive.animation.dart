import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:test_app/plantScreen.dart';

class RiveAnimation extends StatelessWidget {
  const RiveAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              HexColor("61B688").withOpacity(0.5),
              HexColor("61B688").withOpacity(0.6),
              HexColor("61B688").withOpacity(0.8),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.0, 0.1),
            stops: const [0.0, 0.5, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        // color: Colors.white,
        child: PlanScreen(),
      ),
    );
  }
}
