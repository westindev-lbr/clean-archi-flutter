import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/number_trivia_bloc.dart';

class TriviaControls extends StatefulWidget {
  const TriviaControls({
    super.key,
  });

  @override
  State<TriviaControls> createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  final controller = TextEditingController();
  late String inputStr;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
              border: OutlineInputBorder(), hintText: 'Entrer un nombre'),
          onChanged: (value) {
            inputStr = value;
          },
          onSubmitted: (_) => addConcrete(),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
              onPressed: addConcrete,
              child: const Text(
                'Recherche',
                style: TextStyle(color: Colors.black),
              ),
            )),
            const SizedBox(width: 10),
            Expanded(
                child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
              onPressed: addRandom,
              child: const Text(
                'Aléatoire',
                style: TextStyle(color: Colors.black),
              ),
            ))
          ],
        )
      ],
    );
  }

  void addConcrete() {
    controller.clear();
    /* BlocProvider.of<NumberTriviaBloc>(context)
        .add(GetTriviaForConcreteNumber(inputStr)); */
    context.read<NumberTriviaBloc>().add(GetTriviaForConcreteNumber(inputStr));
  }

  void addRandom() {
    controller.clear();
    context.read<NumberTriviaBloc>().add(GetTriviaForRandomNumber());
  }
}
