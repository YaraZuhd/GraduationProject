import 'package:flutter/material.dart';
import 'package:test/data/red_and_green.dart';

class AreasCard extends StatelessWidget {
  final RedAndGreen data;
  final TextStyle boldStyle;

  const AreasCard({Key? key, required this.data, required this.boldStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Card(
          child: InkWell(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Column(
                    children: [
                      Text('Area Name :' + data.areaName, style: boldStyle),
                      Text(
                        'Email :' + data.email,
                        style: boldStyle,
                      ),
                      Text('Latitude :' + data.lat, style: boldStyle),
                      Text(
                        'Longitude :' + data.lang,
                        style: boldStyle,
                      ),
                      Text('UnSafe Area :' + data.notSafe.toString(),
                          style: boldStyle),
                      Text(
                        'Safe Area :' + data.safe.toString(),
                        style: boldStyle,
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ))
    ]);
  }
}
