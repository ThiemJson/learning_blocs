import 'dart:async';

import 'package:learning_provider/remote_event.dart';
import 'package:learning_provider/remote_state.dart';

class RemoteBloc {
  var state = RemoteState(70);
  // ignore: close_sinks
  final eventController = StreamController<RemoteEvent>();
  // ignore: close_sinks
  final stateController = StreamController<RemoteState>();

  RemoteBloc() {
    this.eventController.stream.listen((RemoteEvent event) {
      if (event is IncreaseVolumn) {
        this.state = RemoteState(this.state.volumn + event.increaseVolumn);
      } else if (event is DecreaseVolumn) {
        this.state = RemoteState(this.state.volumn - event.decreaseVolumn);
      } else if (event is MuteVolumn) {
        this.state = RemoteState(0);
      }

      this.stateController.sink.add(this.state);
    });
  }
  void dispose() {
    print("dispose");
    this.eventController.sink.close();
    this.stateController.sink.close();
  }
}
