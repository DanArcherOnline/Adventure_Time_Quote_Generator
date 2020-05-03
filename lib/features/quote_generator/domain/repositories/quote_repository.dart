import 'package:adventure_time_quote_generator/core/error/failures.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/domain/entities/quote.dart';
import 'package:dartz/dartz.dart';

abstract class QuoteRepository {
  Future<Either<Failure, Quote>> getRandomQuote();
}
