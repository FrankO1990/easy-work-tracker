import 'dart:convert';

import 'package:franks_invoice_tool/core/constants/constants.dart';
import 'package:franks_invoice_tool/core/errors/exception.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/data/models/all_tracking_periods_model.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/data/models/tracking_period_model.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/data/models/work_item_model.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/tracking_period.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/work_item.dart';

import 'package:http/http.dart' as http;

abstract class EasyWorkTrackerRemoteDataSource {
  Future<AllTrackingPeriodsModel> addTrackingPeriod(
      TrackingPeriod trackingPeriodModel);

  Future<TrackingPeriod> addWorkItem(WorkItem workItem);

  Future<AllTrackingPeriodsModel> getTrackingPeriods();
}

class EasyWorkTrackerRemoteDataSourceImpl
    implements EasyWorkTrackerRemoteDataSource {
  final http.Client client;

  EasyWorkTrackerRemoteDataSourceImpl({required this.client});

  @override
  Future<AllTrackingPeriodsModel> addTrackingPeriod(
      TrackingPeriod trackingPeriod) async {
    TrackingPeriodModel trackingPeriodModel =
        TrackingPeriodModel.fromTrackingPeriod(trackingPeriod);
    final response = await client.post(ADD_TRACKING_PERIOD_URI,
        body: jsonEncode(trackingPeriodModel.toJson()));
    if (response.statusCode == 200) {
      return AllTrackingPeriodsModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TrackingPeriodModel> addWorkItem(WorkItem workItem) async {
    WorkItemModel workItemModel = WorkItemModel.fromWorkItem(workItem);
    http.Response response = await client.post(ADD_WORK_ITEM_URI,
        body: jsonEncode(workItemModel.toJson()));
    if (response.statusCode == 200) {
      return TrackingPeriodModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<AllTrackingPeriodsModel> getTrackingPeriods() async {
    http.Response response = await client.get(GET_TRACKING_PERIODS_URI);
    if (response.statusCode == 200) {
      return AllTrackingPeriodsModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
