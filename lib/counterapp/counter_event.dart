abstract class CounterEvent {
  final int number;
  CounterEvent(this.number);
}

class Increasement extends CounterEvent {
  Increasement(int number) : super(number);
}

class Decreasement extends CounterEvent {
  Decreasement(int number) : super(number);
}
