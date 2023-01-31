import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({Key? key}) : super(key: key);

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  Artboard? _riveArtboard;
  StateMachineController? _controller;
  SMIInput<double>? _progress;

  String plantButtonText = "";

  late Timer _timer;
  int treeProgress = 0;
  int treeProgressMax = 60;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    plantButtonText = 'Plant';
    rootBundle.load('assets/tree_demo_1.riv').then((data) async {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      var controller = StateMachineController.fromArtboard(artboard, 'Grow');
      if (controller != null) {
        artboard.addController(controller);
        _progress = controller.findInput('input');
        setState(() {
          _riveArtboard = artboard;
        });
      }
    });
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (treeProgress == treeProgressMax) {
        stopTimer();
        plantButtonText = 'Plant';
        treeProgress = 0;
        treeProgressMax = 60;
      } else {
        setState(() {
          treeProgress++;
          _progress?.value = treeProgress.toDouble();
        });
      }
    });
  }

  void stopTimer() {
    setState(() {
      _timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    double treeWidth = MediaQuery.of(context).size.width - 40;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 60.0),
            child: Text(
              'Stay Focus',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                width: treeWidth,
                height: treeWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(treeWidth / 2),
                  border: Border.all(
                    color: Colors.white12,
                    width: 10,
                  ),
                ),
                child: _riveArtboard == null
                    ? const SizedBox()
                    : Rive(
                        alignment: Alignment.center,
                        artboard: _riveArtboard!,
                        fit: BoxFit.contain,
                      ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              intToTimeLeft(treeProgressMax - treeProgress).toString(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: Text(
              "Time left to grow the plant",
              style: TextStyle(
                  color: Colors.white60,
                  fontSize: 10,
                  fontWeight: FontWeight.normal),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: MaterialButton(
              height: 40.0,
              minWidth: 180.0,
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              color: Colors.green,
              textColor: Colors.white,
              onPressed: () {
                if (treeProgress > 0) {
                  stopTimer();
                  plantButtonText = "Plant";
                  treeProgress = 0;
                  treeProgressMax = 60;
                } else {
                  plantButtonText = "Surrender";
                  startTimer();
                }
              },
              splashColor: Colors.redAccent,
              child: Text(plantButtonText),
            ),
          )
        ],
      ),
    );
  }
}

String intToTimeLeft(int value) {
  int h, m, s;

  h = value ~/ 3600;

  m = ((value - h * 3600)) ~/ 60;

  s = value - (h * 3600) - (m * 60);

  String hourLeft = h.toString().length < 2 ? "0" + h.toString() : h.toString();

  String minuteLeft =
      m.toString().length < 2 ? "0" + m.toString() : m.toString();

  String secondsLeft =
      s.toString().length < 2 ? "0" + s.toString() : s.toString();

  String result = "$minuteLeft:$secondsLeft";

  return result;
}
