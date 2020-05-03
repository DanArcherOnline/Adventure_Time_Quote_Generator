import 'dart:async';

import 'package:adventure_time_quote_generator/core/error/failures.dart';
import 'package:adventure_time_quote_generator/core/usecases/usecase.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/domain/entities/quote.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/domain/usecases/get_random_quote.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'quote_event.dart';
part 'quote_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  final GetRandomQuote getRandomQuote;

  QuoteBloc({@required GetRandomQuote random})
      : assert(random != null),
        getRandomQuote = random;

  @override
  QuoteState get initialState => QuoteEmpty();

  @override
  Stream<QuoteState> mapEventToState(
    QuoteEvent event,
  ) async* {
    if (event is GetRandomQuoteEvent) {
      yield QuoteLoading();
      await Future.delayed(Duration(milliseconds: 500));
      final failOrQuote = await getRandomQuote(NoParams());
      yield failOrQuote.fold(
        (failure) => QuoteError(errorMessage: _mapFailureToMessage(failure)),
        (quote) => QuoteLoaded(quote: quote),
      );
    }
  }

  _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unknown Failure';
    }
  }
}
