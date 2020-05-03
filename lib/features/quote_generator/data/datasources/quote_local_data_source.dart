import 'dart:convert';

import 'package:adventure_time_quote_generator/core/error/exceptions.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/data/models/quote_model.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/domain/entities/quote.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class QuoteLocalDataSource {
  Future<QuoteModel> getLastQuote();
  Future<void> cacheQuote(QuoteModel quoteModel);
}

const String CACHED_QUOTE = 'CACHED_QUOTE';

class QuoteLocalDataSourceImpl implements QuoteLocalDataSource {
  final SharedPreferences sharedPreferences;

  QuoteLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<void> cacheQuote(QuoteModel quoteModel) {
    sharedPreferences.setString(
        CACHED_QUOTE, quoteModel.toAdventureTimeQuoteApiText());
    return Future.value();
  }

  @override
  Future<QuoteModel> getLastQuote() async {
    final String adventureTimeQuoteApiText =
        sharedPreferences.getString(CACHED_QUOTE);
    if (adventureTimeQuoteApiText != null) {
      final QuoteModel quoteModel = QuoteModel.fromAdventureTimeQuoteApiText(
          json.decode(adventureTimeQuoteApiText));
      return Future.value(quoteModel);
    } else {
      throw CacheException();
    }
  }
}
