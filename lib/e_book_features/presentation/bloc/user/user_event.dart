part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUserEvent extends UserEvent {

}

class StoreUserEvent extends UserEvent {
  final UserModel userModel;

  StoreUserEvent({required this.userModel});

  @override
  List<Object> get props => [userModel];
}

