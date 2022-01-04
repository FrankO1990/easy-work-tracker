import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:franks_invoice_tool/main.dart';
import 'package:franks_invoice_tool/prototype/prototype_selected_tracking_period_page.dart';

class PrototypeMainPage extends StatelessWidget {
  const PrototypeMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Easy Work Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 120.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              TrackedPeriodItem(itemText: 'January 2022'),
              TrackedPeriodItem(itemText: 'December 2021'),
              TrackedPeriodItem(itemText: 'November 2021'),
              TrackedPeriodItem(itemText: 'October 2021'),
              TrackedPeriodItem(itemText: 'September 2021'),
              TrackedPeriodItem(itemText: 'August 2021'),
              TrackedPeriodItem(itemText: 'July 2021'),
              TrackedPeriodItem(itemText: 'June 2021'),
              TrackedPeriodItem(itemText: 'May 2021'),
              TrackedPeriodItem(itemText: 'April 2021'),
              TrackedPeriodItem(itemText: 'March 2021'),
              TrackedPeriodItem(itemText: 'February 2021'),
              TrackedPeriodItem(itemText: 'January 2021'),
              TrackedPeriodItem(itemText: 'December 2020'),
              TrackedPeriodItem(itemText: 'November 2020'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('new tracking period'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class TrackedPeriodItem extends StatelessWidget {
  final String itemText;
  const TrackedPeriodItem({
    Key? key,
    required this.itemText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        await Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) =>
                PrototypeSelectedTrackingPeriodPage(titleText: itemText),
            fullscreenDialog: true,
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              itemText,
              style: const TextStyle(fontSize: 24, color: MAIN_TEXT_COLOR),
            ),
          ),
          const Expanded(
            child: Text(
              '33.300€',
              style: TextStyle(fontSize: 24, color: MAIN_TEXT_COLOR),
            ),
          )
        ],
      ),
    );
  }
}
