import 'package:json_annotation/json_annotation.dart';

enum PlayerState {
  @JsonValue('Idle')
  idle,
  @JsonValue('Hunting')
  hunting,
}
