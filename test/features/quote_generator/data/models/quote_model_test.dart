import 'dart:convert';

import 'package:adventure_time_quote_generator/features/quote_generator/data/models/quote_model.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/domain/entities/quote.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

main() {
  final tQuoteModel =
      QuoteModel(quote: 'its adventure time!', character: 'Finn');

  group('QuoteModel', () {
    test(
      'should be a subclass of Quote entity',
      () async {
        //assert
        expect(tQuoteModel, isA<Quote>());
      },
    );
  });

  group('fromAdventureTimeQuoteApiText', () {
    test(
      'should return a valid model',
      () async {
        //arrange
        final String quoteText = json.decode(fixture('quote.json'));
        print('quoteText: ${quoteText}');
        //act
        final result = QuoteModel.fromAdventureTimeQuoteApiText(quoteText);
        print('result: ${result}');
        //assert
        expect(result, tQuoteModel);
      },
    );
  });

  group('toAdventureTimeQuoteApiText', () {
    test(
      'should return text in the correct format with correct data',
      () async {
        //act
        final result = tQuoteModel.toAdventureTimeQuoteApiText();
        //assert
        final expectedAdventureTimeQuoteApiText = '"Finn: its adventure time!"';
        expect(result, expectedAdventureTimeQuoteApiText);
      },
    );
  });
}
