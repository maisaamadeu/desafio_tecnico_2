// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class LocalStorageFailure extends Failure {
  final String message;

  LocalStorageFailure({
    required this.message,
  });

  @override
  List<Object?> get props => [];
}
