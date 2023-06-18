part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class LoadingUserState extends UserState {}

class LoadedUserState extends UserState {
  final UserModel user;

  LoadedUserState({required this.user});

  @override
  List<Object> get props => [user];
}

class ErrorUserState extends UserState {
  final String message;

  ErrorUserState({required this.message});

  @override
  List<Object> get props => [message];
}

class LoadingStoreUserState extends UserState {}

class ErrorStoreUserState extends UserState {
  final String message;

  ErrorStoreUserState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageStoreUserState extends UserState {
  final String message;

  MessageStoreUserState({required this.message});

  @override
  List<Object> get props => [message];
}
