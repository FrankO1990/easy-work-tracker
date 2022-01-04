import 'package:franks_invoice_tool/features/easy_work_tracker/data/models/all_tracking_periods_model.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/data/models/tracking_period_model.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/tracking_period.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/work_item.dart';

abstract class EasyWorkTrackerRemoteDataSource {
  Future<AllTrackingPeriodsModel> addTrackingPeriod(
      TrackingPeriod trackingPeriodModel);

  Future<TrackingPeriodModel> addWorkItem(WorkItem workItem);

  Future<AllTrackingPeriodsModel> getTrackingPeriods();
}
