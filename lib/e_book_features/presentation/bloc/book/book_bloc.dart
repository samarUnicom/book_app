import 'package:bloc/bloc.dart';
import 'package:book_app/e_book_features/data/models/book_model.dart';
import 'package:book_app/e_book_features/domain/usecases/book_usecase.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookUseCase getAllBooks;
  BookBloc({
    required this.getAllBooks,
  }) : super(BookInitial()) {
    on<BookEvent>((event, emit) async {
      if (event is GetAllBooksEvent) {
        emit(LoadingBooksState());
        print("fgsoiosieru22");
        final failureOrBooks = await getAllBooks();
        emit(_mapFailureOrBooksToState(failureOrBooks));
      } else if (event is RefreshBooksEvent) {
        emit(LoadingBooksState());

        final failureOrBooks = await getAllBooks();
        emit(_mapFailureOrBooksToState(failureOrBooks));
      }
    });
  }

  BookState _mapFailureOrBooksToState(Either<Failure, List<BookModel>> either) {
    return either.fold(
      (failure) => ErrorBooksState(message: _mapFailureToMessage(failure)),
      (data) => LoadedBooksState(
        book: data,
      ),
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
