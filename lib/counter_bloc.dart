import 'dart:async'; // to use the streams
import 'counter_events.dart';

// main variables
// stream controllers

class CounterBloc {

  /// declare main variables
  int _counter = 0; // the variables which are going to change the state

  /// create stream controller
  /// the stream controller is like a box with 2 holes, onw for the input(sink)(event) and the other for the output (stream)(state)
  final _counterStateController = StreamController<int>(); //private
  StreamSink<int> get _inCounter => _counterStateController.sink; //input an event //private
  Stream<int> get counter => _counterStateController.stream; //output a state //public

  /// make a way to the UI to send events --> through this event controller
  /// the UI will send only inputs (events) to the EventController
  final _counterEventsController = StreamController<CounterEvents>();
  Sink<CounterEvents> get counterEventSink => _counterEventsController.sink; //inputs events

  /// Constructor
  /// /// map every coming event into a state
  /// listen to the output of the event stream to check if there is events
  /// if there are events map them into a state
  CounterBloc() {
    _counterEventsController.stream.listen(_mapEventToState);
  }

  /// _mapEventToState Method
  void _mapEventToState (CounterEvents event) {
    // conditions as per events
    if (event is IncrementEvent) _counter++; //State
    if (event is DecrementEvent) _counter--; //State
    /// add the new counter value to the _counterStateController Sink
    _inCounter.add(_counter);
  }

  /// to avoid memory leak
  void dispose() {
    _counterStateController.close();
    _counterEventsController.close();
  }
}