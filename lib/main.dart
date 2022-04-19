import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numbertrivia/features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'package:numbertrivia/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themee = ThemeData(
      primaryColor: Colors.orange.shade800,
      brightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Number Trivia',
      theme: themee.copyWith(
        colorScheme: themee.colorScheme.copyWith(
          secondary: Colors.orange.shade600,
        ),
      ),
      home: NumberTriviaPage(),
    );
  }
}
