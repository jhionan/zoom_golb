import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';

abstract class BaseBloc<IN extends BaseEvent, STATE extends BaseState> {
  Stream<STATE> get state$;
  StreamSink<IN> get inEvent;
  dispose();
}

abstract class Bloc<IN extends BaseEvent, STATE extends BaseState>
    implements BaseBloc<IN, STATE> {
  Bloc() {
    _eventSubscription = inEventStream$.listen(onData, onError: onError);
    _stateSubscription = state$.listen((event) {
      lastState = event;
    }, onError: onError);
  }
  STATE lastState;
  StreamSubscription<STATE> _stateSubscription;
  StreamSubscription<IN> _eventSubscription;

  @override
  Stream<STATE> get state$ => stateController.stream;
  @override
  StreamSink<IN> get inEvent => inEventController.sink;
  Stream get inEventStream$ => inEventController.stream;

  StreamController<IN> inEventController = StreamController();
  BehaviorSubject<STATE> stateController = BehaviorSubject();

  @override
  @mustCallSuper
  dispose() {
    _eventSubscription?.cancel();
    _stateSubscription.cancel();
    inEventController.close();
    stateController.close();
  }

  onData(IN event);

  onError(Object error, StackTrace stackTrace) {
    print('Stream Error $error');
    print('STACK TRACE $stackTrace');
  }
}

mixin OutEvent<IN extends BaseEvent, STATE extends BaseState,
    OUT extends BaseOutEvent> on Bloc<IN, STATE> {
  StreamController<OUT> _outEventController = StreamController.broadcast();

  Stream<OUT> get outEvent => _outEventController.stream;

  void emitEvent(OUT event) {
    _outEventController.add(event);
  }

  @override
  dispose() {
    _outEventController.close();
    super.dispose();
  }
}

class BaseEvent {}

class BaseState {}

class BaseOutEvent {}
