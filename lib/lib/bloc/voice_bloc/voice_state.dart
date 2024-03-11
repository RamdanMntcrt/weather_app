part of 'voice_bloc.dart';

@immutable
abstract class VoiceState {}

class VoiceInitial extends VoiceState {}

class VoiceListeningST extends VoiceState {}

class VoiceTextLoadedST extends VoiceState {}

class VoiceErrorST extends VoiceState {}
