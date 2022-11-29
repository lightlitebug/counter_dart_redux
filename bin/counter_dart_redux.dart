import 'package:redux/redux.dart';

class CounterState {
  final int counter;
  const CounterState({
    required this.counter,
  });

  factory CounterState.initial() {
    return CounterState(counter: 0);
  }

  @override
  String toString() {
    return 'CounterState(counter: $counter)';
  }

  CounterState copyWith({
    int? counter,
  }) {
    return CounterState(
      counter: counter ?? this.counter,
    );
  }
}

class IncrementAction {
  final int payload;
  const IncrementAction({
    required this.payload,
  });

  @override
  String toString() => 'IncrementAction(payload: $payload)';
}

class DecrementAction {
  final int payload;
  const DecrementAction({
    required this.payload,
  });

  @override
  String toString() => 'DecrementAction(payload: $payload)';
}

CounterState counterReducer(CounterState state, dynamic action) {
  if (action is IncrementAction) {
    return state.copyWith(counter: state.counter + action.payload);
  } else if (action is DecrementAction) {
    return state.copyWith(counter: state.counter - action.payload);
  }
  return state;
}

void main() async {
  final store = Store<CounterState>(
    counterReducer,
    initialState: CounterState.initial(),
  );

  final subscription = store.onChange.listen((CounterState state) {
    print('current state: $state');
  });

  store.dispatch(IncrementAction(payload: 2));
  store.dispatch(IncrementAction(payload: 3));
  await Future.delayed(const Duration(seconds: 1));
  store.dispatch(DecrementAction(payload: 10));
  await Future.delayed(const Duration(seconds: 0));

  subscription.cancel();
}
