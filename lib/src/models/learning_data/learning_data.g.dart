// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    name: json['name'] as String,
    link: json['link'] as String,
    linkavt: json['linkavt'] as String,
    createTime: json['createTime'] == null ? null : DateTime.parse(json['createTime'] as String),
    source: json['source'] as String,
    subject: json['subject'] as String,
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'name': instance.name,
      'link': instance.link,
      'linkavt': instance.linkavt,
      'createTime': instance.createTime?.toIso8601String(),
      'source': instance.source,
      'subject': instance.subject,
      'type': instance.type,
    };
