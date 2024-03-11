import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:speech_to_text/speech_to_text.dart';

part 'voice_event.dart';

part 'voice_state.dart';

SpeechToText? _speechToText;

String speechResult = '';

class VoiceBloc extends Bloc<VoiceEvent, VoiceState> {
  VoiceBloc() : super(VoiceInitial()) {
    _initSpeechToText();
    on<ListenToVoiceET>(listenToVoiceMethod);
  }

  void _initSpeechToText() {
    _speechToText = SpeechToText();
    _speechToText!.initialize(
      onError: (error) {
        log('Speech to text initialization error: $error');
        if (error.errorMsg == 'error_no_match' ||
            error.errorMsg == 'error_speech_timeout') {
          log('no voice heard');
          emit(VoiceErrorST());
        }
      },
      onStatus: (status) {
        log('Speech to text initialization status: $status');

        if (status == 'listening') {
          speechResult = '';
        }

        if (status == 'notListening') {
          emit(VoiceListeningST(isListening: false));
        }
        if (status == 'done') {
          emit(VoiceTextLoadedST(text: speechResult));
        }
      },
    );
  }

  FutureOr<void> listenToVoiceMethod(
      ListenToVoiceET event, Emitter<VoiceState> emit) {
    try {
      emit(VoiceListeningST(isListening: true));
      _speechToText!.listen(
        listenFor: const Duration(seconds: 5),
        onResult: (result) async {
          if (result.finalResult == true) {
            speechResult = result.recognizedWords;
          }
        },
      );
    } catch (e) {
      log(e.toString());
    }
  }
}
