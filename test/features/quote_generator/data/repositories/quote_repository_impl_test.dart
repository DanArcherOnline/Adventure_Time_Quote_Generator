import 'package:adventure_time_quote_generator/core/error/exceptions.dart';
import 'package:adventure_time_quote_generator/core/error/failures.dart';
import 'package:adventure_time_quote_generator/core/network/network_info.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/data/datasources/quote_local_data_source.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/data/repositories/quote_repository_impl.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/domain/entities/quote.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/data/datasources/quote_remote_data_source.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/data/models/quote_model.dart';

class MockRemoteDataSource extends Mock implements QuoteRemoteDataSource {}

class MockLocalDataSource extends Mock implements QuoteLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

main() {
  QuoteRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = QuoteRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Function body) {
    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group('getRandomQuote', () {
    final tQuoteModel =
        QuoteModel(quote: 'its adventure time!', character: 'Finn');
    final Quote tQuote = tQuoteModel;
    test(
      'should check if the device is online',
      () async {
        //arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        //act
        repository.getRandomQuote();
        //assert
        verify(mockNetworkInfo.isConnected);
      },
    );
    runTestsOnline(() {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test(
        'should return remote data when the call is successful',
        () async {
          //arrange
          when(mockRemoteDataSource.getRandomQuote())
              .thenAnswer((_) async => tQuoteModel);
          //act
          final result = await repository.getRandomQuote();
          //assert
          verify(mockRemoteDataSource.getRandomQuote());
          expect(result, equals(Right(tQuote)));
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          //arrange
          when(mockRemoteDataSource.getRandomQuote())
              .thenAnswer((_) async => tQuoteModel);
          //act
          await repository.getRandomQuote();
          //assert
          verify(mockRemoteDataSource.getRandomQuote());
          verify(mockLocalDataSource.cacheQuote(tQuoteModel));
        },
      );

      test(
        'should return ServerFailure when the call is unsuccessful',
        () async {
          //arrange
          when(mockRemoteDataSource.getRandomQuote())
              .thenThrow(ServerException());
          //act
          var result = await repository.getRandomQuote();
          //assert
          verify(mockRemoteDataSource.getRandomQuote());
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
        'should return last locally cached data when the cached data is present',
        () async {
          //arrange
          when(mockLocalDataSource.getLastQuote())
              .thenAnswer((_) async => tQuoteModel);
          //act
          final result = await repository.getRandomQuote();
          //assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastQuote());
          expect(result, equals(Right(tQuote)));
        },
      );

      test(
        'should return CachFailure when there is no cached data present',
        () async {
          //arrange
          when(mockLocalDataSource.getLastQuote()).thenThrow(CacheException());
          //act
          final result = await repository.getRandomQuote();
          //assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastQuote());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });
}
