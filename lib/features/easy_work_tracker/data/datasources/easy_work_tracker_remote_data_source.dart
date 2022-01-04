import 'package:franks_invoice_tool/features/easy_work_tracker/data/models/all_tracking_periods_model.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/data/models/tracking_period_model.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/data/models/work_item_model.dart';

abstract class EasyWorkTrackerRemoteDataSource {
  Future<AllTrackingPeriodsModel> addTrackingPeriod(
      TrackingPeriodModel trackingPeriodModel);

  Future<TrackingPeriodModel> addWorkItem(WorkItemModel workItemModel);

  Future<AllTrackingPeriodsModel> getTrackingPeriods();
}
