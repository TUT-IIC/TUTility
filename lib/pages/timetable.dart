import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/timetable.dart';
import 'get_timetable.dart';
import '../utils/tile_data.dart';

class TimetablePage extends StatefulWidget {
  const TimetablePage({Key? key}) : super(key: key);

  @override
  State<TimetablePage> createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  List<List<TileData?>> tiles = [];
  String getDate = '';
  String noTimetable = '';

  void _loadTimetable() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? timetableJson = prefs.getString('timetable_json');
    String? timetableGetDate = prefs.getString('timetable_get_date');

    if (timetableGetDate != null && timetableJson != null) {
      DateTime parsed = DateTime.parse(timetableGetDate).toLocal();
      if (mounted) {
        setState(() {
          tiles = _parseTimetableJson(timetableJson);
          getDate = DateFormat('y年M月d日').format(parsed);
        });
      }
    } else {
      setState(() {
        noTimetable = '右上のボタンから時間割を取得できます';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    print(noTimetable);
    setState(() {
      noTimetable = '';
    });
    _loadTimetable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TUTility'),
        actions: [
          IconButton(
            tooltip: '時間割の取得',
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => GetTimetablePage(),
                  fullscreenDialog: true,
                ),
              );
              _loadTimetable();
            },
            icon: const Icon(Icons.download),
          ),
        ],
      ),
      body: tiles.isNotEmpty
          ? SingleChildScrollView(
              child: Align(
                alignment: Alignment.center,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 640,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(8),
                        child: Text(
                          '取得日: ' + getDate,
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Timetable(tiles: tiles)
                    ],
                  ),
                ),
              ),
            )
          : Center(
              child: Text(noTimetable),
            ),
    );
  }
}

List<List<TileData?>> _parseTimetableJson(String json) {
  List<dynamic> s = jsonDecode(json);
  return s.map<List<TileData?>>((item) {
    return item.map<TileData?>((item) {
      if (item != null) {
        return TileData.fromJson(item);
      } else {
        return null;
      }
    }).toList();
  }).toList();
}
