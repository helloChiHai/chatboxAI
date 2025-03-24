import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_flutter/bloc/questions/questions_event.dart';
import 'package:stock_flutter/bloc/questions/questions_state.dart';
import 'package:stock_flutter/repositories/question_repository.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  final QuestionRepository repository;

  QuestionsBloc({required this.repository}) : super(QuestionInitial()) {
    on<SaveQuestionsEvent>(onSaveQuestion);
    on<LoadQuestionEvent>(onLoadedQuestion);
    on<ClearQuestionEvent>(onClearQuestion);
  }

  Future<void> onSaveQuestion(
      SaveQuestionsEvent event, Emitter<QuestionsState> emit) async {
    await repository.saveQuestions(event.questions, event.key);
    emit(QuestionLoaded(questions: event.questions, key: event.key));
  }

  Future<void> onLoadedQuestion(
      LoadQuestionEvent event, Emitter<QuestionsState> emit) async {
    try {
      final questions = await repository.getQuestions(event.key);
      emit(QuestionLoaded(questions: questions, key: event.key));
    } catch (e) {
      emit(QuestionError(message: 'Lỗi khi tải dữ liệu'));
    }
  }

  Future<void> onClearQuestion(
      ClearQuestionEvent event, Emitter<QuestionsState> emit) async {
    await repository.clearQuestion(event.key);
    emit(QuestionLoaded(questions: const [], key: event.key));
  }
}
