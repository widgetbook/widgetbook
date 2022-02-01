import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'translate_state.freezed.dart';

@freezed
class TranslateState with _$TranslateState {
  factory TranslateState({
    @Default(Offset.zero) Offset offset,
  }) = _TranslateState;
}
