part of 'voice_bloc.dart';

@immutable
abstract class VoiceState {}

class VoiceInitial extends VoiceState {}

class VoiceListeningST extends VoiceState {
  final bool isListening;

  VoiceListeningST({required this.isListening});
}

class VoiceTextLoadedST extends VoiceState {
  final String text;

  VoiceTextLoadedST({required this.text});
}

class VoiceErrorST extends VoiceState {}
