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
    final ThemeData theme = ThemeData(primaryColor: Colors.blue.shade600);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Number Trivia',
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          secondary: Colors.blue.shade400,
        ),
      ),
      home: NumberTriviaPage(),
    );
  }
}
