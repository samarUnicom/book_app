part of 'commit_bloc.dart';

abstract class CommitState extends Equatable {
  const CommitState();

  @override
  List<Object> get props => [];
}

class CommitInitial extends CommitState {}

class LoadingCommitState extends CommitState {}

class LoadedCommitState extends CommitState {
  final List<CommitModel> commit;

  LoadedCommitState({required this.commit});

  @override
  List<Object> get props => [commit];
}

class ErrorCommitState extends CommitState {
  final String message;

  ErrorCommitState({required this.message});

  @override
  List<Object> get props => [message];
}

class LoadingAddCommitState extends CommitState {}

class ErrorAddCommitState extends CommitState {
  final String message;

  ErrorAddCommitState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageAddCommitState extends CommitState {
  final String message;

  MessageAddCommitState({required this.message});

  @override
  List<Object> get props => [message];
}
