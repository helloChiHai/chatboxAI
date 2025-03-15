import 'package:equatable/equatable.dart';

class ModalState extends Equatable {
  final String? currentModal;

  const ModalState({this.currentModal});

  @override
  List<Object?> get props => [currentModal];
}
