import 'package:equatable/equatable.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/tracking_period.dart';

class AllTrackingPeriods extends Equatable {
  final List<TrackingPeriod> trackingPeriods;

  const AllTrackingPeriods({required this.trackingPeriods});

  @override
  List<Object?> get props => [trackingPeriods];
}
