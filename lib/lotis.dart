import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';

class LotisDemo extends StatelessWidget {
  const LotisDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 97, 64, 186),
      appBar: AppBar(
        title: const Text('Lotis Demo'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/3.json'),
          Center(
            child: Text('Lotis Demo'),
          ),
        ],
      ),
    );
  }
}
