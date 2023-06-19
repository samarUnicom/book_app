import 'package:bloc/bloc.dart';
import 'package:book_app/e_book_features/data/models/book_model.dart';
import 'package:book_app/e_book_features/data/models/commit_model.dart';
import 'package:book_app/e_book_features/domain/usecases/book_usecase.dart';
import 'package:book_app/e_book_features/domain/usecases/commit_usecase.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
part 'commit_event.dart';
part 'commit_state.dart';

class CommitBloc extends Bloc<CommitEvent, CommitState> {
  final CommitUseCase getAllCommits;
  final AddCommitUseCase addCommitUseCase;
  final InitialCommitUseCase initialCommitUseCase;
  CommitBloc({
    required this.getAllCommits,
    required this.addCommitUseCase,
    required this.initialCommitUseCase,
  }) : super(CommitInitial()) {
    on<CommitEvent>((event, emit) async {
      if (event is GetBookCommitsEvent) {
        emit(LoadingCommitState());
        print("im in");
        final failureOrBooks = await getAllCommits(event.book_id);
        print("im in in");
        emit(_mapFailureOrBooksToState(failureOrBooks));
      } else if (event is AddCommitEvent) {
        emit(LoadingAddCommitState());

        final failureOrDoneMessage =
            await addCommitUseCase.call(event.commitModel);

        emit(_eitherDoneMessageOrErrorState(failureOrDoneMessage, "Done"));
      } /*else if (event is GetCommitsEvent) {
        print("fgsoiosieru");
        emit(LoadingCommitState());
        final failureOrBooks = await initialCommitUseCase(event.comments);
        emit(
            _eitherDoneMessageOrErrorState(failureOrBooks, "done insert data"));
      }*/
    });
  }

  CommitState _mapFailureOrBooksToState(
      Either<Failure, List<CommitModel>> either) {
    return either.fold(
      (failure) => ErrorCommitState(message: _mapFailureToMessage(failure)),
      (data) => LoadedCommitState(
        commit: data,
      ),
    );
  }

  CommitState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorAddCommitState(
        message: _mapFailureToMessage(failure),
      ),
      (_) => MessageAddCommitState(message: message),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
