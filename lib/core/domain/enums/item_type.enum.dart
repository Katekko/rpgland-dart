import 'package:json_annotation/json_annotation.dart';

enum ItemType {
  @JsonValue('Currency')
  currency,
  @JsonValue('HealthPotion')
  healthPotion,
  @JsonValue('Weapon')
  weapon,
}
