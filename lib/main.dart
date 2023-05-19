import 'package:clean_archi_flutter_app/features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'package:flutter/material.dart';
import 'injection_container.dart' as dep_inj;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep_inj.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Number Trivia',
        theme: ThemeData.dark(),
        home: const NumberTriviaPage());
  }
}
