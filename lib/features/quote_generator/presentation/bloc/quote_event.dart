part of 'quote_bloc.dart';

abstract class QuoteEvent extends Equatable {
  @override
  List<Object> get props => null;
}

class GetRandomQuoteEvent extends QuoteEvent {}
