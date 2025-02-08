import 'package:hive_flutter/hive_flutter.dart';

// Model Class
part 'vehicle_model.g.dart';

@HiveType(typeId: 0)
class Vehicle extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int modelYear;

  @HiveField(2)
  final double fuelEfficiency;

  Vehicle({
    required this.name,
    required this.modelYear,
    required this.fuelEfficiency,
  });
}