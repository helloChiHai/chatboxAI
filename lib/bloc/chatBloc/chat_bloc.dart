import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_flutter/bloc/chatBloc/chat_event.dart';
import 'package:stock_flutter/bloc/chatBloc/chat_state.dart';
import 'package:stock_flutter/repositories/chat_repository.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;

  ChatBloc(this.chatRepository) : super(ChatState()) {
    on<SendMessage>(onSendMessage);
  }

  Future<void> onSendMessage(SendMessage event, Emitter<ChatState> emit) async {
    emit(state.copyWith());

    try {
      final response = await chatRepository.sendMessage(event.message);
      emit(state.copyWith(
          messages: [...state.messages, ...response], isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }
}
