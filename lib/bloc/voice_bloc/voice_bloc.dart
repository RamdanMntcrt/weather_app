import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';

part 'voice_event.dart';

part 'voice_state.dart';

SpeechToText? _speechToText;

String speechResult = '';

class VoiceBloc extends Bloc<VoiceEvent, VoiceState> {
  VoiceBloc() : super(VoiceInitial()) {
    on<ListenToVoiceET>(listenToVoiceMethod);
  }

  void initSpeechToText() {
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

        if (status == 'notListening') {}
        if (status == 'done') {}
      },
    );
  }

  FutureOr<void> listenToVoiceMethod(
      ListenToVoiceET event, Emitter<VoiceState> emit) async {
    PermissionStatus permission = await Permission.microphone.request();

    if (permission != PermissionStatus.granted) {
      log('granted');
    }

    initSpeechToText();

    await Future.delayed(const Duration(milliseconds: 1000));
    try {
      if (_speechToText != null) {
        emit(VoiceListeningST(isListening: true));
        await _speechToText!.listen(
          listenFor: const Duration(seconds: 5),
          onResult: (result) async {
            if (result.finalResult == true) {
              speechResult = result.recognizedWords;
              _resultHandler();
            }
          },
        );
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _resultHandler() async {
    await Future.delayed(const Duration(milliseconds: 100));
    emit(VoiceTextLoadedST(text: speechResult));
  }
}
