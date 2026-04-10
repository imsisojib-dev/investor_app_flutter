import 'package:dartz/dartz.dart';
import 'package:investor_app_flutter/src/core/errors/failures.dart';

abstract interface class IUseCase<TUseCaseInput, TUseCaseOutput> {
  Future<Either<Failure, TUseCaseOutput>> execute(TUseCaseInput input);
}
