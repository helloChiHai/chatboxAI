import 'package:equatable/equatable.dart';

abstract class AppearanceFinanceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SaveAppearanceFinanceEvent extends AppearanceFinanceEvent {
  final List<Map<String, dynamic>> questions;
  final String key;

  SaveAppearanceFinanceEvent({required this.questions, required this.key});

  @override
  List<Object?> get props => [questions];
}

class LoadAppearanceFinanceEvent extends AppearanceFinanceEvent {
  final String key;

  LoadAppearanceFinanceEvent({required this.key});

  @override
  List<Object?> get props => [key];
}

class ClearAppearanceFinanceEvent extends AppearanceFinanceEvent {
  final String key;

  ClearAppearanceFinanceEvent({required this.key});

  @override
  List<Object?> get props => [key];
}
