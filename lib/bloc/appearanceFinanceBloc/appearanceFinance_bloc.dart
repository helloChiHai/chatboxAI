import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_flutter/bloc/appearanceFinanceBloc/appearanceFinance_event.dart';
import 'package:stock_flutter/bloc/appearanceFinanceBloc/appearanceFinance_state.dart';
import 'package:stock_flutter/repositories/appearanceFinance_repository.dart';

class AppearanceFinanceBloc
    extends Bloc<AppearanceFinanceEvent, AppearanceFinanceState> {
  final AppearanceFinanceRepository repository;
  Map<String, List<Map<String, dynamic>>> _questionsMap = {};

  AppearanceFinanceBloc({required this.repository})
      : super(AppearanceFinanceInitial()) {
    on<SaveAppearanceFinanceEvent>(onSaveAppearanceFinance);
    on<LoadAppearanceFinanceEvent>(onLoadedQuestion);
    on<ClearAppearanceFinanceEvent>(onClearQuestion);
  }

  Future<void> onSaveAppearanceFinance(SaveAppearanceFinanceEvent event,
      Emitter<AppearanceFinanceState> emit) async {
    await repository.saveQuestions(event.questions, event.key);
    _questionsMap[event.key] = event.questions;
    emit(AppearanceFinanceLoaded(questionsMap: Map.from(_questionsMap)));
  }

  Future<void> onLoadedQuestion(LoadAppearanceFinanceEvent event,
      Emitter<AppearanceFinanceState> emit) async {
    try {
      final questions = await repository.getQuestions(event.key);
      _questionsMap[event.key] = questions;
      emit(AppearanceFinanceLoaded(questionsMap: Map.from(_questionsMap)));
    } catch (e) {
      emit(AppearanceFinanceError(message: 'Lỗi khi tải dữ liệu'));
    }
  }

  Future<void> onClearQuestion(ClearAppearanceFinanceEvent event,
      Emitter<AppearanceFinanceState> emit) async {
    await repository.clearQuestion(event.key);
    _questionsMap[event.key] = [];
    emit(AppearanceFinanceLoaded(questionsMap: Map.from(_questionsMap)));
  }
}
