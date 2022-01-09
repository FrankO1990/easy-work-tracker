import 'package:equatable/equatable.dart';

class WorkItem extends Equatable {
  final int id;
  final int associatedTrackingPeriodId;
  final String description;
  final String epicDescription;
  final int trackedHours;

  const WorkItem({
    required this.id,
    required this.associatedTrackingPeriodId,
    required this.description,
    required this.epicDescription,
    required this.trackedHours,
  });

  @override
  List<Object?> get props => [id, associatedTrackingPeriodId, description, epicDescription, trackedHours];
}
