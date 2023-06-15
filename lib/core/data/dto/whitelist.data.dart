import 'package:json_annotation/json_annotation.dart';
import 'package:rpgland/core/domain/abstractions/models/data.model.dart';

part 'whitelist.data.g.dart';

@JsonSerializable()
class WhitelistData extends DataModel {
  final String? number;
  final bool allow;
  final String? telegramId;

  WhitelistData({
    required super.id,
    required this.number,
    required this.allow,
    required this.telegramId,
  });

  factory WhitelistData.fromJson(Map<String, dynamic> json) =>
      _$WhitelistDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WhitelistDataToJson(this);
}
