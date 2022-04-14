import 'dart:convert';

import 'package:numbertrivia/core/error/exceptions.dart';
import 'package:numbertrivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class NumberTriviaRemoteDatasource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel>? getConcreteNumberTrivia(int number);

  /// Calls the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel>? getRandomNumberTrivia();
}

class NumberTriviaRemoteDatasourceImpl implements NumberTriviaRemoteDatasource {
  late http.Client client;
  NumberTriviaRemoteDatasourceImpl({required this.client});

  @override
  Future<NumberTriviaModel>? getConcreteNumberTrivia(int number) async {
    final response = await client.get(
      Uri.parse("http://numbersapi.com/$number"),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200)
      return NumberTriviaModel.fromJson(json.decode(response.body));
    else {
      throw ServerException();
    }
  }

  @override
  Future<NumberTriviaModel>? getRandomNumberTrivia() async {
    final response = await client.get(
      Uri.parse("http://numbersapi.com/random"),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200)
      return NumberTriviaModel.fromJson(json.decode(response.body));
    else {
      throw ServerException();
    }
  }
}
