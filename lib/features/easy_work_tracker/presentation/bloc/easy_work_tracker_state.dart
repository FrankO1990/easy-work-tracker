part of 'easy_work_tracker_bloc.dart';

abstract class EasyWorkTrackerState extends Equatable {
  const EasyWorkTrackerState();

  @override
  List<Object> get props => [];
}

class Empty extends EasyWorkTrackerState {}

class Error extends EasyWorkTrackerState {
  final String message;

  const Error({required this.message});
}

class Loading extends EasyWorkTrackerState {}

class TrackingPeriodsLoaded extends EasyWorkTrackerState {
  final AllTrackingPeriods allTrackingPeriods;

  const TrackingPeriodsLoaded({required this.allTrackingPeriods});

  @override
  List<Object> get props => [allTrackingPeriods];
}

class WorkItemAdded extends EasyWorkTrackerState {
  final TrackingPeriod trackingPeriod;

  const WorkItemAdded({required this.trackingPeriod});

  @override
  List<Object> get props => [trackingPeriod];
}
