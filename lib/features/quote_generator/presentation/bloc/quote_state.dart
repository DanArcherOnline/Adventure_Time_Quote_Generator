part of 'quote_bloc.dart';

abstract class QuoteState extends Equatable {
  const QuoteState();
}

class QuoteEmpty extends QuoteState {
  @override
  List<Object> get props => [];
}

class QuoteLoading extends QuoteState {
  @override
  List<Object> get props => [];
}

class QuoteLoaded extends QuoteState {
  final Quote quote;

  QuoteLoaded({@required this.quote});

  @override
  List<Object> get props => [quote];
}

class QuoteError extends QuoteState {
  final String errorMessage;

  QuoteError({this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
