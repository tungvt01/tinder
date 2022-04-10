import 'package:tinder/core/utils/index.dart';

class RouteModel {
  String routeCd;
  String taskCd;
  int type;
  int status;
  double startLat;
  double startLong;
  double destinationLat;
  double destinationLong;
  String startLocation;
  String destination;
  DateTime startTime;
  DateTime endTime;
  DateTime? startTimeActual;
  DateTime? endTimeActual;
  int distance;
  int expectDuration;
  int price;
  int payment;
  List<String>? mainCarCds;
  List<String>? carCds;
  List<String>? driverCds;

  String? parentRouteCd;
  String? matchedRouteCd;

  DateTime? createdAt;
  DateTime? updatedAt;

  RouteModel(
      {required this.routeCd,
      required this.taskCd,
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
      this.startTimeActual,
      this.endTimeActual,
      required this.expectDuration,
      required this.distance,
      required this.payment,
      required this.price,
      this.createdAt,
      this.updatedAt});

  factory RouteModel.fromJson({required Map<String, dynamic> json}) {
    return RouteModel(
      routeCd: json['route_cd'] ?? '',
      taskCd: json['task_cd'] ?? '',
      type: json['type'] ?? -1,
      status: json['status'] ?? -1,
      startLat: json['start_lat'] ?? 0.0,
      startLong: json['start_long'] ?? 0.0,
      destinationLat: json['destination_lat'] ?? 0.0,
      destinationLong: json['destination_long'] ?? 0.0,
      destination: json['destination'] ?? '',
      startLocation: json['start_location'] ?? '',
      mainCarCds: json['main_car_cds'],
      carCds: json['car_cds'],
      driverCds: json['driver_cds'],
      startTime: json['start_time']?.toString().fromISOStringToDateTime() ??
          DateTime.now(),
      endTime: json['end_time']?.toString().fromISOStringToDateTime() ??
          DateTime.now(),
      startTimeActual:
          json['start_time_actual']?.toString().fromISOStringToDateTime(),
      endTimeActual:
          json['end_time_actual']?.toString().fromISOStringToDateTime(),
      payment: json['payment'] ?? 0,
      price: json['price'] ?? 0,
      distance: json['distance'] ?? 0,
      expectDuration: json['expectDuration'] ?? 0,
      createdAt: json['create_at']?.toString().fromISOStringToDateTime(),
      updatedAt: json['update_at']?.toString().fromISOStringToDateTime(),
    );
  }
}
