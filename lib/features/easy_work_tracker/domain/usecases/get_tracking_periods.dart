import 'package:franks_invoice_tool/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:franks_invoice_tool/core/usecases/usecase.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/all_tracking_periods.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/repositories/easy_work_tracker_repository.dart';

class GetTrackingPeriods extends UseCase<AllTrackingPeriods, NoParams> {
  final EasyWorkTrackerRepository repository;

  GetTrackingPeriods(this.repository);

  @override
  Future<Either<Failure, AllTrackingPeriods>> call(params) async {
    return await repository.getTrackingPeriods();
  }
}
