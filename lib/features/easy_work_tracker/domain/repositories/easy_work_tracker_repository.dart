import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:franks_invoice_tool/core/errors/failure.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/all_tracking_periods.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/tracking_period.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/work_item.dart';

abstract class EasyWorkTrackerRepository {
  Future<Either<Failure, AllTrackingPeriods>> getTrackingPeriods();
  Future<Either<Failure, AllTrackingPeriods>> addTrackingPeriod(
      TrackingPeriod trackingPeriod);
  Future<Either<Failure, TrackingPeriod>> addWorkItem(WorkItem workItem);
}
