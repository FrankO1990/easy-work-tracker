import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:franks_invoice_tool/core/errors/failure.dart';
import 'package:franks_invoice_tool/core/usecases/usecase.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/tracking_period.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/work_item.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/repositories/easy_work_tracker_repository.dart';

class AddWorkItem extends UseCase<TrackingPeriod, Params> {
  final EasyWorkTrackerRepository repository;

  AddWorkItem(this.repository);

  @override
  Future<Either<Failure, TrackingPeriod>> call(Params params) async {
    return await repository.addWorkItem(params.workItem);
  }
}

class Params extends Equatable {
  final WorkItem workItem;

  const Params({required this.workItem});

  @override
  List<Object?> get props => [workItem];
}
