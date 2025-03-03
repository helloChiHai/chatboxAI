import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_flutter/bloc/scheduleBloc/schedule_bloc.dart';
import 'package:stock_flutter/bloc/scheduleBloc/schedule_event.dart';
import 'package:stock_flutter/bloc/scheduleBloc/schedule_state.dart';

class MeetingPage extends StatefulWidget {
  const MeetingPage({super.key});

  @override
  State<MeetingPage> createState() => _MeetingPageState();
}

class _MeetingPageState extends State<MeetingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lịch Nhắc Họp")),
      body: BlocBuilder<ScheduleBloc, ScheduleState>(
        builder: (context, state) {
          if (state is ScheduleInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ScheduleLoaded) {
            return ListView.builder(
              itemCount: state.schedules.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("Lịch họp: ${state.schedules[index]}"),
                );
              },
            );
          } else {
            return const Center(child: Text("Không có lịch họp"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ScheduleBloc>().add(FetchSchedule());
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
