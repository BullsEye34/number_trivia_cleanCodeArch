import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numbertrivia/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

class TriviaControls extends StatefulWidget {
  const TriviaControls({
    Key? key,
  }) : super(key: key);

  @override
  State<TriviaControls> createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  late TextEditingController textEditingController =
      new TextEditingController();
  late String inputString;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (value) {
            inputString = value;
          },
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          controller: textEditingController,
          onSubmitted: (value) => addConcrete(),
          decoration: InputDecoration(
            hintText: "Input a number!",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            suffixIcon: const Icon(Icons.search),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ButtonStyle(
                    textStyle: MaterialStateProperty.all<TextStyle>(
                        TextStyle(color: Colors.white)),
                    elevation: MaterialStateProperty.all<double>(0),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).colorScheme.secondary)),
                onPressed: addConcrete,
                child: const Text(
                  "Search",
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: OutlinedButton(
                style: ButtonStyle(
                  textStyle: MaterialStateProperty.all<TextStyle>(
                      TextStyle(color: Colors.white)),
                  elevation: MaterialStateProperty.all<double>(0),
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.secondary),
                ),
                onPressed: addRandom,
                child: const Text(
                  "Get Random Trivia",
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  void addConcrete() {
    textEditingController.clear();
    BlocProvider.of<NumberTriviaBloc>(context)
        .add(GetTriviaForConcreteNumber(inputString));
  }

  void addRandom() {
    BlocProvider.of<NumberTriviaBloc>(context).add(GetTriviaForRandomNumber());
  }
}
