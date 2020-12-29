// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'target_date.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TargetDate _$TargetDateFromJson(Map<String, dynamic> json) {
  return TargetDate(
    id: json['id'] as String,
    name: json['name'] as String,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  );
}

Map<String, dynamic> _$TargetDateToJson(TargetDate instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'date': instance.date?.toIso8601String(),
    };
