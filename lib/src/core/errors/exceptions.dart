abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic data;

  const AppException({required this.message, this.code, this.data});

  @override
  String toString() => 'AppException(code: $code, message: $message)';
}

// ─── Network ──────────────────────────────────────────────────────────────────

class NetworkException extends AppException {
  const NetworkException({super.message = 'No internet connection.', super.code});
}

class TimeoutException extends AppException {
  const TimeoutException({super.message = 'Request timed out.', super.code});
}

class RequestCancelledException extends AppException {
  const RequestCancelledException({super.message = 'Request was cancelled.', super.code});
}

// ─── HTTP Status ──────────────────────────────────────────────────────────────

class BadRequestException extends AppException {
  const BadRequestException({super.message = 'Bad request.', super.code});
}

class UnauthorizedException extends AppException {
  const UnauthorizedException({super.message = 'Unauthorized.', super.code});
}

class ForbiddenException extends AppException {
  const ForbiddenException({super.message = 'Access forbidden.', super.code});
}

class NotFoundException extends AppException {
  const NotFoundException({super.message = 'Resource not found.', super.code});
}

class ConflictException extends AppException {
  const ConflictException({super.message = 'Conflict occurred.', super.code});
}

class ValidationException extends AppException {
  final Map<String, dynamic>? errors;

  const ValidationException({super.message = 'Validation failed.', super.code, this.errors});

  // returns first error message for a specific field
  String? fieldError(String field) {
    final fieldErrors = errors?[field];
    if (fieldErrors is List && fieldErrors.isNotEmpty) {
      return fieldErrors.first as String?;
    }
    return null;
  }

  // flattens all field errors into a single string
  String get allErrors {
    if (errors == null) return message;
    return errors!.entries.map((e) => '${e.key}: ${(e.value as List).join(', ')}').join('\n');
  }

  @override
  String toString() => 'ValidationException(errors: $errors)';
}

class TooManyRequestsException extends AppException {
  const TooManyRequestsException({super.message = 'Too many requests. Please slow down.', super.code});
}

class ServerException extends AppException {
  const ServerException({super.message = 'Internal server error. Please try again later.', super.code});
}

class UnknownException extends AppException {
  const UnknownException({super.message = 'Something went wrong. Please try again.', super.code});
}

// ─── Cache ────────────────────────────────────────────────────────────────────

class CacheException extends AppException {
  const CacheException({super.message = 'Cache error occurred.', super.code});
}

class CacheNotFoundException extends AppException {
  const CacheNotFoundException({super.message = 'No cached data found.', super.code});
}

class CacheExpiredException extends AppException {
  const CacheExpiredException({super.message = 'Cached data has expired.', super.code});
}

// ─── Auth ─────────────────────────────────────────────────────────────────────

class TokenExpiredException extends AppException {
  const TokenExpiredException({super.message = 'Session expired. Please login again.', super.code});
}

class TokenNotFoundException extends AppException {
  const TokenNotFoundException({super.message = 'Auth token not found.', super.code});
}

class RefreshTokenExpiredException extends AppException {
  const RefreshTokenExpiredException({super.message = 'Session expired. Please login again.', super.code});
}

// ─── Storage ──────────────────────────────────────────────────────────────────

class StorageException extends AppException {
  const StorageException({super.message = 'Storage error occurred.', super.code});
}

class StorageReadException extends AppException {
  const StorageReadException({super.message = 'Failed to read from storage.', super.code});
}

class StorageWriteException extends AppException {
  const StorageWriteException({super.message = 'Failed to write to storage.', super.code});
}

// ─── Media ────────────────────────────────────────────────────────────────────

class FileSizeExceededException extends AppException {
  final int maxSizeMb;

  const FileSizeExceededException({required this.maxSizeMb, required super.message, super.code});
}

class InvalidFileTypeException extends AppException {
  final List<String> allowedTypes;

  InvalidFileTypeException({required this.allowedTypes, super.code}) : super(message: 'Invalid file type. Allowed: ${allowedTypes.join(', ')}');
}

class FileNotFoundException extends AppException {
  const FileNotFoundException({super.message = 'File not found.', super.code});
}

// ─── Platform ─────────────────────────────────────────────────────────────────

class PermissionDeniedException extends AppException {
  const PermissionDeniedException({super.message = 'Permission denied.', super.code});
}

class PermissionPermanentlyDeniedException extends AppException {
  const PermissionPermanentlyDeniedException({super.message = 'Permission permanently denied. Please enable it from settings.', super.code});
}

class BiometricException extends AppException {
  const BiometricException({super.message = 'Biometric authentication failed.', super.code});
}

class BiometricNotAvailableException extends AppException {
  const BiometricNotAvailableException({super.message = 'Biometric authentication is not available on this device.', super.code});
}

// ─── Payment ──────────────────────────────────────────────────────────────────

class PaymentFailedException extends AppException {
  const PaymentFailedException({super.message = 'Payment failed. Please try again.', super.code, super.data});
}

class PaymentCancelledException extends AppException {
  const PaymentCancelledException({super.message = 'Payment was cancelled.', super.code});
}
