import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tutility/providers/shared_preferences.dart';

part 'timetable.freezed.dart';
part 'timetable.g.dart';

@freezed
class Subject with _$Subject {
  const factory Subject({
    required String id,
    required String url,
    required String name,
    String? area,
    String? term,
    String? required,
    String? units,
    String? grade,
    String? staff,
    String? room,
  }) = _Subject;

  factory Subject.fromJson(Map<String, dynamic> json) =>
      _$SubjectFromJson(json);
}

@freezed
class Timetable with _$Timetable {
  const factory Timetable({
    required int period,
    required int firstOrSecond,
    required List<List<Subject?>> firstHalf,
    required List<List<Subject?>> secondHalf,
  }) = _Timetable;

  factory Timetable.fromJson(Map<String, dynamic> json) =>
      _$TimetableFromJson(json);
}

@freezed
class TimetableFromJs with _$TimetableFromJs {
  const factory TimetableFromJs({
    required int year,
    required String term,
    required List<List<List<Subject>>> normal,
    required List<List<List<Subject>>> intensive,
  }) = _TimetableFromJs;

  factory TimetableFromJs.fromJson(Map<String, dynamic> json) =>
      _$TimetableFromJsFromJson(json);
}

final timetableProvider = sharedPreferencesProvider<Timetable?>(
  key: '_timetable',
  defaultValue: null,
  fromJson: Timetable.fromJson,
  toJson: (value) => value?.toJson(),
);
