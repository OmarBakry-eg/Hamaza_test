// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  final String message;
  const Failure({
    required this.message,
  });
  @override
  List<Object?> get props => [message];
}

final class OfflineFailure extends Failure {
  const OfflineFailure({required super.message});
}

final class ServerFailure extends Failure {
  const ServerFailure({required super.message});
}

final class EmptyCacheFailure extends Failure {
  const EmptyCacheFailure({required super.message});
}
