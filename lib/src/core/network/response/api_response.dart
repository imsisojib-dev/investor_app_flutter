import 'package:equatable/equatable.dart';

import 'base_response.dart';

class ApiResponse<T> extends Equatable {
  final bool success;
  final String message;
  final T? data;
  final Map<String, dynamic>? errors;
  final PaginationMeta? pagination;

  const ApiResponse({
    required this.success,
    required this.message,
    this.data,
    this.errors,
    this.pagination,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromJsonT,
  ) {
    return ApiResponse<T>(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'])
          : null,
      errors: json['errors'] as Map<String, dynamic>?,
      pagination: json['pagination'] != null
          ? PaginationMeta.fromJson(json['pagination'])
          : null,
    );
  }

  bool get hasData => data != null;
  bool get hasPagination => pagination != null;
  bool get hasErrors => errors != null && errors!.isNotEmpty;

  @override
  List<Object?> get props => [success, message, data, errors, pagination];
}