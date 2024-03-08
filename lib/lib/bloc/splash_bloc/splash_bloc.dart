import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<NavigationEvent>(navigateMethod);
  }

  FutureOr<void> navigateMethod(
      NavigationEvent event, Emitter<SplashState> emit) async {
    await Future.delayed(const Duration(milliseconds: 3000), () {
      emit(SplashNavigateST());
    });
  }
}
