class FacilityModel {
  final int id;
  final String description;
  final String name;
  final String location;
  final String booths;
  final String total_task;
  final String pending_task;
  final String time;
  final String status;

  const FacilityModel({
    required this.id,
    required this.description,
    required this.name,
    required this.location,
    required this.booths,
    required this.total_task,
    required this.pending_task,
    required this.time,
    required this.status,
  });
}
