import 'package:adventure_time_quote_generator/features/quote_generator/domain/entities/quote.dart';
import 'package:flutter/material.dart';

class QuoteModel extends Quote {
  QuoteModel({
    @required String quote,
    @required String character,
  }) : super(quote: quote, character: character);

  factory QuoteModel.fromAdventureTimeQuoteApiText(String quoteText) {
    int seperatorIndex = quoteText.indexOf(':');
    String quote = quoteText.substring(seperatorIndex + 1).trim();
    String character = quoteText.substring(0, seperatorIndex).trim();

    return QuoteModel(
      quote: quote,
      character: character,
    );
  }

  String toAdventureTimeQuoteApiText() {
    return '"${this.character}: ${this.quote}"';
  }
}
