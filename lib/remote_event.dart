abstract class RemoteEvent {}

class IncreaseVolumn extends RemoteEvent {
  final int increaseVolumn;
  IncreaseVolumn(this.increaseVolumn);
}

class DecreaseVolumn extends RemoteEvent {
  final int decreaseVolumn;
  DecreaseVolumn(this.decreaseVolumn);
}

class MuteVolumn extends RemoteEvent {}
