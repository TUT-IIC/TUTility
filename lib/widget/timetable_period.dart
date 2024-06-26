import 'package:flutter/material.dart';
import 'package:tutility/font_scaler.dart';

@immutable
class TimetablePeriod extends StatelessWidget {
  final int period;

  const TimetablePeriod({
    super.key,
    required this.period,
  });

  @override
  Widget build(BuildContext context) {
    String begin = '', end = '';
    switch (period) {
      case 1:
        begin = '8:50';
        end = '10:20';
        break;
      case 2:
        begin = '10:30';
        end = '12:00';
        break;
      case 3:
        begin = '13:00';
        end = '14:30';
        break;
      case 4:
        begin = '14:40';
        end = '16:10';
        break;
      case 5:
        begin = '16:20';
        end = '17:50';
        break;
      case 6:
        begin = '18:00';
        end = '19:30';
        break;
    }

    return Padding(
      padding: EdgeInsets.all(2.scale(context)),
      child: Column(
        children: [
          Text(
            begin,
            style: TextStyle(fontSize: 10.scale(context)),
          ),
          Padding(
            padding: EdgeInsets.all(2.scale(context)),
            child: Text(
              '$period',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.scale(context),
              ),
            ),
          ),
          Text(
            end,
            style: TextStyle(fontSize: 10.scale(context)),
          ),
        ],
      ),
    );
  }
}
