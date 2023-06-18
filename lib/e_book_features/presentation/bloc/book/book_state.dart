part of 'book_bloc.dart';

abstract class BookState extends Equatable {
  const BookState();

  @override
  List<Object> get props => [];
}

class BookInitial extends BookState {}

class LoadingBooksState extends BookState {}

class LoadedBooksState extends BookState {
  final List<BookModel> book;

  LoadedBooksState({required this.book});

  @override
  List<Object> get props => [book];
}

class ErrorBooksState extends BookState {
  final String message;

  ErrorBooksState({required this.message});

  @override
  List<Object> get props => [message];
}
