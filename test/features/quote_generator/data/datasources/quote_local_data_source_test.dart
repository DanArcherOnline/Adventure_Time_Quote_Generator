import 'dart:convert';

import 'package:adventure_time_quote_generator/core/error/exceptions.dart';
import 'package:adventure_time_quote_generator/core/error/failures.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/data/datasources/quote_local_data_source.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/data/models/quote_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

main() {
  QuoteLocalDataSourceImpl datasource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    datasource = QuoteLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getLastQuote', () {
    final tQuoteModel = QuoteModel.fromAdventureTimeQuoteApiText(
        json.decode(fixture('quote.json')));
    test(
      'should return Quote from SharedPreferences when there is one in the cache',
      () async {
        //arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(fixture('quote.json'));
        //act
        final result = await datasource.getLastQuote();
        //assert
        verify(mockSharedPreferences.getString(CACHED_QUOTE));
        expect(result, equals(tQuoteModel));
      },
    );

    test(
      'should throw a CacheException when there is not a cached value',
      () async {
        //arrange
        when(mockSharedPreferences.getString(any)).thenReturn(null);
        //act
        final call = datasource.getLastQuote();
        //assert
        verify(mockSharedPreferences.getString(CACHED_QUOTE));
        expect(() => call, throwsA(isA<CacheException>()));
      },
    );
  });

  group('cacheQuote', () {
    final tQuoteModel =
        QuoteModel(quote: 'its adventure time!', character: 'Finn');
    test(
      'should call shared preferences to cache the data',
      () async {
        //arrange
        final expectedCacheString = tQuoteModel.toAdventureTimeQuoteApiText();
        //act
        datasource.cacheQuote(tQuoteModel);
        //assert
        verify(
            mockSharedPreferences.setString(CACHED_QUOTE, expectedCacheString));
      },
    );
  });
}
