import 'package:bloc/bloc.dart';
import 'package:learning_provider/counterapp/counter_event.dart';
import 'package:learning_provider/counterapp/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(state: 0));

  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    switch (event.runtimeType) {
      case Increasement:
        print("==> increase ${event.number}");
        yield CounterState(state: state.state + event.number);
        break;
      case Decreasement:
        print("==> decrease ${event.number}");
        yield CounterState(state: state.state - event.number);
        break;
    }
  }
}
