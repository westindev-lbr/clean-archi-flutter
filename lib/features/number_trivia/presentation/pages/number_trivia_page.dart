import 'package:clean_archi_flutter_app/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../widgets/widgets.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NumberTrivia'),
      ),
      body: SingleChildScrollView(child: buildBody(context)),
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
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  if (state is EmptyState) {
                    return const MessageDisplay(
                        message: "Démarrer la recherche!", errOrEmpty: false);
                  } else if (state is LoadingState) {
                    return const LoadingWidget();
                  } else if (state is LoadedState) {
                    return TriviaDisplay(numberTrivia: state.trivia);
                  } else if (state is ErrorState) {
                    return MessageDisplay(
                      message: state.message,
                      errOrEmpty: true,
                    );
                  }
                  return const Placeholder();
                },
              ),

              const SizedBox(height: 20),
              const TriviaControls()
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
