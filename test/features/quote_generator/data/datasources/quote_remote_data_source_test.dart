import 'dart:convert';

import 'package:adventure_time_quote_generator/core/error/exceptions.dart';
import 'package:adventure_time_quote_generator/core/error/failures.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/data/datasources/quote_local_data_source.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/data/datasources/quote_remote_data_source.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/data/models/quote_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

main() {
  QuoteRemoteDataSourceImpl datasource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    datasource = QuoteRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response(fixture('quote.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any)).thenAnswer(
        (_) async => http.Response('I am a generic failure message', 404));
  }

  group('getRandomQuote', () {
    final tQuoteModel = QuoteModel.fromAdventureTimeQuoteApiText(
      json.decode(fixture('quote.json')),
    );
    test(
      'should perform a GET request on a URL with random quote being the endpoint',
      () async {
        //arrange
        setUpMockHttpClientSuccess200();
        //act
        await datasource.getRandomQuote();
        //assert
        verify(mockHttpClient
            .get('https://adventure-time-quote-api.glitch.me/api/random'));
      },
    );

    test(
      'should return QuoteModel when the repsonse is 200 (success)',
      () async {
        //arrange
        setUpMockHttpClientSuccess200();
        //act
        final result = await datasource.getRandomQuote();
        //assert
        expect(result, equals(tQuoteModel));
      },
    );

    test(
      'should throw a ServerException when the reosnse code is not 200',
      () async {
        //arrange
        setUpMockHttpClientFailure404();
        //act
        final call = datasource.getRandomQuote;
        //assert
        expect(() => call(), throwsA(isA<ServerException>()));
      },
    );
  });
}
