import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Quote extends Equatable {
  final String quote;
  final String character;

  Quote({
    @required this.quote,
    @required this.character,
  });

  @override
  List<Object> get props => [quote, character];

  @override
  bool get stringify => true;
}
