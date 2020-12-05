import 'package:json_annotation/json_annotation.dart';

part 'learning_data.g.dart';

@JsonSerializable(nullable: true)
class Data {
  String name;
  String link;
  String linkavt;
  DateTime createTime;
  String source;
  String subject;
  String type;

  Data({this.name, this.link, this.linkavt, this.createTime, this.source, this.subject, this.type});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
