import 'package:injectable/injectable.dart';

import 'exceptions.dart';
import 'failures.dart';

@lazySingleton
class ErrorHandler {
  Failure handle(dynamic error) {
    if (error is AppException) return _fromException(error);
    return const UnknownFailure();
  }

  Failure _fromException(AppException e) {
    return switch (e) {
      // Network
      NetworkException() => NetworkFailure(message: e.message),
      TimeoutException() => TimeoutFailure(message: e.message),
      RequestCancelledException() => NetworkFailure(message: e.message),

      // HTTP
      UnauthorizedException() => UnauthorizedFailure(message: e.message),
      ForbiddenException() => ForbiddenFailure(message: e.message),
      NotFoundException() => NotFoundFailure(message: e.message),
      ValidationException() => ValidationFailure(message: e.message, errors: e.errors),
      BadRequestException() => ServerFailure(message: e.message),
      TooManyRequestsException() => ServerFailure(message: e.message),
      ServerException() => ServerFailure(message: e.message),

      // Cache
      CacheNotFoundException() => CacheNotFoundFailure(message: e.message),
      CacheExpiredException() => CacheExpiredFailure(message: e.message),
      CacheException() => CacheFailure(message: e.message),

      // Auth
      TokenExpiredException() => TokenExpiredFailure(message: e.message),
      RefreshTokenExpiredException() => SessionExpiredFailure(message: e.message),

      // Storage
      StorageReadException() => StorageFailure(message: e.message),
      StorageWriteException() => StorageFailure(message: e.message),
      StorageException() => StorageFailure(message: e.message),

      // Media
      FileSizeExceededException() => FileSizeExceededFailure(message: e.message),
      InvalidFileTypeException() => InvalidFileTypeFailure(message: e.message),

      // Permission
      PermissionPermanentlyDeniedException() => PermissionPermanentlyDeniedFailure(message: e.message),
      PermissionDeniedException() => PermissionDeniedFailure(message: e.message),

      // Payment
      PaymentCancelledException() => PaymentCancelledFailure(message: e.message),
      PaymentFailedException() => PaymentFailedFailure(message: e.message),

      // fallback
      _ => UnknownFailure(message: e.message),
    };
  }
}
