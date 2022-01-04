import 'package:equatable/equatable.dart';

class WorkItem extends Equatable {
  final String description;
  final String epicDescription;
  final int trackedHours;

  const WorkItem({
    required this.description,
    required this.epicDescription,
    required this.trackedHours,
  });

  @override
  List<Object?> get props => [description, trackedHours];
}
