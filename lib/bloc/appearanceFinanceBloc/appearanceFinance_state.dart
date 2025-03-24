import 'package:equatable/equatable.dart';

abstract class AppearanceFinanceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppearanceFinanceInitial extends AppearanceFinanceState {}

class AppearanceFinanceLoaded extends AppearanceFinanceState {
  final Map<String, List<Map<String, dynamic>>> questionsMap;

  AppearanceFinanceLoaded({required this.questionsMap});

  @override
  List<Object?> get props => [questionsMap];
}

class AppearanceFinanceError extends AppearanceFinanceState {
  final String message;

  AppearanceFinanceError({required this.message});

  @override
  List<Object?> get props => [message];
}
