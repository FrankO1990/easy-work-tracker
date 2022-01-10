part of 'easy_work_tracker_bloc.dart';

abstract class EasyWorkTrackerEvent extends Equatable {
  const EasyWorkTrackerEvent();

  @override
  List<Object> get props => [];
}

class GetTrackingPeriodsEvent extends EasyWorkTrackerEvent {
  const GetTrackingPeriodsEvent();

  @override
  List<Object> get props => [];
}

class AddTrackingPeriodEvent extends EasyWorkTrackerEvent {
  final String inputTitle;
  final String inputUsedHourlyRate;

  const AddTrackingPeriodEvent({
    required this.inputTitle,
    required this.inputUsedHourlyRate,
  });

  @override
  List<Object> get props => [inputTitle, inputUsedHourlyRate];
}

class AddWorkItemEvent extends EasyWorkTrackerEvent {
  final int associatedTrackingPeriodId;
  final String inputDescription;
  final String inputEpicDescription;
  final String inputTrackedHours;

  const AddWorkItemEvent({
    required this.associatedTrackingPeriodId,
    required this.inputDescription,
    required this.inputEpicDescription,
    required this.inputTrackedHours,
  });
}
