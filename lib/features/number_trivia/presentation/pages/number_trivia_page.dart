import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numbertrivia/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:numbertrivia/injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Number Trivia'),
        centerTitle: true,
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(context) {
    return BlocProvider(
      create: (context) => sl<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // Top Half
              SizedBox(
                height: 10,
              ),

              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  if (state is Empty) {
                    return MessageDisplay(
                      message: "Start Searching",
                    );
                  }
                  return Container(
                    height: MediaQuery.of(context).size.height / 2.5,
                    child: Placeholder(),
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              // Bottom Half
              Column(
                children: [
                  Placeholder(
                    fallbackHeight: 50,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Placeholder(
                          fallbackHeight: 100,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Placeholder(
                          fallbackHeight: 100,
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MessageDisplay extends StatelessWidget {
  final String message;
  const MessageDisplay({
    required this.message,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      child: Text(
        message,
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}
