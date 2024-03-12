part of 'connectivity_bloc.dart';

@immutable
abstract class ConnectivityState {}

class ConnectivityInitial extends ConnectivityState {}

class ConnectedST extends ConnectivityState {}

class NoConnectionST extends ConnectivityState {}
