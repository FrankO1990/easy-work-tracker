import 'package:equatable/equatable.dart';
import 'package:franks_invoice_tool/features/easy_work_tracker/domain/entities/work_item.dart';

class TrackingPeriod extends Equatable {
  final String title;
  final int usedHourlyRateInEuro;
  final List<WorkItem> trackedWorkItems;

  int get totalTrackedHours {
    int totalTrackedHours = 0;
    for (int i = 0; i < trackedWorkItems.length; i++) {
      totalTrackedHours += trackedWorkItems[i].trackedHours;
    }
    return totalTrackedHours;
  }

  int get totalInvoiceAmount {
    return totalTrackedHours * usedHourlyRateInEuro;
  }

  const TrackingPeriod(
      {required this.title,
      required this.usedHourlyRateInEuro,
      required this.trackedWorkItems});

  @override
  List<Object?> get props => [title, usedHourlyRateInEuro, trackedWorkItems];
}
