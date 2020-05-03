import 'package:adventure_time_quote_generator/core/error/failures.dart';
import 'package:adventure_time_quote_generator/core/usecases/usecase.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/domain/entities/quote.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/domain/repositories/quote_repository.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/domain/usecases/get_random_quote.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockQuoteRepository extends Mock implements QuoteRepository {}

main() {
  GetRandomQuote usecase;
  MockQuoteRepository mockQuoteRepository;

  setUp(() {
    mockQuoteRepository = MockQuoteRepository();
    usecase = GetRandomQuote(mockQuoteRepository);
  });

  final tQuote = Quote(quote: 'its adventure time!', character: 'Finn');

  group('getRandomQuote', () {
    test(
      'should get a quote from the repository',
      () async {
        //arrange
        when(mockQuoteRepository.getRandomQuote())
            .thenAnswer((_) async => Right(tQuote));
        //act
        final result = await usecase(NoParams());
        //assert
        expect(result, Right(tQuote));
        verify(mockQuoteRepository.getRandomQuote());
        verifyNoMoreInteractions(mockQuoteRepository);
      },
    );
  });
}
