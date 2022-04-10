import 'package:tinder/core/utils/index.dart';

/*
1: đợi admin approve
2: đợi driver approve
3: approved
4: start
5: completed
8. driver reject
9. admin reject
10. cancel
*/
enum TaskStatus {
  notSpecify, //0
  waitAdminApprove, //1
  waitDriverApprove, //2
  approved, //3
  start, //4
  readyToStart, // 6
  completed, //5
  driverRejected, //8
  adminRejected, //9
  canceled, //10
  taskOverCompletionTime, //11
  taskOverApproveTime, //12
}
TaskStatus getTaskStatusByValue({required int value}) {
  switch (value) {
    case 1:
      return TaskStatus.waitAdminApprove;
    case 2:
      return TaskStatus.waitDriverApprove;
    case 3:
      return TaskStatus.approved;
    case 4:
      return TaskStatus.start;
    case 6:
      return TaskStatus.readyToStart;
    case 5:
      return TaskStatus.completed;
    case 8:
      return TaskStatus.driverRejected;
    case 9:
      return TaskStatus.adminRejected;
    case 10:
      return TaskStatus.canceled;
    case 11:
      return TaskStatus.taskOverCompletionTime;
    case 12:
      return TaskStatus.taskOverApproveTime;
    default:
      return TaskStatus.notSpecify;
  }
}

class TaskModel {
  String taskCd;
  String? partnerCd;
  int type;
  TaskStatus status;
  double startLat;
  double startLong;
  double destinationLat;
  double destinationLong;
  String startLocation;
  String destination;
  List<String>? mainCarCds;
  List<String>? carCds;
  List<String>? driverCds;
  DateTime startTime;
  DateTime endTime;
  String createdAdminCd;
  DateTime? createdAt;
  DateTime? updatedAt;

  TaskModel(
      {required this.taskCd,
      this.partnerCd,
      required this.type,
      required this.status,
      required this.startLat,
      required this.startLong,
      required this.destinationLat,
      required this.destinationLong,
      required this.startLocation,
      required this.destination,
      this.mainCarCds,
      this.carCds,
      this.driverCds,
      required this.startTime,
      required this.endTime,
      required this.createdAdminCd,
      this.createdAt,
      this.updatedAt});

  factory TaskModel.fromJson({required Map<String, dynamic> json}) {
    return TaskModel(
      taskCd: json['task_cd'] ?? '',
      partnerCd: json['partner_cd'],
      type: json['type'] ?? -1,
      status: getTaskStatusByValue(value: json['status'] ?? -1),
      startLat: json['start_lat'] ?? 0.0,
      startLong: json['start_long'] ?? 0.0,
      destinationLat: json['destination_lat'] ?? 0.0,
      destinationLong: json['destination_long'] ?? 0.0,
      startLocation: json['start_location'] ?? '',
      destination: json['destination'] ?? '',
      mainCarCds: json['main_car_cds'],
      carCds: json['car_cds'],
      driverCds: json['driver_cds'],
      startTime: json['start_time']?.toString().fromISOStringToDateTime() ??
          DateTime.now(),
      endTime: json['end_time']?.toString().fromISOStringToDateTime() ??
          DateTime.now(),
      createdAdminCd: json['created_admin_cd'] ?? '',
      createdAt: json['create_at']?.toString().fromISOStringToDateTime(),
      updatedAt: json['update_at']?.toString().fromISOStringToDateTime(),
    );
  }
}

/*
task_cd
partner_cd
type
status
start_lat
start_long
destination_lat
destination_long
start_location
destination
main_car_cds
car_cds
driver_cds
start_time
end_time
created_admin_cd
created_at
updated_at
 */