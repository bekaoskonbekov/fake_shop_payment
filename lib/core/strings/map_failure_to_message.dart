import '../error/failures.dart';
import 'failures.dart';

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return serverFailureMessage;
    case EmptyCacheFailure:
      return emptyCacheFailureMessage;
    case OfflineFailure:
      return offlineFailureMessage;
    default:
      return "Unexpected Error , Please try again later .";
  }
}