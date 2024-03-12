import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'connectivity_event.dart';

part 'connectivity_state.dart';

late StreamSubscription<ConnectivityResult> _connectivitySubscription;

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  ConnectivityBloc() : super(ConnectivityInitial()) {
    on<CheckConnectivityET>(connectivityMethod);
  }

  FutureOr<void> connectivityMethod(
      CheckConnectivityET event, Emitter<ConnectivityState> emit) async {
    dataListener();
  }

  Future<void> dataListener() async {
    try {
      _connectivitySubscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        if (result == ConnectivityResult.none) {
          await Future.delayed(const Duration(milliseconds: 500));
          emit(NoConnectionST());
        } else {
          await Future.delayed(const Duration(milliseconds: 500));
          emit(ConnectedST());
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }
//
// void _updateConnection(ConnectivityResult connectivityResult) {
//   if (connectivityResult == ConnectivityResult.none) {
//     emit(NoConnectionST());
//   } else {
//     emit(ConnectedST());
//   }
// }
}
