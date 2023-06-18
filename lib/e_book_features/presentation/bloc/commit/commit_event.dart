part of 'commit_bloc.dart';

abstract class CommitEvent extends Equatable {
  const CommitEvent();

  @override
  List<Object> get props => [];
}

class GetBookCommitsEvent extends CommitEvent {
  final int book_id;
  GetBookCommitsEvent({required this.book_id});
}

class AddCommitEvent extends CommitEvent {
  final CommitModel commitModel;

  AddCommitEvent({required this.commitModel});

  @override
  List<Object> get props => [commitModel];
}

class GetCommitsEvent extends CommitEvent {
  final List<CommitModel> comments;

  GetCommitsEvent({required this.comments});
  @override
  List<Object> get props => [comments];
}
