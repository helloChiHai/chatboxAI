import 'package:equatable/equatable.dart';

abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();
  @override
  List<Object?> get props => [];
}

class FetchSchedule extends ScheduleEvent {}

class SetReminder extends ScheduleEvent {
  final DateTime meetingTime;

  const SetReminder({required this.meetingTime});

  @override
  List<Object?> get props => [meetingTime];
}
