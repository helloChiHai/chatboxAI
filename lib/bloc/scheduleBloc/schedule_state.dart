import 'package:equatable/equatable.dart';

abstract class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object?> get props => [];
}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  final List<DateTime> schedules;

  const ScheduleLoaded({required this.schedules});

  @override
  List<Object?> get props => [schedules];
}
