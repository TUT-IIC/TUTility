import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutility/model/term.dart';
import 'package:tutility/provider/term.dart';
import 'package:tutility/provider/timetable.dart';
import 'package:tutility/router/app_router.dart';
import 'package:tutility/widget/timetable_view.dart';

@RoutePage()
@immutable
class TimetablePage extends ConsumerWidget {
  const TimetablePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timetable = ref.watch(timetableNotifierProvider);
    final term = ref.watch(termNotifierProvider);

    final firstOrSecond = switch (term) {
      Term.firstHalf => timetable?.firstHalf,
      Term.secondHalf => timetable?.secondHalf,
    };

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: timetable != null
            ? SegmentedButton<Term>(
                multiSelectionEnabled: false,
                emptySelectionAllowed: false,
                showSelectedIcon: false,
                segments: [
                  ButtonSegment(
                    value: Term.firstHalf,
                    label: Text('${timetable.semester.label}1'),
                  ),
                  ButtonSegment(
                    value: Term.secondHalf,
                    label: Text('${timetable.semester.label}2'),
                  ),
                ],
                selected: {term},
                onSelectionChanged: (newSelection) {
                  ref
                      .watch(termNotifierProvider.notifier)
                      .set(newSelection.first);
                },
              )
            : null,
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            tooltip: '時間割の取得',
            onPressed: () {
              AutoRouter.of(context).push(GetTimetableRoute());
            },
          ),
        ],
      ),
      body: firstOrSecond != null
          ? SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.topCenter,
                child: TimetableView(timetable: firstOrSecond),
              ),
            )
          : Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child: const Center(
                child: Text(
                  '右上のボタンから時間割を取得できます',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
    );
  }
}
