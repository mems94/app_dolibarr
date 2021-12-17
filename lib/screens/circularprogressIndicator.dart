import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MyCircularProgress extends StatefulWidget {
  double percent;
  MyCircularProgress(this.percent);

  @override
  _MyCircularProgressState createState() => _MyCircularProgressState();
}

class _MyCircularProgressState extends State<MyCircularProgress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: CircularPercentIndicator(
        animation: true,
        radius: 120,
        lineWidth: 12.0,
        backgroundColor: Colors.white,
        footer: Text('Envoi en cours ...'),
        percent: widget.percent,
        center: Text((widget.percent * 100).toString() + '%'),
        progressColor: Colors.blue,
      ),
    ));
  }
}
