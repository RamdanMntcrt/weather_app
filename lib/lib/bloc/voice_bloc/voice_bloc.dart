import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:speech_to_text/speech_to_text.dart';

part 'voice_event.dart';

part 'voice_state.dart';

final SpeechToText _speechToText = SpeechToText();

bool _isMicEnabled = false;

class VoiceBloc extends Bloc<VoiceEvent, VoiceState> {
  VoiceBloc() : super(VoiceInitial()) {
    on<ListenToVoiceET>(listenToVoiceMethod);
  }

  FutureOr<void> listenToVoiceMethod(
      ListenToVoiceET event, Emitter<VoiceState> emit) async {
    emit(VoiceListeningST());

    _isMicEnabled = await _speechToText.initialize();
  }
}
