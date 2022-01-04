import 'package:franks_invoice_tool/core/errors/exception.dart';
import 'package:franks_invoice_tool/core/util/network_info.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/data/datasources/easy_work_tracker_remote_data_source.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/work_item.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/tracking_period.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/all_tracking_periods.dart';
import 'package:franks_invoice_tool/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/repositories/easy_work_tracker_repository.dart';

class EasyWorkTrackerRepositoryImpl implements EasyWorkTrackerRepository {
  final NetworkInfo networkInfo;
  final EasyWorkTrackerRemoteDataSource remoteDataSource;

  EasyWorkTrackerRepositoryImpl(
      {required this.networkInfo, required this.remoteDataSource});
  @override
  Future<Either<Failure, AllTrackingPeriods>> addTrackingPeriod(
      TrackingPeriod trackingPeriod) async {
    if (!await networkInfo.isConnected) {
      return Left(DeviceOfflineFailure());
    }
    try {
      final result = await remoteDataSource.addTrackingPeriod(trackingPeriod);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    } catch (exception) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, TrackingPeriod>> addWorkItem(WorkItem workItem) async {
    if (!await networkInfo.isConnected) {
      return Left(DeviceOfflineFailure());
    }
    try {
      final result = await remoteDataSource.addWorkItem(workItem);
      return Right(result);
    } on ServerException {
      return left(ServerFailure());
    } catch (exception) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, AllTrackingPeriods>> getTrackingPeriods() async {
    if (!await networkInfo.isConnected) {
      return Left(DeviceOfflineFailure());
    }
    try {
      final result = await remoteDataSource.getTrackingPeriods();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    } catch (exception) {
      return Left(UnexpectedFailure());
    }
  }
}
