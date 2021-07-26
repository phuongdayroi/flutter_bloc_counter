import 'dart:async';

enum CounterAction { Increment, Decrement, Reset }

class CounterBloc {
  int counter = 0;
  final stateStreamController = StreamController<int>();
  StreamSink<int> get counterSink => stateStreamController.sink; // input
  Stream<int> get counterStream => stateStreamController.stream; // output

  final eventStreamController = StreamController<CounterAction>();
  StreamSink<CounterAction> get eventSink =>
      eventStreamController.sink; // input
  Stream<CounterAction> get eventStream =>
      eventStreamController.stream; // output

  CounterBloc() {
    counterSink.add(0);

    eventStream.listen((event) {
      if (event == CounterAction.Increment) counter++;
      if (event == CounterAction.Decrement) counter--;
      if (event == CounterAction.Reset) counter = 0;

      counterSink.add(counter);
    });
  }
}
