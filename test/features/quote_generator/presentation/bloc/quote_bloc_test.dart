import 'dart:convert';

import 'package:adventure_time_quote_generator/core/error/exceptions.dart';
import 'package:adventure_time_quote_generator/core/error/failures.dart';
import 'package:adventure_time_quote_generator/core/usecases/usecase.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/data/datasources/quote_local_data_source.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/data/datasources/quote_remote_data_source.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/data/models/quote_model.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/domain/entities/quote.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/domain/usecases/get_random_quote.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/presentation/bloc/quote_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MockGetRandomQuote extends Mock implements GetRandomQuote {}

main() {
  QuoteBloc quoteBloc;
  MockGetRandomQuote mockGetRandomQuote;

  setUp(() {
    mockGetRandomQuote = MockGetRandomQuote();
    quoteBloc = QuoteBloc(random: mockGetRandomQuote);
  });

  test('initial state should be empty', () {
    //assert
    expect(quoteBloc.initialState, equals(QuoteEmpty()));
  });

  group('GetRandomQuoteEvent', () {
    final tQuote = Quote(quote: 'its adventure time!', character: 'Finn');

    test(
      'should get data from the random use case',
      () async {
        //arrange
        when(mockGetRandomQuote(any)).thenAnswer((_) async => Right(tQuote));
        //act
        quoteBloc.add(GetRandomQuoteEvent());
        await untilCalled(mockGetRandomQuote(any));
        //assert
        verify(mockGetRandomQuote(NoParams()));
      },
    );

    test(
      'should emit [Empty, Loading, Loaded] when data is retrieved successfuly',
      () async {
        //arrange
        when(mockGetRandomQuote(any)).thenAnswer((_) async => Right(tQuote));
        //assert later
        final expected = [
          QuoteEmpty(),
          QuoteLoading(),
          QuoteLoaded(quote: tQuote)
        ];
        expectLater(quoteBloc, emitsInOrder(expected));
        //act
        quoteBloc.add(GetRandomQuoteEvent());
      },
    );

    test(
      'should emit [Empty, Loading, Error] when data is NOT retrieved successfuly',
      () async {
        //arrange
        when(mockGetRandomQuote(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        //assert later
        final expected = [
          QuoteEmpty(),
          QuoteLoading(),
          QuoteError(errorMessage: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(quoteBloc, emitsInOrder(expected));
        //act
        quoteBloc.add(GetRandomQuoteEvent());
      },
    );

    test(
      'should emit [Empty, Loading, Error] when cached data is NOT retrieved successfuly',
      () async {
        //arrange
        when(mockGetRandomQuote(any))
            .thenAnswer((_) async => Left(CacheFailure()));
        //assert later
        final expected = [
          QuoteEmpty(),
          QuoteLoading(),
          QuoteError(errorMessage: CACHE_FAILURE_MESSAGE),
        ];
        expectLater(quoteBloc, emitsInOrder(expected));
        //act
        quoteBloc.add(GetRandomQuoteEvent());
      },
    );
  });
}
