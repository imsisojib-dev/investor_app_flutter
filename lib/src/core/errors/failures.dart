import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final String? code;

  const Failure({required this.message, this.code});

  @override
  List<Object?> get props => [message, code];
}

// ─── Network ──────────────────────────────────────────────────────────────────

class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'No internet connection.', super.code});
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({super.message = 'Request timed out.', super.code});
}

class ServerFailure extends Failure {
  const ServerFailure({super.message = 'Server error occurred.', super.code});
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({super.message = 'Unauthorized.', super.code});
}

class ForbiddenFailure extends Failure {
  const ForbiddenFailure({super.message = 'Access forbidden.', super.code});
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({super.message = 'Resource not found.', super.code});
}

class ValidationFailure extends Failure {
  final Map<String, dynamic>? errors;

  const ValidationFailure({super.message = 'Validation failed.', super.code, this.errors});

  String? fieldError(String field) {
    final fieldErrors = errors?[field];
    if (fieldErrors is List && fieldErrors.isNotEmpty) {
      return fieldErrors.first as String?;
    }
    return null;
  }

  @override
  List<Object?> get props => [message, code, errors];
}

// ─── Cache ────────────────────────────────────────────────────────────────────

class CacheFailure extends Failure {
  const CacheFailure({super.message = 'Cache error occurred.', super.code});
}

class CacheNotFoundFailure extends Failure {
  const CacheNotFoundFailure({super.message = 'No cached data found.', super.code});
}

class CacheExpiredFailure extends Failure {
  const CacheExpiredFailure({super.message = 'Cached data has expired.', super.code});
}

// ─── Auth ─────────────────────────────────────────────────────────────────────

class TokenExpiredFailure extends Failure {
  const TokenExpiredFailure({super.message = 'Session expired. Please login again.'});
}

class SessionExpiredFailure extends Failure {
  const SessionExpiredFailure({super.message = 'Session expired. Please login again.'});
}

// ─── Storage ──────────────────────────────────────────────────────────────────

class StorageFailure extends Failure {
  const StorageFailure({super.message = 'Storage error occurred.', super.code});
}

// ─── Media ────────────────────────────────────────────────────────────────────

class FileSizeExceededFailure extends Failure {
  const FileSizeExceededFailure({super.message = 'File size limit exceeded.', super.code});
}

class InvalidFileTypeFailure extends Failure {
  const InvalidFileTypeFailure({super.message = 'Invalid file type.', super.code});
}

// ─── Permission ───────────────────────────────────────────────────────────────

class PermissionDeniedFailure extends Failure {
  const PermissionDeniedFailure({super.message = 'Permission denied.', super.code});
}

class PermissionPermanentlyDeniedFailure extends Failure {
  const PermissionPermanentlyDeniedFailure({super.message = 'Permission permanently denied. Please enable it from settings.'});
}

// ─── Payment ──────────────────────────────────────────────────────────────────

class PaymentFailedFailure extends Failure {
  const PaymentFailedFailure({super.message = 'Payment failed.', super.code});
}

class PaymentCancelledFailure extends Failure {
  const PaymentCancelledFailure({super.message = 'Payment was cancelled.'});
}

// ─── Unknown ──────────────────────────────────────────────────────────────────

class UnknownFailure extends Failure {
  const UnknownFailure({super.message = 'Something went wrong. Please try again.'});
}
