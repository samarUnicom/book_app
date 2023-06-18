import 'package:bloc/bloc.dart';
import 'package:book_app/e_book_features/data/models/book_model.dart';
import 'package:book_app/e_book_features/data/models/commit_model.dart';
import 'package:book_app/e_book_features/data/models/user_model.dart';
import 'package:book_app/e_book_features/domain/usecases/book_usecase.dart';
import 'package:book_app/e_book_features/domain/usecases/commit_usecase.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/user_usecase.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserUseCase useCase;
  final AddUserUseCase addUserUseCase;

  UserBloc({
    required this.useCase,
    required this.addUserUseCase,
  }) : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is GetUserEvent) {
        emit(LoadingUserState());
        final failureOrBooks = await useCase();
        emit(_mapFailureOrUserToState(failureOrBooks));
      } else if (event is StoreUserEvent) {
        emit(LoadingStoreUserState());

        final failureOrDoneMessage = await addUserUseCase.call(event.userModel);

        emit(_eitherDoneMessageOrErrorState(failureOrDoneMessage, "Done"));
      }
    });
  }

  UserState _mapFailureOrUserToState(Either<Failure, UserModel> either) {
    return either.fold(
      (failure) => ErrorUserState(message: _mapFailureToMessage(failure)),
      (data) => LoadedUserState(
        user: data,
      ),
    );
  }

  UserState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorStoreUserState(
        message: _mapFailureToMessage(failure),
      ),
      (_) => MessageStoreUserState(message: message),
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
