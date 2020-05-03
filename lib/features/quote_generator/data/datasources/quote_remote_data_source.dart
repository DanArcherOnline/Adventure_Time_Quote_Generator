import 'dart:convert';

import 'package:adventure_time_quote_generator/core/error/exceptions.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/data/models/quote_model.dart';
import 'package:http/http.dart' as http;

abstract class QuoteRemoteDataSource {
  ///Calls the https://adventure-time-quote-api.glitch.me/api/random endpoint
  ///
  ///Throws a [ServerException] for all error codes
  Future<QuoteModel> getRandomQuote();
}

class QuoteRemoteDataSourceImpl implements QuoteRemoteDataSource {
  final http.Client client;

  QuoteRemoteDataSourceImpl({this.client});

  @override
  Future<QuoteModel> getRandomQuote() async {
    final response = await client
        .get('https://adventure-time-quote-api.glitch.me/api/random');
    if (response.statusCode == 200) {
      return QuoteModel.fromAdventureTimeQuoteApiText(
          json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
