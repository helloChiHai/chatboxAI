import 'package:equatable/equatable.dart';

abstract class ModalEvent extends Equatable {
  const ModalEvent();

  @override
  List<Object?> get props => [];
}

class LoadModalState extends ModalEvent {}

class ChangeModal extends ModalEvent {
  final String modalName;

  const ChangeModal(this.modalName);

  @override
  List<Object?> get props => [modalName];
}
