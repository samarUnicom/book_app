part of 'book_bloc.dart';

abstract class BookEvent extends Equatable {
  const BookEvent();

  @override
  List<Object> get props => [];
}

class GetAllBooksEvent extends BookEvent {}

class RefreshBooksEvent extends BookEvent {}
