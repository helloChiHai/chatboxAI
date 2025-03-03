import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:stock_flutter/bloc/scheduleBloc/schedule_event.dart';
import 'package:stock_flutter/bloc/scheduleBloc/schedule_state.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc() : super(ScheduleInitial()) {
    tz.initializeTimeZones();
    final location = tz.getLocation('Asia/Ho_Chi_Minh');
    tz.setLocalLocation(location);

    on<FetchSchedule>(onFetchSchedule);
    on<SetReminder>(onSetRemider);
  }

  Future<void> onFetchSchedule(
      FetchSchedule event, Emitter<ScheduleState> emit) async {
    List<DateTime> schedules = [
      DateTime.now().add(const Duration(minutes: 2)) // lich hop sau 15p
    ];

    emit(ScheduleLoaded(schedules: schedules));

    for (var meeting in schedules) {
      add(SetReminder(meetingTime: meeting));
    }
  }

  Future<void> onSetRemider(
      SetReminder event, Emitter<ScheduleState> emit) async {
    DateTime meetingTime = event.meetingTime;
    DateTime remindTime = meetingTime.subtract(const Duration(minutes: 1));

    scheduleNotification(
        meetingTime, "Tới giờ hợp!", "Cuộc họp bắt đầu ngay bây giờ.");
    scheduleNotification(
        remindTime, "Nhắc lịch hợp!", "Còn 1 phút nữa tới giờ họp.");
  }

  Future<void> scheduleNotification(
      DateTime scheduleTime, String title, String body) async {
    print("Đặt thông báo: $title vào lúc $scheduleTime"); // Kiểm tra log

    var androidDetails = const AndroidNotificationDetails(
      'schedule_channel',
      'Lịch nhắc',
      channelDescription: 'Kênh thông báo cho lịch hẹn',
      importance: Importance.high,
      priority: Priority.high,
    );

    var iosDetails = const DarwinNotificationDetails();
    var platformDetail =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    // int notificationId = scheduleTime.hashCode.abs() %
    //     2147483647; // Giới hạn trong phạm vi 32-bit
    int notificationId =
        scheduleTime.millisecondsSinceEpoch.remainder(2147483647);

    await flutterLocalNotificationsPlugin.zonedSchedule(notificationId, title,
        body, tz.TZDateTime.from(scheduleTime, tz.local), platformDetail,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);

    print("Đã đặt thông báo: $title");
  }
}
