import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_flutter/bloc/changeModal/changeModal_event.dart';
import 'package:stock_flutter/bloc/changeModal/changeModal_state.dart';
import 'package:stock_flutter/repositories/changeModal_repository.dart';
import 'package:stock_flutter/services/service_locator.dart';

class ChangeModalBloc extends Bloc<ModalEvent, ModalState> {
  final ChangeModalRepository modalRepository;

  ChangeModalBloc({required this.modalRepository}) : super(const ModalState()) {
    on<LoadModalState>(_onLoadModalState);
    on<ChangeModal>(_onChangeModal);
  }

  Future<void> _onLoadModalState(
      LoadModalState event, Emitter<ModalState> emit) async {
    final lastModal = await locator<ChangeModalRepository>().getCurrentModal();
    print('get currentmodal: $lastModal');
    emit(ModalState(currentModal: lastModal));
  }

  Future<void> _onChangeModal(
      ChangeModal event, Emitter<ModalState> emit) async {
    await locator<ChangeModalRepository>().saveModal(event.modalName);
    print('event.modalName: ${event.modalName}');
    emit(ModalState(currentModal: event.modalName));
  }
}
