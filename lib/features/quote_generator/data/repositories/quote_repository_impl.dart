import 'package:adventure_time_quote_generator/core/error/exceptions.dart';
import 'package:adventure_time_quote_generator/core/error/failures.dart';
import 'package:adventure_time_quote_generator/core/network/network_info.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/data/datasources/quote_local_data_source.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/data/datasources/quote_remote_data_source.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/domain/entities/quote.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/domain/repositories/quote_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class QuoteRepositoryImpl extends QuoteRepository {
  final QuoteRemoteDataSource remoteDataSource;
  final QuoteLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  QuoteRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, Quote>> getRandomQuote() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteQuote = await remoteDataSource.getRandomQuote();
        localDataSource.cacheQuote(remoteQuote);
        return Right(remoteQuote);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localQuote = await localDataSource.getLastQuote();
        return Right(localQuote);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
