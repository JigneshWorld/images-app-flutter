import 'package:bloc/bloc.dart';
import 'package:fimber/fimber.dart';

/// common bloc observer to listen events, change state, transitions and errors
class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(Cubit cubit, Change change) {
    Fimber.i('${cubit.runtimeType} $change');
    super.onChange(cubit, change);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    Fimber.e('${cubit.runtimeType}', ex: error, stacktrace: stackTrace);
    super.onError(cubit, error, stackTrace);
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    Fimber.i('${bloc.runtimeType} $event');
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    Fimber.i('${bloc.runtimeType} $transition');
    super.onTransition(bloc, transition);
  }
}
