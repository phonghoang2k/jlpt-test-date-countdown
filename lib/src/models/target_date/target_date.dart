import 'package:json_annotation/json_annotation.dart';

part 'target_date.g.dart';

@JsonSerializable(nullable: true)
class TargetDate {
  String name;
  DateTime date;
  String id;

  TargetDate({this.name, this.date, this.id});

  factory TargetDate.fromJson(Map<String, dynamic> json) => _$TargetDateFromJson(json);

  Map<String, dynamic> toJson() => _$TargetDateToJson(this);
}
