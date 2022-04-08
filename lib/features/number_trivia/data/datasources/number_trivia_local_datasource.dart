import 'package:numbertrivia/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDatasource {
  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<NumberTriviaModel> getLastNumberTrivia();

  /// Saves the [NumberTriviaModel] to the cache.
  /// [NumberTriviaModel] is the number trivia which was gotten.
  /// Throws [CacheException] if the cache is full.
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}
