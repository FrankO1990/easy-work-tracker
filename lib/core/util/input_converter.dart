import 'package:dartz/dartz.dart';
import 'package:franks_invoice_tool/core/errors/failure.dart';

class InputConverter {
  Either<Failure, int> convertStringToUnsignedInt(String stringInput) {
    try {
      final int result = int.parse(stringInput);
      if (result < 0) {
        return Left(InvalidInputFailure());
      } else {
        return Right(result);
      }
    } catch (exception) {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {
  @override
  List<Object?> get props => [];
}
