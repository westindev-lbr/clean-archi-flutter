import 'package:clean_archi_flutter_app/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NumberTrivia'),
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              //top half
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: const Placeholder(),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  const Placeholder(
                    fallbackHeight: 40,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: const [
                      Expanded(
                        child: LeftButton(),
                      ),
                      SizedBox(width: 10),
                      Expanded(child: RightButton())
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

class RightButton extends StatelessWidget {
  const RightButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder(fallbackHeight: 30);
  }
}

class LeftButton extends StatelessWidget {
  const LeftButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder(fallbackHeight: 30);
  }
}
