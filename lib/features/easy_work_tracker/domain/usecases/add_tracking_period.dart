import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:franks_invoice_tool/core/errors/failure.dart';
import 'package:franks_invoice_tool/core/usecases/usecase.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/all_tracking_periods.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/tracking_period.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/repositories/easy_work_tracker_repository.dart';

class AddTrackingPeriod
    extends UseCase<AllTrackingPeriods, TrackingPeriodParams> {
  final EasyWorkTrackerRepository repository;

  AddTrackingPeriod(this.repository);
  @override
  Future<Either<Failure, AllTrackingPeriods>> call(
      TrackingPeriodParams params) async {
    return await repository.addTrackingPeriod(params.trackingPeriod);
  }
}

class TrackingPeriodParams extends Equatable {
  final TrackingPeriod trackingPeriod;

  const TrackingPeriodParams({required this.trackingPeriod});
  @override
  List<Object?> get props => [trackingPeriod];
}
