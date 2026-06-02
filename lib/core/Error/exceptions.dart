import 'package:equatable/equatable.dart';

class BadRequestException extends ServerException {
  const BadRequestException([message]) : super('Bad Request');
}

class CacheException implements Exception {}

class ConflictException extends ServerException {
  const ConflictException([message]) : super('Conflict Occurred');
}

class FetchDataException extends ServerException {
  const FetchDataException([message]) : super('Error During Communcation');
}

class InternalServerErrorException extends ServerException {
  const InternalServerErrorException([message])
      : super('Internal Server Error');
}

class NoInterNetConnectionException extends ServerException {
  const NoInterNetConnectionException([message])
      : super('No Internet Connection');
}

class NotFoundException extends ServerException {
  const NotFoundException([message]) : super('Request Info Not Found');
}

class ServerException extends Equatable implements Exception {
  final String? message;

  const ServerException([this.message]);
  @override
  List<Object?> get props => [message];
  @override
  String toString() => '$message';
}

class UnauthorizedException extends ServerException {
  const UnauthorizedException([message]) : super('Unauthorized');
}
