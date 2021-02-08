import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_provider/counterapp/counter_bloc.dart';
import 'package:learning_provider/counterapp/counter_event.dart';
import 'package:learning_provider/counterapp/counter_state.dart';

class CounterApp extends StatefulWidget {
  @override
  _CounterAppState createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  @override
  Widget build(BuildContext context) {
    print("==> counter app builder");
    // ignore: close_sinks
    final CounterBloc bloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: () {
                  bloc.add(Increasement(20));
                },
                child: Text(
                  "+",
                  style: TextStyle(fontSize: 50),
                ),
              ),
              FloatingActionButton(
                onPressed: () {
                  bloc.add(Decreasement(2));
                },
                child: Text("-", style: TextStyle(fontSize: 50)),
              ),
              BlocBuilder<CounterBloc, CounterState>(
                buildWhen: (previousState, state) {
                  return true;
                },
                builder: (context, state) {
                  print("==> render Text");
                  return Text(
                    "This current state is: ${state.state}",
                    style: TextStyle(fontSize: 25),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
